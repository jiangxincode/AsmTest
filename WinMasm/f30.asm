;从键盘上输入0~~7之间的一个十进制数字（假设为N），要求在屏幕的下一行显示出2的N次方的值，例如：键入3时，输出为8
 .model small
 .386
 .stack
 .code
 .startup
 input:
 mov ah,1
 int 21h
 .if al<30h || al>37h
   jmp input
 .endif
 and al,0fh
 mov ch,0
 mov cl,al
 mov al,1
 shl al,cl
 
 mov ah,0
 .if al>100 ;输出百位
  mov bl,100
  div bl
  push ax
  mov ah,2
  mov dl,'1'
  int 21h
  pop ax
 .endif
 
  mov bl,10
  div bl
  mov ch,ah    ;输出十位
  mov ah,2
  mov dl,al
  add dl,30h
  int 21h
  
  mov ah,2     ;输出个位
  mov dl,ch
  add dl,30h
  int 21h
  .exit 0
  end