;从键盘输入7位2进制数，显示出对应的字符，回车键退出循环，终止程序。

data segment
input  db 13,10,'input string:',13,10,'$'
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
lea dx,input
mov ah,9
int 21h
mov dl,0
mov cx,7
begin:
mov ah,1
int 21h
.if al==30h
  clc
  rcl dl,1
.elseif al==31h
  stc
  rcl dl,1
.endif
loop begin
mov dh,dl
mov dl,10   ;换行显示
mov ah,2
int 21h
mov dl,dh  ;显示对应的字符
mov ah,2
int 21h
mov ah,4ch
int 21h
code ends
end start

;如果输入的是1000001，则输出的是A