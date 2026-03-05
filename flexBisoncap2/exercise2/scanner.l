%option noyywrap

%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

int words = 0;
%}

WORD [a-zA-Z]+

%%

{WORD} {
    words++;
}

.|\n ;

%%

int main() {
    yylex();
    printf("Total words: %d\n", words);
    return 0;
}
