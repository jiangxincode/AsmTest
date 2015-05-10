;.model small
.stack
.data
   maxlen db 80
   actlen db ?
   string db 80 dup(?)
.code
.startup
   lea dx,maxlen
   mov ah,0ah
   int 21h
   mov ax,2
   int 10h
   mov bl,actlen
   mov bh,0
   mov string[bx],'$'
   mov dx,40
   shr actlen,1
   sub dl,actlen
   mov ah,2

   int 10h

   lea dx,string
   mov ah,09h
   int 21h

   end
