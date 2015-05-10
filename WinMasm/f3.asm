.model small
.386
.stack
.data
  string db  32 dup(30h) ,'$'   ;初始字符串为全零
.code
.startup
   mov eax, 12345678h  ;eax内容可以为任意值
   mov cx,32
   mov di,0
begin:
   rol eax,1          ;循环左移1位,移出位在CF中
   .if carry?          ;如果CF=1则把1的ASCII码存入字符串中
     mov string[di],31h
   .endif
   inc di
loop begin
   lea dx,string  ;显示字符串
   mov ah,9
   int 21h
  .exit 0
   end
   
   ;该程序输出为:00010010001101000101011001111000