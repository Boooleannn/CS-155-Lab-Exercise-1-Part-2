To build run

*bison -d calc.y
*flex calc.l
*gcc lex.yy.c calc.tab.c node.c -lm -o calc
*./calc