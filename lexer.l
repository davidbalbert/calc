%{
  #include <stdlib.h>
  extern void yyerror(char *);
  #include "y.tab.h"
%}

%%

[a-zA-Z_][a-zA-Z_\d]*     {
                            yylval.string = strdup(yytext);
                            return VARIABLE;
                          }

[0-9]+                    {
                            yylval.integer = atoi(yytext);
                            return INTEGER;
                          }

[-+()=/*\n^]              { return *yytext; }

[ \t]                     ; // skip whitespace

.                         yyerror("invalid character");

%%

int yywrap(void) {
  return 1;
}
