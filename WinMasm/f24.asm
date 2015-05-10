.model small
.stack
.data
   string1 db 'Please input the first  string:$'
   string2 db 0ah,0dh,'Please input the second string:$'
   str1 db 30,0, 30 dup(?),'$'
   str2 db 30,0, 30 dup(?),'$'
.code
    dispchar macro char   ;定义一个显示字符的宏
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
   mov dx,offset str1    ;输入第一个字符串
   mov ah,10
   int 21h
   
   mov dx,offset string2
   mov ah,9
   int 21h
   mov dx,offset str2  ; 输入第二个字符串
   mov ah,10
   int 21h
   
   dispchar 10        ;输出一个换行符
   mov al,str1[1]     ;第一个字符串的长度
   mov bl,str2[1]     ;第二个字符串的长度
   
   .if al>bl          ;若第一个字符串的长度大，则第一个字符串大于第二个
      dispchar '1'
   .elseif al<bl      ;若第一个字符串的长度小，则第一个字符串小
      dispchar '-'
      dispchar '1'
   .else              ;二者长度相等则，从前到后一个个字符逐一比较
     lea si,str1[2]
     lea di,str2[2]
     mov ch, 0
     mov cl,str1[1]
     repe cmpsb        ;找到不同的字符为止
     .if zero?          ;若没有不同字符，则二者相等
        dispchar '0'
     .elseif sign?      ;符号位SF为1，说明1串小于2串
        dispchar '-'
        dispchar '1'
     .else               ;否则1串大于2串
        dispchar '1'
     .endif
  .endif
  .exit 0
 end
  ;输入12345678和123459，输出1
  ;输入12345678和123456789，输出-1
  ;输入1234和1234，输出0
  ;输入1234567和1233567，输出1
  