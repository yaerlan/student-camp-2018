%{
#include<stdio.h>
extern int yylex();
extern void yyerror(const char *msg);
%}

/*declare tokens*/
%token NUMBER
%token ADD SUB MUL DIV OR NOT OP CP AND
%token EOL

%%

calclist: /*null rules*/
  | calclist exp EOL {printf("=%d\n",$2);}
  ;

exp: factor { $$ = $1;}
  | exp ADD factor{$$ = $1 + $3;}
  | exp SUB factor{$$ = $1 - $3;}
  ;

factor: term { $$ = $1;}
  | factor MUL term{$$ = $1 * $3;}
  | factor DIV term{$$ = $1 / $3;}
  ;

term: NUMBER { $$ = $1;}
  |term OR term  { $$ = $1 || $3;}
  |NOT term { $$ = $2 ==0? 1:0;}
  |term AND term { $$ = $1 && $3;}
  |OP exp CP{ $$ = $2;}
  ;
%%

int main(int argc,char **argv)
{
 yyparse();
 return 0;
}
void yyerror ( const char * msg) {
    printf("%s\n",msg);
}
