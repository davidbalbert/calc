%{
  #include <stdio.h>
  #include <string.h>
  #include <math.h>
  #include <unistd.h>

  #define TRUE 1
  #define FALSE 0
  #define BOOL int

  #define BUFFER_SIZE 1024

  struct yy_buffer_state;
  typedef struct yy_buffer_state *YY_BUFFER_STATE;

  extern int yylex(void);
  extern void yyerror(char *);
  extern YY_BUFFER_STATE yy_scan_string(const char *);
  extern void yy_delete_buffer(YY_BUFFER_STATE);
  int sym[26];
%}

%token INTEGER VARIABLE

%right '='
%left '+' '-'
%left '*' '/'
%right '^'
%left UMINUS

%%

program:
        program expr '\n'      { printf("%d\n", $2); }
        |
        ;

expr:
        expr '+' expr             { $$ = $1 + $3; }
        | expr '-' expr             { $$ = $1 - $3; }
        | expr '*' expr             { $$ = $1 * $3; }
        | expr '/' expr             { $$ = $1 / $3; }
        | expr '^' expr             { $$ = pow($1, $3); }
        | '-' expr %prec UMINUS     { $$ = -$2; }
        | VARIABLE '=' expr         { $$ = sym[$1] = $3; }
        | '(' expr ')'              { $$ = $2; }
        | VARIABLE                  { $$ = sym[$1]; }
        | INTEGER
        ;

%%

void yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
}

int main(int argc, const char *argv[]) {

  BOOL from_stdin = FALSE;

  if (argc > 1) {
    if (strcmp(argv[1], "-") == 0) {
      from_stdin = TRUE;
    } else {
      printf("error: I don't know how to read from files yet\n");
      return 1;
    }
  } else if (!isatty(fileno(stdin))) {
    from_stdin = TRUE;
  }

  if (from_stdin) {
    yyparse();
  } else {
    char str[BUFFER_SIZE];
    YY_BUFFER_STATE buffer;

    while (TRUE) {
      printf(">> ");
      if (fgets(str, BUFFER_SIZE, stdin)) {
        printf("=> ");
        buffer = yy_scan_string(str);
        yyparse();
        yy_delete_buffer(buffer);
      }
    }
  }
  return 0;
}
