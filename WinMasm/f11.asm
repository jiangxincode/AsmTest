;有道题目：从键盘输入一系列以$为结束符的字符串，然后对其中的非数字字符计数，并显示出计数结果。

STACK SEGMENT
      DB 200 dup(?)
STACK ENDS
DATA SEGMENT
SUM DB ?
BUF DB "PLASE INPUT A CHARACTER STRING:$"
BUF1 DB 30
     DB ?
     DB 30 DUP(?)
BUF2 DB 0AH,0DH,"(SUM)=$"
BUF3 DB 30h,30h,'$'
DATA ENDS
CODE SEGMENT
     ASSUME DS:DATA,CS:CODE,SS:STACK
BEGIN:MOV AX,DATA
      MOV DS,AX
      MOV AH,9
      LEA DX,BUF
      INT 21H
      MOV AH,10
      LEA DX,BUF1
      INT 21H
      XOR CL,CL
      LEA SI,BUF1+2
COMP:MOV DL,[SI]
     CMP DL,"$"
     JZ DISPLAY
     CMP DL,30H
     JB CHAR
     CMP DL,39H
     JA CHAR
     INC SI
     JMP COMP
CHAR:INC SI
     INC CL
     JMP COMP
DISPLAY: xor ax ,ax
        MOV al,CL
        mov bl,10
        div bl        ;ax/10
        add buf3,AL   ; al为商是十位
        add buf3[1],ah ;AH为余数是个位

      MOV AH,9
      LEA DX,BUF2
      INT 21H
      
      MOV AH,9      ;以十进制形式显示字符个数
      LEA DX,BUF3
      INT 21H
      
      MOV AH,4CH
      INT 21H
CODE ENDS
     END BEGIN

     ;用MASM615汇编通过，如果输入的是hello123boy!$;则输出09，即9个字符