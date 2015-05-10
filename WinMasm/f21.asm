；这个程序是将1110111110111001b转换成五个bcd码表示的该十进制五位数，
；用MASEdit1.0.8编译完，没有错误提示，但无法链接，请各位指教

Stack segment stack
     dw 2 dup(0)
stack ends


data segment
     array    dw 5 dup(?)；存放各位数字
     table dw 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h
     count db 0    ；记录si偏移量
     data    ends


code segment  'code'
      assume    cs:code,ds:data,ss:stack
start:mov  ax,data
      mov  ds,ax
      mov  dx,1110111110111001b
      xor    ax,ax    ；清空循环个数
      mov  bx,10000   ；第一次被除数为10000，bx存放被除数
      mov  cx,5    ；设置循环次数（五位数）
      lea  si,array    ；获得array的有效地址
AGAIN:div   bx    ；bx内存放被除数
      push  dx    ；保护每次除法后的余数
      call  THENUM    ；子程序保存各位数，并改变被除数
      pop   dx    ；弹出余数
      loop  AGAIN    ；循环求各位数字
      push  bx    ；保存被除数，bl暂时存放si的位移量
      mov   bl,count
      sub   si,bx    ；回到首位数字地址
      pop   bx    ；弹出余数
      mov   cx,5    ；转换成bcd码后显示输出的循环次数
BCDCODE:mov  bx,table
        mov  al,[si]
        xlat    ；换码指令求得当前数字的bcd码
        mov   dl,al    ；输出该位
        mov   ah,2
        int   21h
        add   si,2    ；后移一位
        loop  BCDCODE    ；循环至下一位
        mov   ax,4c00h
        int   21h
THENUM proc    ；子程序：保存各位数字并改变被除数
       mov   [si],ax    ；保存当前位的数字
       add   si,2    ；后移一位
       add   count,2    ；计数器记录si的偏移
       xor   ax,ax    ；商清零
       mov   dx,bx    ；将上一次的被除数送给dx，准备将其除以十
       mov   bx,10
       div   bx    ；被除数除以十
       mov   bx,ax    ；将新的被除数送给bx
       ret
THENUM  endp
code    ends
        end  start