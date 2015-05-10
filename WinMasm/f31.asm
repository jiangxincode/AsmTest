.model small
.stack
.data
   string1 db 'Please input name:$'
   string2 db 20,0, 20 dup(?),'$'
   string3 db 10,13,"  Haven't this person!....",10,13,'$'
   person struct    ;结构定义
          pid db 0   ;编号
          pname db '--------------------$';最多20位，姓名
          phome db '---------------$' ;最多15位 ，宅电
          poffice db '----------------$';最多15位 ，办公室
          pmobile db '--------------$';最多15位  ，手机
   person ends
   
   telbook person <1,'zhangsan$','010-12344321$','010-87654321$','13913913999$'>
           person <2,'lisi$','020-43211234$','020-12345678$','13187654321$'>
           person <3,'wanger$','021-87654321$','021-6666666$','13712345678$'>
           person <4,'zhuwu$','025-87654321$','025-6666666$','13612345678$'>
           person <5,'john$','110$',,'119 110 120$'>
           ;电话号码长度可以任意，这里只列举5个
   tablelength=($-telbook)/(type telbook)

.code
    nextline macro  ;显示换行当宏
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
    mov dx,offset string2    ;输入name
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
          repe cmpsb        ;找到不同的字符为止
         .if zero?            ;若没有不同字符，则找到此人
           nextline
           lea dx,[bx].person.phome  ;显示宅电
           mov ah,9
           int 21h
           nextline
           lea dx,[bx].person.poffice   ;显示办公室电话
           mov ah,9
           int 21h
           nextline
           lea dx,[bx].person.pmobile  ;显示手机
           mov ah,9
           int 21h
          .exit 0
        .else        ;继续找下一个
          add bx,type telbook
          lea di,[bx].person.pname
        .endif
        dec dx
    .until dx==0
     mov dx,offset string3   ;没找到
     mov ah,9
     int 21h
     jmp   begin
  end
;Please input name:zhuwu
;025-87654321
;025-6666666
;13612345678
