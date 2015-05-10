;求若干个16位带符号之和,其和为32位数.要求求和程序用汇编语言编写,定义数据及显示用C语言编写.

long sumx(int *array,int var2,long var3)
{
asm PUSH AX;
asm push bx
asm push cx;
asm push dx
asm mov  ax,0;
asm mov  cx,var2;
asm MOV  bX, array;
lop:asm  mov  AX, [bx] ;
asm cwd
asm add  word ptr var3,ax;
asm adc  word ptr var3[2],dx;
asm add  bx,2
asm dec  cx
asm jnz  lop
asm pop dx
asm pop cx
asm pop bx
asm POP AX ;
return(var3) ;
}
  main()                            /*C语言主程序*/
  { int array[10]={1,2,30000,4,10000,6,-30000,-3000,-30000,-30000};
    long sums=0;
    printf("%ld\n",sumx(array,5,sums));
    sums=0;
    printf("%ld\n",sumx(array,10,sums));
  }