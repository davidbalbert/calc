#define TRUE 1
#define FALSE 0
#define BOOL int

struct number {
  long integer;
  double rational;
  BOOL is_rational;
};
typedef struct number NUMBER;

struct number get_var(char *);
struct number set_var(char *, struct number);

struct number ADD(struct number x, struct number y);
struct number SUBTRACT(struct number x, struct number y);
struct number MULTIPLY(struct number x, struct number y);
struct number DIVIDE(struct number x, struct number y);
struct number POW(struct number x, struct number y);
struct number NEGATE(struct number x);

#define IS_RATIONAL(x) x.is_rational == TRUE
#define NEW_INTEGER(x) (struct number){ x, 0, FALSE }
#define NEW_RATIONAL(x) (struct number){ 0, x, TRUE }

#define ENSURE_RATIONAL(x) \
        do { \
                if (!IS_RATIONAL(x)) { \
                        x.rational = (double)x.integer; \
                        x.is_rational = TRUE; \
                } \
        } while(0)

#define PRINT_NUMBER(x) \
        do { \
                if (IS_RATIONAL(x)) \
                        printf("%lg\n", x.rational); \
                else \
                        printf("%ld\n", x.integer); \
        } while (0)

#define ADD_INTEGER(x, y) NEW_INTEGER(x.integer + y.integer)
#define ADD_RATIONAL(x, y) NEW_RATIONAL(x.rational + y.rational)

#define SUBTRACT_INTEGER(x, y) NEW_INTEGER(x.integer - y.integer)
#define SUBTRACT_RATIONAL(x, y) NEW_RATIONAL(x.rational - y.rational);

#define MULTIPLY_INTEGER(x, y) NEW_INTEGER(x.integer * y.integer)
#define MULTIPLY_RATIONAL(x, y) NEW_RATIONAL(x.rational * y.rational)

#define DIVIDE_INTEGER(x, y) NEW_INTEGER(x.integer / y.integer)
#define DIVIDE_RATIONAL(x, y) NEW_RATIONAL(x.rational / y.rational)

#define POW_INTEGER(x, y) NEW_INTEGER(pow(x.integer, y.integer))
#define POW_RATIONAL(x, y) NEW_RATIONAL(pow(x.rational, y.rational))

