;�е���Ŀ���Ӽ�������һϵ����$Ϊ���������ַ�����Ȼ������еķ������ַ�����������ʾ�����������

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
        add buf3,AL   ; alΪ����ʮλ
        add buf3[1],ah ;AHΪ�����Ǹ�λ

      MOV AH,9
      LEA DX,BUF2
      INT 21H
      
      MOV AH,9      ;��ʮ������ʽ��ʾ�ַ�����
      LEA DX,BUF3
      INT 21H
      
      MOV AH,4CH
      INT 21H
CODE ENDS
     END BEGIN

     ;��MASM615���ͨ��������������hello123boy!$;�����09����9���ַ�