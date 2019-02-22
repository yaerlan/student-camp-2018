%{
#include "cal1.tab.h"
#include "stdio.h"
%}


%option noyywrap
%%
"+" {return ADD;}
"-" {return SUB;}
"*" {return MUL;}
"/" {return DIV;}
"|" {return OR;}
"!" {return NOT;}
"(" {return OP;}
")" {return CP;}
-?[0-9]+ {yylval=atoi(yytext);
        return NUMBER; }
"&" {return AND;}
\n {return EOL;}
[\t] {}
. {printf("Mystery character %c\n",*yytext);}

%%	
