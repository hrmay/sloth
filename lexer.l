%{
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include "tokens.h"
%}

%option noyywrap

%%

"begin"                     {return START;}
"end"                       {return END;}
"if"                        {return IF;}
"then"                      {return THEN;}
"else"                      {return ELSE;}
"while"                     {return WHILE;}
"do"                        {return DO;}
"print"                     {return PRINT;}
"input"                     {return INPUT;}

[_a-zA-Z]+[_a-zA-Z0-9]*     {return IDENT;}
[0-9]*\.?[0-9]+             {return VALUE;}

"+"                         {return PLUS;}
"-"                         {return MINUS;}
"/"                         {return DIVIDE;}
"*"                         {return TIMES;}

"<"                         {return LTHAN;}
">"                         {return GTHAN;}
"<="                        {return LEQ;}
">="                        {return GEQ;}
"=="                        {return EQUALS;}
"!="                        {return NEQ;}

"&&"                        {return AND;}
"||"                        {return OR;}
"!"                         {return NOT;}

";"                         {return SCOL;}
":="                        {return SET;}
"("                         {return OPAREN;}
")"                         {return CPAREN;}

"%".*                       {}
[ \t\n]+                    {}

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        struct stat buffer; //used to check if file exists
        
        if (stat (argv[1], &buffer) == 0) {
            stdin = fopen(argv[1], "r");
        } else {
            printf("File %s not found.\n", argv[1]);
            return 1; //you broke it
        }
        
        int token;
        do {
            token = yylex();
            printf("%d\n", token);
        } while (token > 0);
        
        return 0;
    } else {
        printf("Please provide a file as an argument. \n");
        return 1; //you broke it
    }
}