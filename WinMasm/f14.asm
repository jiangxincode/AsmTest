 .model small
.386
.stack
.code
.startup
     xor bx,bx
     mov cx,16     ;����16��2������ ��������BX��
     input:
     mov ah,1
     int 21h
     .if al==30h
       clc
       rcl bx,1
     .elseif al==31h
       stc
       rcl bx,1
     .endif
     loop input
     
     mov dl,10  ;�������
     mov ah,2
     int 21h
     
      mov cx,4
     output:      ;���4λ16������
     mov dl,bh
     shr dl,4
     or dl,30h
     .if dl>39h  ;���A--F ���ж�
       add dl,7
     .endif
     mov ah,2
     int 21h
     rol bx,4
     loop output
     mov dl,'H'
     mov ah,2
     int 21h

     .exit 0
     END

     ;��MASM615���ͨ�����������0001001010101011
                         ;�����12ABH