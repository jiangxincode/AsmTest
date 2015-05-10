.model small
.stack
.code
.startup

mov si,0
mov ah,1
int 21h
and ax,0fh
add si,ax
  mov cx,3
again:mov bx,10
mov ax,si
mul bx
mov si,ax
mov ah,1
int 21h
and ax,0fh
add si,ax
dec cx
jnz again

mov cx,16
display:mov dl,30h
rol si,1
jnc print
inc dl
print:mov ah,2
int 21h
loop display
.exit 0
end