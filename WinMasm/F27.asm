;首先我写一个程序，把圆分成4部分，逐一画，最后画的圆很不圆，周边成锯齿状，
;我知道这与显示像素大小有关，想有一个好的解决方法！不仅如此，而且在屏幕上显
;示的不只是一个圆，还有其成块的杂白色！不知什么原因！

.MODEL SMALL
.STACK
.DATA
x0 dw 150
y0 dw 100
r  dw 30
.CODE

square macro opr
 mov ax,opr
 mul ax
 RET
endm

delay  proc near
  wait1:
       mov cx,4000
  wait2:
       loop wait2
       dec dx
       jnz wait1
      ret
delay  endp

.STARTUP
main proc far
     mov ah,00
     mov al,04h
     int 10h

     mov ah,0bh
     mov bh,00
     mov bl,1
     int 10h

     mov ah,0bh
     mov bh,01
     mov bl,01
     int 10h

     mov si,x0
     mov di,y0
nextcol:
       push si
       sub si,x0
       square si
       mov cx,ax
       square r
       sub ax,cx
       mov cx,ax
       pop si
   col:
       push bx
       mov  bx,y0
       sub bx,di
       square bx
       pop bx
       cmp ax,cx
       ja fornext
       push cx
       mov al,3
       mov ah,0ch

        mov cx,si
       mov dx,di
       int 10h
       pop cx
       dec di
       jmp col
  fornext:
       inc si
       mov cx,x0
       add cx,r
       cmp si,cx
       ja exit1
       mov di,y0
       jmp nextcol
 exit1:
     mov si,x0
     mov di,y0
  nextcol1:
       push si
       sub si,x0
       square si
       mov cx,ax
       square r
       sub ax,cx
       mov cx,ax
       pop si

  col1:
       push bx
       mov  bx,y0
       sub bx,di
       square bx
       pop bx
       cmp ax,cx
       ja fornext1
       push cx
       mov al,3
       mov ah,0ch

       mov cx,si
       mov dx,di
       int 10h
       pop cx
       inc di
       jmp col1
  fornext1:
       inc si
       mov cx,x0
       add cx,r
       cmp si,cx
       ja exit2
       mov di,y0
       jmp  nextcol1

  exit2:
     mov si,x0
     mov di,y0
nextcol2:
       push si
       sub si,x0
       square si
       mov cx,ax
       square r
       sub ax,cx
       mov cx,ax
       pop si

  col2:
       push bx
       mov  bx,y0
       sub bx,di
       square bx
       pop bx
       cmp ax,cx
       ja fornext2
       push cx
       mov al,3
       mov ah,0ch

       mov cx,si
       mov dx,di
       int 10h
       pop cx
       dec di
       jmp col2
  fornext2:
       dec si
       mov cx,x0
       sub cx,r
       cmp si,cx
       jb exit3
       mov di,y0
       jmp nextcol2

 exit3:
     mov si,x0
     mov di,y0
nextcol3:
       push si
       sub si,x0
       square si
       mov cx,ax
       square r
       sub ax,cx
       mov cx,ax
       pop si

  col3:
       push bx
       mov  bx,y0
       sub bx,di
       square bx
       pop bx
       cmp ax,cx
       ja fornext3
       push cx
       mov al,3
       mov ah,0ch

       mov cx,si ;列
       mov dx,di ;行
       int 10h
       pop cx
       inc di
       jmp col3
  fornext3:
       dec si
       mov cx,x0
       add cx,r
       cmp si,cx
       ja exit
       mov di,y0
      jmp nextcol3
exit :
      mov dx,65000
      call delay

      mov ah,00
      mov al,3
      int 10h
ret
    main    endp

.EXIT 0

end