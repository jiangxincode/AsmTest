;功能是：输入两个字符串，判断所含字符是否相同，相同则输出：MATCH，不相同则输出:NOMATCH

DATA SEGMENT
     INFOR1 DB 0AH,0DH,"MATCH! $"
     INFOR2 DB 0AH,0DH,"NOMATCH! $"
     INFOR3 DB 0AH,0DH,"please input the first one: $"
     infor4 DB 0AH,0DH,"please input the second one: $"
     string1 db 20,0,20 DUP(?)
     string2 db 20,0,20 DUP(?)
DATA ENDS
STACK SEGMENT STACK PARA 'STACK'
      DW 256 DUP(?)
STACK ENDS
CODE SEGMENT
     ASSUME CS:CODE,DS:DATA,SS:STACK
START:MOV AX,DATA
      MOV DS,AX
      mov es,ax
      LEA DX,INFOR3
      MOV AH,09H
      INT 21H
      LEA  DX,string1
      MOV AH,0AH
      INT 21H
      LEA DX,INFOR4
      MOV AH,09H
      INT 21H
      LEA DX,string2
      MOV AH,0AH
      INT 21H
      mov al,string1[1]
      CMP al,string2[1]
      Jne NOMATCH
      LEA SI,STRING1[2]
      LEA DI,STRING2[2]
      MOV CL,AL
      MOV CH,0
      REPE CMPSB
      JNZ NOMATCH
      LEA DX,INFOR1
      MOV AH,09H
      INT 21H
      JMP PEND
NOMATCH:LEA DX,INFOR2
      MOV AH,09H
      INT 21H
PEND:MOV AH,4CH
     INT 21H
CODE ENDS
     END START