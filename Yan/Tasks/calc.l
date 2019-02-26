%{
    #include <stdlib.h>
    #include "calculator.tab.h"
    void yyerror(char const *);
%}

%%
    /* a-z为变量 */
[a-z]  {
       yylval = *yytext - 'a';
       return VARIABLE;
    }

    /* 整数 */
[0-9]+ {
        yylval = atoi(yytext);
        return INTEGER;
    }

    /* 运算符 */
[-+()=/*^SCTL%\n]    {return *yytext;}

  /* 空白被忽略 */
[ \t]    ;

    /* 其他字符都是非法的 */
.    yyerror("error 无效的输入字符\n");

%%
int yywrap(void)
{
    return 1;
}
