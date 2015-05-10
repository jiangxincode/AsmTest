DATAS SEGMENT
    pushcount dw 0
DATAS ENDS

STACKS SEGMENT stack
    dw 10 dup(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    mov ax,29    ;初始化一个值
    call binidec ;调用过程将余数打印出来
    MOV AH,4CH
    INT 21H
binidec proc near
         mov bx,10
loop1:   cwd
         idiv bx
         push dx
         inc pushcount
         cmp ax,0
         jne loop1
print:   pop dx
         add dx,30h
         mov ah,2
         int 21h
         dec pushcount
         jnz print
binidec endp
CODES ENDS
    END START