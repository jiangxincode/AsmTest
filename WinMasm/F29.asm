;��Բ
.model  small
.stack
.data
x0 dw 300
y0 dw 200
r0 dw 100
temp dw 0 ;��ʱ����
.code
.startup
main proc far
    mov    ax,0600h
    mov    bh,0
    mov    cx,0
    mov    dx,184fh
    int    10h     ;����

    mov    ax,12h
    int    10h      ;������ʾģʽ

    mov ax,r0
    mov temp,ax
    mul ax
    mov r0, ax    ;r0����Ϊ�뾶��ƽ������ֱ�������ε�б��ƽ��
  repdraw:
       mov cx,-1
       mov ax,temp ;tempΪֱ�������ε�һֱ��
       mul ax     ;һ�ߵ�ƽ��
       mov bx,ax
       .while ax<r0
        inc cx
        mov ax,cx
        mul ax
        add ax,bx
       .endw      ;�������������һֱ�ߵĳ��ȣ���CX��
       push cx
       
       add cx,x0         ;��4����
       mov dx,y0
       add dx,temp
       mov    ah,0ch
       mov    bh,0
       mov    al,2
       int    10h

       mov dx,y0         ;��3����
       add dx,temp
       mov cx,x0
       pop bx
       push bx
       sub cx,bx
       mov    ah,0ch
       mov    bh,0
       mov    al,2
       int    10h

       mov dx,y0          ;��2����
       sub dx,temp
       mov cx,x0
       pop bx
       push bx
       sub cx,bx
       mov    ah,0ch
       mov    bh,0
       mov    al,2
       int    10h

       mov dx,y0        ;��1����
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