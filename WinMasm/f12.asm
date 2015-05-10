 求助,汇编的问题!


请高手告诉我这2题的答案

5个双字节数，存放在外部RAM从barf开始的单元中，求它们的和，并把结果放在SUM开始的单元中，编程实现

从内部RAM20H单元开始存放一组带符号娄，字节个数存在1FH中，请统计出其中大于0，等于0，小于0的数的数目，并把结果分别存入one,two ,three 3个单元中


.model small
.386
.stack
.data
  barf dw 1234h,2345h,3456h,4567h,5678h
  sum  dd ?
  ram20 sbyte 1,2,0,0f0h,0a1h,0bch,4,5,0,100;可定义任意多个有符号字节数据
  ram1f dw $-ram20          ;保存数组长度
  one db 0
  two db 0
  three db 0
.code
.startup
     xor eax,eax          ;eax是32位寄存器
     mov cx,5
     mov si,0
     begin1:
     add ax,barf[si]      ;16位相加
     .if carry?            ;如果有进位即CF=1
       add eax,10000h      ;EAX的高16位中加1
     .endif
     add si,4
     loop begin1
     mov sum, eax
    ;第2小题
     mov cx, ram1f
     mov si,0
     begin2:
     .if ram20[si]>0
      inc one
     .elseif ram20[si]==0
      inc two
     .else
      inc three
     .endif
     inc si
     loop begin2
     
     .exit 0
     END

     ;用MASM615汇编通过，用DEBUG可以查看结果：SUM=018D02H
                                            ;ONE、TWO、THREE分别为5、2、3