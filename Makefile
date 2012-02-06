YFLAGS = -d

calc: calc.o lexer.o interpreter.o

.PHONY: clean
clean:
	rm -f *.o calc y.tab.h

