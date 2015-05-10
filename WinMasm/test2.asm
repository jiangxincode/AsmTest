.model small
.stack
.data
   mon db  'Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec'
   msg1 db 'Please input a month(1-12) :',13,10,'$'
   msg2 db 'Input error! Now try again...',13,10,'$'
   buffer label byte  ;定义输入月份的输入缓冲区
   maxlen db 3        ;最多2个数字，包括一个回车
   actlen db ?        ;保存实际输入的字符个数
   string db 3 dup(?) ;保存输入的月份数字内容（ASCII码）
.code
.startup
shuru:          ;开始输入月份编号
   lea dx,msg1
   mov ah,09h
   int 21h          ;显示提示信息
   lea dx,buffer
   mov ah,0ah
   int 21h          ;输入月份数值
   cmp actlen,0     ;若没有输入月份则转出错处理
   je shuruerr
;以下判断输入月份是否合法
   lea di,string
   cmp actlen,2
   je da10          ;若输入的是2位数月份值则转到da10标号处执行
   mov al，string   ;若只输入1位数字月份值，则读出该值
   and al，0fh      ;把ASCII码转换为对应数字
   jmp jisuan
da10:
   mov al，string
   and al，0fh      ;把月份数值十位的ASCII码转换为对应数字(如12月的1字)
   mov bl,10
   mul bl
   and string[1]，0fh ;把月份数值个位的ASCII码转换为对应数字
   add al，string[1]  ;十位加上个位 (如12月)
jisuan:          ;以下计算偏移地址
   cmp al，1     ;比1小是非法月份
   jb shuruerr  ;若月份值小于1则转出错处理
   cmp al,12
   ja shuruerr   ;比12大也是非法月份
   sub al，1     ;月份值减1
   shl al，1
   shl al，1     ;月份再乘4对应了MON字符串中从首地址开始的字符相对位置
   xor ah，ah    ;1月份从0位置开始即JAN,...5月份从位置16开始即MAY
   lea si，mon   ;找到被显示月份字符的位置
   add si，ax
   mov cx，3
output: mov dl，[si] ;输出对应月份英文缩写
   mov ah，2
   int 21h
   inc si
   loop output
  .exit 0
shuruerr:  lea dx,msg2  ;输入出错时提示出错，并转到程序起始处重新执行
   mov ah，09h
   int 21h
   jmp shuru
end
