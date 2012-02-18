#include <math.h>

#include "calc.h"

#define DEFINE_BINARY_OPERATION(name) \
        struct number name(struct number x, struct number y) { \
                if (IS_RATIONAL(x) || IS_RATIONAL(y)) { \
                        ENSURE_RATIONAL(x); \
                        ENSURE_RATIONAL(y); \
                        return name##_RATIONAL(x, y); \
                } \
                else { \
                        return name##_INTEGER(x, y); \
                } \
        }

DEFINE_BINARY_OPERATION(ADD);
DEFINE_BINARY_OPERATION(SUBTRACT);
DEFINE_BINARY_OPERATION(MULTIPLY);
DEFINE_BINARY_OPERATION(DIVIDE);
DEFINE_BINARY_OPERATION(POW);

struct number NEGATE(struct number x) {
        if (IS_RATIONAL(x))
                x.rational = -x.rational;
        else
                x.integer = -x.integer;

        return x;
}
