;用汇编语言实现多字节数相加2365 0148H和45670123H
.model small
.386
.stack
.data
dat1 db 23h,65h,01h,48h
dat2 db 45h,67h,01h,23h
.code
.startup
mov cx,4
mov si,3
clc
again:
mov al,dat2[si]
adc dat1[si],al
dec si
loop again
mov cx,4
mov si,0
output:
mov al,dat1[si]
push ax
ror al,4
mov dl,al
and dl,0fh
.if dl>=0h && dl<=9
   add dl,30h
.else
   add dl,37h
.endif
mov ah,2
int 21h
pop ax
mov dl,al
and dl,0fh
.if dl>=0 && dl<=9
   add dl,30h
.else
   add dl,37h
.endif
mov ah,2
int 21h
inc si
loop output
.exit 0
end