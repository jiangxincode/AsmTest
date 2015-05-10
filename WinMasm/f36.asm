;从键盘输入０－２０之间一个自然数Ｎ，将其平方值送显示器．
;例如：提示：
;ＩＮＰＵＴ　ＢＹＴＥ　ＢＣＤ：
;输入：９
;输出：８１

stack  segment stack'stack'
       dw 32 dup(0)
stack  ends
data   segment
INPUT  DB'PLEASE INPUT N(0-2O):$'
LFB  DB '  0$  1$  4$  9$ 16$ 25$ 36$ 49$ 64$ 81$100$121$144$169$196$225$256$289$324$361$400$'
N    Db 3,0,3 DUP(0)
data   ends
code   segment
begin  proc far
       assume  ss: stack,cs: code,ds: data
       push ds
       sub ax,ax
       push ax
       mov ax,data
       mov ds,ax

       start:
       MOV DX,OFFSET INPUT
       MOV AH,9
       INT 21H
       MOV DX,OFFSET N
       MOV AH,10
       INT 21H
       MOV DL,0AH
       MOV AH,2
       INT 21H

        MOV Al, N[2]
        and al,0fh
       .if n[1]>1
         mov bl,10
         mul bl
         and n[3],0fh
         add al,n[3]
       .elseif n[1]==0
         jmp start
       .endif
       
       .if al>20
         jmp start
       .endif
       
       mov bl,4
       mul bl
       mov bx,ax
       lea dx,LFB[bx]
       mov ah,9
       int 21h

        ret
begin   endp
code    ends
        end begin
