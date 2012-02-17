%{
  #include <stdio.h>
  #include <string.h>
  #include <math.h>
  #include <unistd.h>

  #include "khash.h"

  #define TRUE 1
  #define FALSE 0
  #define BOOL int

  #define BUFFER_SIZE 1024

  struct yy_buffer_state;
  typedef struct yy_buffer_state *YY_BUFFER_STATE;

  extern int yylex(void);
  extern YY_BUFFER_STATE yy_scan_string(const char *);
  extern void yy_delete_buffer(YY_BUFFER_STATE);

  void yyerror(char *);

  extern char* yytext;

  int get_var(char *);
  int set_var(char *, int);

  KHASH_MAP_INIT_STR(str, int);
  khash_t(str) *variables;
%}

%union {
  int integer;
  char *string;
};

%token <integer> INTEGER
%token <string> VARIABLE

%type <integer> expr

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
        | VARIABLE '=' expr         { $$ = set_var($1, $3); }
        | '(' expr ')'              { $$ = $2; }
        | VARIABLE                  { $$ = get_var($1); }
        | INTEGER
        ;

%%

int get_var(char *name) {
  khiter_t k;

  k = kh_get(str, variables, name);

  // no var set. maybe we should throw an error?
  if (k == kh_end(variables)) return 0;

  return kh_value(variables, k);
}

int set_var(char *name, int value) {
  khiter_t k;
  int ret;

  k = kh_put(str, variables, name, &ret);
  kh_value(variables, k) = value;

  return value;
}

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

  variables = kh_init(str);

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
