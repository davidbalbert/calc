YFLAGS = -d

calc: calc.o lexer.o

calc.o: khash.h

.PHONY: clean
clean:
	rm -f *.o calc y.tab.h

