#include <math.h>

#include "calc.h"

struct number ADD(struct number x, struct number y) {
        if (IS_RATIONAL(x) || IS_RATIONAL(y)) {
                ENSURE_RATIONAL(x);
                ENSURE_RATIONAL(y);
                return ADD_RATIONAL(x, y);
        }
        else {
                return ADD_INTEGER(x, y);
        }
}

struct number SUBTRACT(struct number x, struct number y) {
        if (IS_RATIONAL(x) || IS_RATIONAL(y)) {
                ENSURE_RATIONAL(x);
                ENSURE_RATIONAL(y);
                return SUBTRACT_RATIONAL(x, y);
        }
        else {
                return SUBTRACT_INTEGER(x, y);
        }
}

struct number MULTIPLY(struct number x, struct number y) {
        if (IS_RATIONAL(x) || IS_RATIONAL(y)) {
                ENSURE_RATIONAL(x);
                ENSURE_RATIONAL(y);
                return MULTIPLY_RATIONAL(x, y);
        }
        else {
                return MULTIPLY_INTEGER(x, y);
        }
}
struct number DIVIDE(struct number x, struct number y) {
        if (IS_RATIONAL(x) || IS_RATIONAL(y)) {
                ENSURE_RATIONAL(x);
                ENSURE_RATIONAL(y);
                return DIVIDE_RATIONAL(x, y);
        }
        else {
                return DIVIDE_INTEGER(x, y);
        }
}

struct number POW(struct number x, struct number y) {
        if (IS_RATIONAL(x) || IS_RATIONAL(y)) {
                ENSURE_RATIONAL(x);
                ENSURE_RATIONAL(y);
                return POW_RATIONAL(x, y);
        }
        else {
                return POW_INTEGER(x, y);
        }
}

struct number NEGATE(struct number x) {
        if (IS_RATIONAL(x))
                x.rational = -x.rational;
        else
                x.integer = -x.integer;

        return x;
}
