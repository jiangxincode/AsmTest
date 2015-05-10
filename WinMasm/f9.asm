DATA  SEGMENT
HAN DB 42,62,68,70,79,82,85,90,95
MEM DB 6 dup(30h),'$'   ;分别用于存放各分数段成绩的个数
DATA ENDS
CODE SEGMENT
     ASSUME DS:DATA,CS:CODE
START: MOV AX,DATA
       MOV DS,AX
       MOV CX,9
       mov si,0
begin:
      .if han[si]<60
        add mem[0],1
      .elseif han[si]>=60 &&  han[si]<=69
        add mem[1],1
      .elseif han[si]>=70 &&  han[si]<=79
        add mem[2],1
      .elseif han[si]>=80 &&  han[si]<=89
        add mem[3],1
      .elseif han[si]>=90 &&  han[si]<=99
        add mem[4],1
      .else
        add mem[5],1
      .endif
      inc si
   loop begin

       mov dx,offset mem   ;显示统计结果122220
       mov ah,9
       int 21h
       MOV AX,4C00H
       INT 21H
CODE  ENDS
END  START
