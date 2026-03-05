%option noyywrap yylineno nodefault

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Hash table con chaining (listas por bucket) */
#define NHASH 4096

typedef struct LineNode {
    int line;
    struct LineNode *next;
} LineNode;

typedef struct Sym {
    char *name;
    LineNode *lines;
    struct Sym *next; /* chaining */
} Sym;

static Sym *table[NHASH];

static unsigned long hash_str(const char *s) {
    /* djb2 */
    unsigned long h = 5381;
    int c;
    while ((c = (unsigned char)*s++)) {
        h = ((h << 5) + h) + (unsigned long)c;
    }
    return h % NHASH;
}

static void add_line(LineNode **lst, int line) {
    /* evita repetir la misma línea seguida (por ejemplo: value value en la misma línea) */
    if (*lst && (*lst)->line == line) return;

    LineNode *n = (LineNode*)malloc(sizeof(LineNode));
    if (!n) { perror("malloc"); exit(1); }
    n->line = line;
    n->next = *lst;
    *lst = n;
}

static Sym *lookup_or_insert(const char *name) {
    unsigned long h = hash_str(name);
    for (Sym *s = table[h]; s; s = s->next) {
        if (strcmp(s->name, name) == 0) return s;
    }

    /* No existe: insertamos un nodo nuevo (no hay “lleno”: chaining crece) */
    Sym *ns = (Sym*)malloc(sizeof(Sym));
    if (!ns) { perror("malloc"); exit(1); }
    ns->name = strdup(name);
    if (!ns->name) { perror("strdup"); exit(1); }
    ns->lines = NULL;
    ns->next = table[h];
    table[h] = ns;
    return ns;
}

static void dump(void) {
    for (int i = 0; i < NHASH; i++) {
        for (Sym *s = table[i]; s; s = s->next) {
            printf("%s:", s->name);
            for (LineNode *ln = s->lines; ln; ln = ln->next) {
                printf(" %d", ln->line);
            }
            printf("\n");
        }
    }
}
%}

/* Identificador estilo C */
ID  [A-Za-z_][A-Za-z0-9_]*

%%

{ID} {
    Sym *sym = lookup_or_insert(yytext);
    add_line(&sym->lines, yylineno);
}

\n  { yylineno++; }
.   { /* ignore */ }

%%

int main(int argc, char **argv) {
    if (argc == 2) {
        FILE *f = fopen(argv[1], "r");
        if (!f) { perror("fopen"); return 1; }
        yyin = f;
    }
    yylex();
    dump();
    return 0;
}
