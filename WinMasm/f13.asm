.model small
.stack
.data

.code
.startup
     mov ax,0600h
     mov bh,7
     mov cx,0
     mov dx,184fh
     int 10h
     mov ah,0
     mov al,11
     int 10h
     mov cx,100
     mov dx,50
     back: mov ah,0ch
     mov al,1
     int 10h
     inc cx
     cmp cx,200
     jnz back
     
     .exit 0
     END

     ;��MASM615���ͨ������DEBUG���Բ鿴�����SUM=018D02H
                                            ;ONE��TWO��THREE�ֱ�Ϊ5��2��3