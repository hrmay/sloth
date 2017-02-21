lexer: lex.yy.c
	gcc lex.yy.c -o lexer

lex.yy.c: lexer.l tokens.h
	flex lexer.l
	
clean:
	rm -f lex.yy.c *.o lexer