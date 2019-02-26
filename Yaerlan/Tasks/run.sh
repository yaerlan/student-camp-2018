bison -d cal1.y
flex fb2.l
gcc cal1.tab.c lex.yy.c 
./a.out
