 .model small
.386
.stack
.code
.startup
     xor bx,bx
     mov cx,16     ;输入16个2进制数 ，保存在BX中
     input:
     mov ah,1
     int 21h
     .if al==30h
       clc
       rcl bx,1
     .elseif al==31h
       stc
       rcl bx,1
     .endif
     loop input
     
     mov dl,10  ;换行输出
     mov ah,2
     int 21h
     
      mov cx,4
     output:      ;输出4位16进制数
     mov dl,bh
     shr dl,4
     or dl,30h
     .if dl>39h  ;输出A--F 的判断
       add dl,7
     .endif
     mov ah,2
     int 21h
     rol bx,4
     loop output
     mov dl,'H'
     mov ah,2
     int 21h

     .exit 0
     END

     ;用MASM615汇编通过，如果输入0001001010101011
                         ;则输出12ABH