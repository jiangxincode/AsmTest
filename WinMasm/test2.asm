.model small
.stack
.data
   mon db  'Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec'
   msg1 db 'Please input a month(1-12) :',13,10,'$'
   msg2 db 'Input error! Now try again...',13,10,'$'
   buffer label byte  ;���������·ݵ����뻺����
   maxlen db 3        ;���2�����֣�����һ���س�
   actlen db ?        ;����ʵ��������ַ�����
   string db 3 dup(?) ;����������·��������ݣ�ASCII�룩
.code
.startup
shuru:          ;��ʼ�����·ݱ��
   lea dx,msg1
   mov ah,09h
   int 21h          ;��ʾ��ʾ��Ϣ
   lea dx,buffer
   mov ah,0ah
   int 21h          ;�����·���ֵ
   cmp actlen,0     ;��û�������·���ת������
   je shuruerr
;�����ж������·��Ƿ�Ϸ�
   lea di,string
   cmp actlen,2
   je da10          ;���������2λ���·�ֵ��ת��da10��Ŵ�ִ��
   mov al��string   ;��ֻ����1λ�����·�ֵ���������ֵ
   and al��0fh      ;��ASCII��ת��Ϊ��Ӧ����
   jmp jisuan
da10:
   mov al��string
   and al��0fh      ;���·���ֵʮλ��ASCII��ת��Ϊ��Ӧ����(��12�µ�1��)
   mov bl,10
   mul bl
   and string[1]��0fh ;���·���ֵ��λ��ASCII��ת��Ϊ��Ӧ����
   add al��string[1]  ;ʮλ���ϸ�λ (��12��)
jisuan:          ;���¼���ƫ�Ƶ�ַ
   cmp al��1     ;��1С�ǷǷ��·�
   jb shuruerr  ;���·�ֵС��1��ת������
   cmp al,12
   ja shuruerr   ;��12��Ҳ�ǷǷ��·�
   sub al��1     ;�·�ֵ��1
   shl al��1
   shl al��1     ;�·��ٳ�4��Ӧ��MON�ַ����д��׵�ַ��ʼ���ַ����λ��
   xor ah��ah    ;1�·ݴ�0λ�ÿ�ʼ��JAN,...5�·ݴ�λ��16��ʼ��MAY
   lea si��mon   ;�ҵ�����ʾ�·��ַ���λ��
   add si��ax
   mov cx��3
output: mov dl��[si] ;�����Ӧ�·�Ӣ����д
   mov ah��2
   int 21h
   inc si
   loop output
  .exit 0
shuruerr:  lea dx,msg2  ;�������ʱ��ʾ������ת��������ʼ������ִ��
   mov ah��09h
   int 21h
   jmp shuru
end
