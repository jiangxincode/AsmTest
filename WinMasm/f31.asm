.model small
.stack
.data
   string1 db 'Please input name:$'
   string2 db 20,0, 20 dup(?),'$'
   string3 db 10,13,"  Haven't this person!....",10,13,'$'
   person struct    ;�ṹ����
          pid db 0   ;���
          pname db '--------------------$';���20λ������
          phome db '---------------$' ;���15λ ��լ��
          poffice db '----------------$';���15λ ���칫��
          pmobile db '--------------$';���15λ  ���ֻ�
   person ends
   
   telbook person <1,'zhangsan$','010-12344321$','010-87654321$','13913913999$'>
           person <2,'lisi$','020-43211234$','020-12345678$','13187654321$'>
           person <3,'wanger$','021-87654321$','021-6666666$','13712345678$'>
           person <4,'zhuwu$','025-87654321$','025-6666666$','13612345678$'>
           person <5,'john$','110$',,'119 110 120$'>
           ;�绰���볤�ȿ������⣬����ֻ�о�5��
   tablelength=($-telbook)/(type telbook)

.code
    nextline macro  ;��ʾ���е���
      mov ah,2
      mov dl,10
      int 21h
      mov ah,2
      mov dl,13
      int 21h
     endm
.startup
   mov ax,ds
   mov es,ax
  begin:
    mov dx,offset string1
    mov ah,9
    int 21h
    mov dx,offset string2    ;����name
    mov ah,10
    int 21h
     mov ax,type telbook
     lea bx,offset telbook
     lea di,[bx].person.pname
     mov dx,tablelength
     .repeat
          mov ch, 0
          mov cl,string2[1]
          lea si,string2[2]
          repe cmpsb        ;�ҵ���ͬ���ַ�Ϊֹ
         .if zero?            ;��û�в�ͬ�ַ������ҵ�����
           nextline
           lea dx,[bx].person.phome  ;��ʾլ��
           mov ah,9
           int 21h
           nextline
           lea dx,[bx].person.poffice   ;��ʾ�칫�ҵ绰
           mov ah,9
           int 21h
           nextline
           lea dx,[bx].person.pmobile  ;��ʾ�ֻ�
           mov ah,9
           int 21h
          .exit 0
        .else        ;��������һ��
          add bx,type telbook
          lea di,[bx].person.pname
        .endif
        dec dx
    .until dx==0
     mov dx,offset string3   ;û�ҵ�
     mov ah,9
     int 21h
     jmp   begin
  end
;Please input name:zhuwu
;025-87654321
;025-6666666
;13612345678
