.model small
.386
.stack
.data
  string db  32 dup(30h) ,'$'   ;��ʼ�ַ���Ϊȫ��
.code
.startup
   mov eax, 12345678h  ;eax���ݿ���Ϊ����ֵ
   mov cx,32
   mov di,0
begin:
   rol eax,1          ;ѭ������1λ,�Ƴ�λ��CF��
   .if carry?          ;���CF=1���1��ASCII������ַ�����
     mov string[di],31h
   .endif
   inc di
loop begin
   lea dx,string  ;��ʾ�ַ���
   mov ah,9
   int 21h
  .exit 0
   end
   
   ;�ó������Ϊ:00010010001101000101011001111000