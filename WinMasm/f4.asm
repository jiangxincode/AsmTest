.model small
.stack
.data
   mon db  'jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec'
   msg1 db 'please input a string:',13,10,10,'$'
   msg2 db 'input error!try again...',13,10,10,'$'
   buffer label byte
   maxlen db 3
   actlen db ?
   string db 3 dup(?)
.code
.startup
shuru:  ;��ʼ�����·ݱ��
   lea dx,msg1
   mov ah,09h
   int 21h
   lea dx,buffer
   mov ah,0ah
   int 21h
   cmp actlen,0
   je shurue
;�ж������Ƿ�Ϸ�
   lea di,string
   cmp actlen,2
   je da10
   mov al,string   ;ֻ����һλ����
   and al,0fh    ;��ASCII��ת��Ϊ��Ӧ����
   jmp jisuan
da10:
   mov al,string
   and al,0fh    ;��ʮλASCII��ת��Ϊ��Ӧ����(��12�µ�1��)
   mov bl,10
   mul bl
   and string[1],0fh
   add al,string[1]   ;�ټ��ϸ�λ (��12�µ�2��)

;����ƫ�Ƶ�ַ
jisuan:
   cmp al,1    ;��1С�ǷǷ��·�
   jb shurue
   cmp al,12
   ja shurue   ;��12���ǷǷ��·�
   sub al,1
   shl al,1
   shl al,1    ;�·�ֵ��1�ٳ�4��Ӧ��MON�ַ����д��׵�ַ��ʼ���ַ����λ��
   xor ah,ah    ;1�·ݴ�0λ�ÿ�ʼ��JAN,...5�·ݴ�λ��16��ʼ��MAY
   lea si,mon
   add si,ax
   mov cx,3
output: mov dl,[si]   ;�����Ӧ�·�Ӣ����д
   mov ah,2
   int 21h
   inc si
   loop output
  .exit 0

;�������ʱ
shurue:  lea dx,msg2
   mov ah,09h
   int 21h
   jmp shuru

   end
