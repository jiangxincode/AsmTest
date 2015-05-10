;棕色字符，蓝色背景显示5遍HELLO
.MODEL   SMALL
       .STACK   64
;---------------------------------------------------
         .DATA
STRING1 DB 'hello'
STRING2 DB  5 dup('*'),0ah,0dh
lengs equ $-string2
temp db 0
;---------------------------------------------------
           .CODE
           .startup

    
           MOV       ax,DS
           MOV       ES,AX
           CLD
           MOV   CX,5
           LEA   DI,STRING2
           LEA   SI,STRING1
           REP   MOVSB
    mov    ax,0600h
    mov    bh,0
    mov    cx,0
    mov    dx,184fh
    int    10h     ;清屏

    mov    ax,3h
    int    10h      ;设置显示模式

A30:
           mov bh,0         ;设置光标位置
           mov dh,temp
           mov dl,temp
           mov ah,2
           int 10h
           
           mov bp,offset string2     ;显示字符串
           mov cx,lengs
           mov dh,TEMP
           MOV DL,temp
           mov bl,16h
           mov al,0
           mov ah,13h
           int 10h

           inc temp
           .if temp==5
            .exit 0
           .else
            jmp a30
           .endif

             END