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
shuru:  ;开始输入月份编号
   lea dx,msg1
   mov ah,09h
   int 21h
   lea dx,buffer
   mov ah,0ah
   int 21h
   cmp actlen,0
   je shurue
;判断输入是否合法
   lea di,string
   cmp actlen,2
   je da10
   mov al,string   ;只输入一位数字
   and al,0fh    ;把ASCII码转换为对应数字
   jmp jisuan
da10:
   mov al,string
   and al,0fh    ;把十位ASCII码转换为对应数字(如12月的1字)
   mov bl,10
   mul bl
   and string[1],0fh
   add al,string[1]   ;再加上个位 (如12月的2字)

;计算偏移地址
jisuan:
   cmp al,1    ;比1小是非法月份
   jb shurue
   cmp al,12
   ja shurue   ;比12大是非法月份
   sub al,1
   shl al,1
   shl al,1    ;月份值减1再乘4对应了MON字符串中从首地址开始的字符相对位置
   xor ah,ah    ;1月份从0位置开始即JAN,...5月份从位置16开始即MAY
   lea si,mon
   add si,ax
   mov cx,3
output: mov dl,[si]   ;输出对应月份英文缩写
   mov ah,2
   int 21h
   inc si
   loop output
  .exit 0

;输入出错时
shurue:  lea dx,msg2
   mov ah,09h
   int 21h
   jmp shuru

   end
