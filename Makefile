YFLAGS = -d

all: calc

calc: calc.o lexer.o

.PHONY: clean
clean:
	rm -f *.o calc y.tab.h

