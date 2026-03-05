%option noyywrap yylineno

%%

^"#"[ \t]*"include"[ \t]*[\"<] {
    printf("Include detected\n");
}

^[^\n]+ {
    printf("%4d %s", yylineno, yytext);
}

\n {
    printf("\n");
    yylineno++;
}

. {
    ECHO;
}

%%

int main() {
    yylex();
    return 0;
}
