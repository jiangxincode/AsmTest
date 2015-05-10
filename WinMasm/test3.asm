.model small
.stack
.data
   str1 db 'ABCDEFGHIJ'
   str2 db 'Please input the number you will display:',10,13,'$'
.code
.startup
  mov ah,9
  mov dx,offset str2
  int 21h
  mov ah,1
  int 21h
  mov bx,offset str1
  sub al,30h
  xlat
  mov dl,al
  mov ah,2
  int 21h
.exit 0
End
