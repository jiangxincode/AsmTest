;输入两个1位数，输出他们的乘积
.model small
.stack
.code
.startup
mov ah,1
int 21h
mov bl,al     ;al为输入数的ASCII码，如5的ASCII码为35H
and bl,0fh    ;低四位为对应的数值，如5对应0101

mov ah,1
int 21h
and al,0fh
mul bl       ;二者相乘
cbw
mov bl,10    ;乘积除以10，商在AL中为十位，余数在AH中，为个位
div bl
add ax,3030h
mov bl,ah

mov dl,al
mov ah,2
int 21h

mov dl,bl
mov ah,2
int 21h
.exit 0
end