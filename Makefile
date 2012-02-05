YFLAGS = -d

all: calc

calc: lex.yy.o calc.o

lex.yy.o: lex.yy.c

lex.yy.c: calc.l
	lex calc.l

.PHONY: clean
clean:
	rm -f *.o calc lex.yy.c y.tab.*

