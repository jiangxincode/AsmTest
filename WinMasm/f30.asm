;�Ӽ���������0~~7֮���һ��ʮ�������֣�����ΪN����Ҫ������Ļ����һ����ʾ��2��N�η���ֵ�����磺����3ʱ�����Ϊ8
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
 .if al>100 ;�����λ
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
  mov ch,ah    ;���ʮλ
  mov ah,2
  mov dl,al
  add dl,30h
  int 21h
  
  mov ah,2     ;�����λ
  mov dl,ch
  add dl,30h
  int 21h
  .exit 0
  end