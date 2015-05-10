;画圆
.model  small
.stack
.data
x0 dw 300
y0 dw 200
r0 dw 100
temp dw 0 ;临时变量
.code
.startup
main proc far
    mov    ax,0600h
    mov    bh,0
    mov    cx,0
    mov    dx,184fh
    int    10h     ;清屏

    mov    ax,12h
    int    10h      ;设置显示模式

    mov ax,r0
    mov temp,ax
    mul ax
    mov r0, ax    ;r0现在为半径的平方，即直角三角形的斜边平方
  repdraw:
       mov cx,-1
       mov ax,temp ;temp为直角三角形的一直边
       mul ax     ;一边的平方
       mov bx,ax
       .while ax<r0
        inc cx
        mov ax,cx
        mul ax
        add ax,bx
       .endw      ;计算出三角型另一直边的长度，在CX中
       push cx
       
       add cx,x0         ;第4象限
       mov dx,y0
       add dx,temp
       mov    ah,0ch
       mov    bh,0
       mov    al,2
       int    10h

       mov dx,y0         ;第3象限
       add dx,temp
       mov cx,x0
       pop bx
       push bx
       sub cx,bx
       mov    ah,0ch
       mov    bh,0
       mov    al,2
       int    10h

       mov dx,y0          ;第2象限
       sub dx,temp
       mov cx,x0
       pop bx
       push bx
       sub cx,bx
       mov    ah,0ch
       mov    bh,0
       mov    al,2
       int    10h

       mov dx,y0        ;第1象限
       sub dx,temp
       pop cx
       add cx,x0
       mov    ah,0ch
       mov    bh,0
       mov    al,2
       int    10h
       
       dec temp
       .if temp==-1
        ret
       .endif
       jmp repdraw

main endp

 .exit 0
end