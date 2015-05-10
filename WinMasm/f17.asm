.model small
.stack
.data
x sword 10
y sword -20
z sword 1000
v sword 3000
w dd ?
.code
.startup
    ;ｗ=（v-（ｘ*ｙ+ｚ-540））/x
   mov ax,x
   imul y       ;ｘ*ｙ
   add ax,z     ; ｘ*ｙ+ｚ
   adc dx,0
   sub ax,540   ;ｘ*ｙ+ｚ-540
   sbb dx,0
   mov bx,v     ;32位减法被减数的低16位v放在BX中
   mov cx,0      ;32位减法被减数的高16位全0放在CX中
   sub bx,ax      ;低16位减法
   sbb cx,dx      ;高16位减法
   mov dx,cx      ;差的高16位在DX中
   mov ax,bx      ;差的低16位在AX中
   idiv x          ;（v-（ｘ*ｙ+ｚ-540））/x
   mov word ptr w,ax    ;商在W的低2字节
   mov word ptr w[2],dx  ;余数在高2字节
   
.exit 0
end