%{
#include "node.h"
#include "calc.tab.h"
%}
%%
[ \t\n]+ { /* skip whitespace */ }
#.*     {}
[0-9]*\.[0-9]+ { yylval.ival = atoi(yytext); return FNUM; }
[0-9]+ { yylval.ival = atoi(yytext); return NUM; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return TIMES; }
"/" { return DIVIDE; }
"^" { return POWER; } 
"(" { return LPAREN; }
")" { return RPAREN; }
. { fprintf(stderr, "Unknown character: %s\n", yytext); }
%%
int yywrap(void) { return 1; }