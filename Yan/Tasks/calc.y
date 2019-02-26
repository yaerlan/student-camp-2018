%{
    #include<stdio.h>
	#include<math.h>
	#define wypi (0.017453292519943)
    void yyerror(char const *);
    int yylex(void);
    int sym[26];
%}
%token INTEGER VARIABLE
%left  '+' '-'
%left  '*' '/'
%left  NEG
%left '^'
%left 'S' 'C' 'T'
%left 'L'
%left '%'

%%
program:
    program statement '\n'
    |
    ;

statement:
     expr    {printf("\t%d\n", $1);}
     |VARIABLE '=' expr {sym[$1] = $3;}
     ;

expr:
    INTEGER
    |VARIABLE{$$ = sym[$1];}
    |expr '+' expr  {$$ = $1 + $3;}
    |expr '-' expr  {$$ = $1 - $3;}
    |expr '*' expr  {$$ = $1 * $3;}
    |expr '/' expr  {$$ = $1 / $3;}
    |'-'expr %prec NEG {$$ = -$2;}
    |expr '^' expr  {$$ = pow($1,$3);}
    |'S' expr  {$$ = sin($2*(wypi));}
    |'C' expr  {$$ = cos($2*(wypi));}
    |'T' expr  {$$ = tan($2*(wypi));}
    |'L' expr  {$$ = log10($2);}
    |expr '%' expr  {$$ = $1%$3;}
    |'('expr')'    {$$ = $2;}
    ;

%%
void yyerror(char const *msg)
{
    fprintf(stderr, "%s\n",msg);
}
int main(void)
{
    printf("a simple calculator.\n");
	printf("+加、-减、*乘、/除\n");
	printf("幂运算：a^b\n");
	printf("S(sin)、C(cos)、T(tan)三角函数：\n");
	printf("L以10为底的对数运算：logA\n");
	printf("求余运算%%：\n");
    yyparse();
    return 0;
}
