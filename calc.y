%{
  #include <stdio.h>
  int yylex(void);
  void yyerror(char *);
  int sym[26];
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'
%left UMINUS

%%

program:
        program expr '\n'      { printf("%d\n", $2); }
        |
        ;

expr:
        INTEGER
        | VARIABLE                  { $$ = sym[$1]; }
        | expr '+' expr             { $$ = $1 + $3; }
        | expr '-' expr             { $$ = $1 - $3; }
        | expr '*' expr             { $$ = $1 * $3; }
        | expr '/' expr             { $$ = $1 / $3; }
        | '-' expr %prec UMINUS     { $$ = -$2; }
        | VARIABLE '=' expr         { $$ = sym[$1] = $3; }
        | '(' expr ')'              { $$ = $2; }
        ;

%%

void yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
}

int main(void) {
  yyparse();
  return 0;
}
