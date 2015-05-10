;定义数据段  
data segment  
     infor1 db 0Dh, 0AH, "welocom you to come here listeng! $"  
  
	mus_freg dw 330,294,262,294,3 dup (330)     ;频率表  
               dw 3 dup (294),330,392,392  
               dw 330,294,262,294,4 dup (330)  
               dw 294,294,330,294,262,-1  
	mus_time dw 6 dup (25),50                   ;节拍表  
               dw 2 dup (25,25,50)  
               dw 12 dup (25),100  
data ends  
  
;栈段定义  
stack segment stack  
      db 200 dup(?)  
stack ends  
  
;--------字符串输出宏----------  
SHOWBM MACRO b  
     LEA DX,b  
     MOV AH,9  
     INT 21H  
 ENDM  
  
;----------音乐地址宏-----------  
ADDRESS MACRO A,B  
     LEA SI,A  
     LEA BP,DS:B  
ENDM  
;-------------------------------  
  
;代码段定义  
code segment  
     assume ds:data, ss:stack, cs:code  
start:  
     mov ax, data  
     mov ds, ax  
     mov ax, stack  
     mov ss, ax  
     mov sp, 200  
      
    ; address mus_freg,mus_time
     call music  
  
exit:       
     mov ah, 4cH  
     int 21h  
  
;------------发声-------------  
gensound proc near  
     push ax  
     push bx  
     push cx  
     push dx  
     push di  
  
     mov al, 0b6H  
     out 43h, al  
     mov dx, 12h  
     mov ax, 348ch  
     div di  
     out 42h, al  
  
     mov al, ah  
     out 42h, al  
  
     in al, 61h  
     mov ah, al  
     or al, 3  
     out 61h, al  
wait1:  
     mov cx, 3314  
     call waitf  
delay1:  
     dec bx  
     jnz wait1  
  
     mov al, ah  
     out 61h, al  
  
     pop di  
     pop dx  
     pop cx  
     pop bx  
     pop ax  
     ret   
gensound endp  
  
;--------------------------  
waitf proc near  
      push ax  
waitf1:  
      in al,61h  
      and al,10h  
      cmp al,ah  
      je waitf1  
      mov ah,al  
      loop waitf1  
      pop ax  
      ret  
waitf endp  
;--------------发声调用函数----------------  
music proc near  
      xor ax, ax  
freg:  
      mov di, [si]  
      cmp di, 0FFFFH  
      je end_mus  
      mov bx, ds:[bp]  
      call gensound  
      add si, 2  
      add bp, 2  
      jmp freg  
end_mus:  
      ret  
music endp  
  
code ends  
     end start 