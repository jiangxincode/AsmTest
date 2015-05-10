.model small
.386
.stack
.data
 tishi db 'please input a number:  $'
 shuchu db 10,13,'sqr is: $'
 temp db 0
 .code
     DISPCHAR MACRO NUMBER  ;该宏显示ax寄存器值除以NUMBER所得的1位10进制商
        POP ax
          MOV DX,0
          mov bX,NUMBER
          div bX
          PUSH DX     ;余数入栈，为现实下一位准备
          MOV DL,AL
          ADD DL,30H
          MOV AH,2
          INT 21H
        ENDM
 .startup
 mov dx,offset tishi
 mov ah,9
 int 21h
 
mov  ah,1
int 21h
.if al>=30h && al<=39h
  mov temp,al
  and temp,0fh
.else
  .exit 0
.endif
mov ah,1
int 21h
  .if al>=30h && al<=39h
    mov cl,al
    mov al,10
    mul temp
    and cl,0fh
    add al,cl
  .else
    mov al,temp
  .endif
 mul al
 push ax
 
 mov dx,offset shuchu
 mov ah,9
 int 21h
        DISPCHAR 1000  ;显示千位
        DISPCHAR 100   ;显示百位
        DISPCHAR 10    ;显示十位
        DISPCHAR 1     ;显示个位
 .exit 0
 end