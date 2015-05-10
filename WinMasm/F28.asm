  ;输入：ＦＦＦＦ；输出：＝－0000１　　　输入：８０；输出：＝00１２８
　;输入：Ｅ；　　　输出：＝000１４　　　输入：ＦＦ；输出：＝00２５５
.model  small
.386
.stack
.data
  outstr db 5 dup(0),'$'
.code
.startup
 mov bx,0
  mov cx,4
  input:
  mov ah,1
  int 21h
  .if  al>=41h && al<=46h
     sub al,7
  .elseif  al>=61H && al<=66h
     sub al,27h
  .elseif !(al>=30H && al<=39h)
     jmp endinput
  .endif
    shl bx,4
    and ax,0fh
    add bx,ax
  loop input
  endinput:
  MOV AH,2
  MOV DL,10
  INT 21H
  or bx,bx
  .if sign?
   mov dl,'-'
   mov ah,2
   int 21h
   neg bx
  .endif
  mov ax,bx
  mov cx,10
  mov bx,5
  .repeat
  mov dx,0
  div cx
  and dx,0fh
  add dl,30h
  dec bx
  mov outstr[bx],dl
  .until bx==0

  mov dx,offset outstr
  mov ah,9
  int 21h
 .exit 0
end