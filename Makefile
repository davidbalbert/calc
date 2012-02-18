YFLAGS = -d

calc: calc.o lexer.o number.o

calc.o: khash.h calc.h

lexer.o: calc.h

number.o: calc.h

.PHONY: clean
clean:
	rm -f *.o calc y.tab.h

