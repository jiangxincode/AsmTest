;�Ӽ�������7λ2����������ʾ����Ӧ���ַ����س����˳�ѭ������ֹ����

data segment
input  db 13,10,'input string:',13,10,'$'
data ends
code segment
assume cs:code,ds:data
start:
mov ax,data
mov ds,ax
lea dx,input
mov ah,9
int 21h
mov dl,0
mov cx,7
begin:
mov ah,1
int 21h
.if al==30h
  clc
  rcl dl,1
.elseif al==31h
  stc
  rcl dl,1
.endif
loop begin
mov dh,dl
mov dl,10   ;������ʾ
mov ah,2
int 21h
mov dl,dh  ;��ʾ��Ӧ���ַ�
mov ah,2
int 21h
mov ah,4ch
int 21h
code ends
end start

;����������1000001�����������A