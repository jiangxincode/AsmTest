.model small
.stack
.data
   string db 3 dup(30h) ,'$'
.code
.startup
   mov ax,168
   mov bx,10
   div bl
   add string[2],ah
   mov ah,0
   div bl
   add string[1],ah
   add string[0],al
   lea dx,string
   mov ah,09h
   int 21h
   .exit 0
   end
