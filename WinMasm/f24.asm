.model small
.stack
.data
   string1 db 'Please input the first  string:$'
   string2 db 0ah,0dh,'Please input the second string:$'
   str1 db 30,0, 30 dup(?),'$'
   str2 db 30,0, 30 dup(?),'$'
.code
    dispchar macro char   ;����һ����ʾ�ַ��ĺ�
      mov dl,char
      mov ah,2
      int 21h
    endm
.startup
   mov ax,ds
   mov es,ax
   mov dx,offset string1
   mov ah,9
   int 21h
   mov dx,offset str1    ;�����һ���ַ���
   mov ah,10
   int 21h
   
   mov dx,offset string2
   mov ah,9
   int 21h
   mov dx,offset str2  ; ����ڶ����ַ���
   mov ah,10
   int 21h
   
   dispchar 10        ;���һ�����з�
   mov al,str1[1]     ;��һ���ַ����ĳ���
   mov bl,str2[1]     ;�ڶ����ַ����ĳ���
   
   .if al>bl          ;����һ���ַ����ĳ��ȴ����һ���ַ������ڵڶ���
      dispchar '1'
   .elseif al<bl      ;����һ���ַ����ĳ���С�����һ���ַ���С
      dispchar '-'
      dispchar '1'
   .else              ;���߳�������򣬴�ǰ����һ�����ַ���һ�Ƚ�
     lea si,str1[2]
     lea di,str2[2]
     mov ch, 0
     mov cl,str1[1]
     repe cmpsb        ;�ҵ���ͬ���ַ�Ϊֹ
     .if zero?          ;��û�в�ͬ�ַ�����������
        dispchar '0'
     .elseif sign?      ;����λSFΪ1��˵��1��С��2��
        dispchar '-'
        dispchar '1'
     .else               ;����1������2��
        dispchar '1'
     .endif
  .endif
  .exit 0
 end
  ;����12345678��123459�����1
  ;����12345678��123456789�����-1
  ;����1234��1234�����0
  ;����1234567��1233567�����1
  