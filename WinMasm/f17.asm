.model small
.stack
.data
x sword 10
y sword -20
z sword 1000
v sword 3000
w dd ?
.code
.startup
    ;��=��v-����*��+��-540����/x
   mov ax,x
   imul y       ;��*��
   add ax,z     ; ��*��+��
   adc dx,0
   sub ax,540   ;��*��+��-540
   sbb dx,0
   mov bx,v     ;32λ�����������ĵ�16λv����BX��
   mov cx,0      ;32λ�����������ĸ�16λȫ0����CX��
   sub bx,ax      ;��16λ����
   sbb cx,dx      ;��16λ����
   mov dx,cx      ;��ĸ�16λ��DX��
   mov ax,bx      ;��ĵ�16λ��AX��
   idiv x          ;��v-����*��+��-540����/x
   mov word ptr w,ax    ;����W�ĵ�2�ֽ�
   mov word ptr w[2],dx  ;�����ڸ�2�ֽ�
   
.exit 0
end