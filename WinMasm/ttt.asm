.model small
.386
.stack
.data
 tishi db 'please input a number:  $'
 shuchu db 10,13,'sqr is: $'
 temp db 0
 .code
     DISPCHAR MACRO NUMBER  ;�ú���ʾax�Ĵ���ֵ����NUMBER���õ�1λ10������
        POP ax
          MOV DX,0
          mov bX,NUMBER
          div bX
          PUSH DX     ;������ջ��Ϊ��ʵ��һλ׼��
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
        DISPCHAR 1000  ;��ʾǧλ
        DISPCHAR 100   ;��ʾ��λ
        DISPCHAR 10    ;��ʾʮλ
        DISPCHAR 1     ;��ʾ��λ
 .exit 0
 end