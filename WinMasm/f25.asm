;��������1λ����������ǵĳ˻�
.model small
.stack
.code
.startup
mov ah,1
int 21h
mov bl,al     ;alΪ��������ASCII�룬��5��ASCII��Ϊ35H
and bl,0fh    ;����λΪ��Ӧ����ֵ����5��Ӧ0101

mov ah,1
int 21h
and al,0fh
mul bl       ;�������
cbw
mov bl,10    ;�˻�����10������AL��Ϊʮλ��������AH�У�Ϊ��λ
div bl
add ax,3030h
mov bl,ah

mov dl,al
mov ah,2
int 21h

mov dl,bl
mov ah,2
int 21h
.exit 0
end