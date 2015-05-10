    DATA SEGMENT
    BUFR DB 50,?,50 DUP(?)
    LESG DB 0DH,0AH,'How old are you?:$'
    NESG DB 0DH,0AH,'You are very young!:$'
    OESG DB 0DH,0AH,'Success!:$'
    PESG DB 0DH,0AH,'Make a good health to you!:$'
    DATA ENDS
    STACK SEGMENT PARA STACK 'STACK'
           DB 100 DUP(?)
    STACK ENDS
    CODE SEGMENT
         ASSUME CS:CODE,DS:DATA,SS:STACK
    START PROC FAR
          PUSH DS
          MOV AX,0
          PUSH AX
          MOV AX,DATA
          MOV DS,AX
     DISP:MOV DX,OFFSET LESG
          MOV AH,9
          INT 21H
     KEY:MOV DX,OFFSET BUFR
         MOV AH,10
         INT 21H
         MOV BX,word ptr bufr[2]
         xchg bh,bl
         CMP BX,3230H
         Jbe NEXT
         CMP BX,3430H
         Jbe NEXT1
         MOV DX,OFFSET PESG
         MOV AH,9
         INT 21H
         RET
     NEXT:MOV DX,OFFSET NESG
          MOV AH,9
          INT 21H
          RET
     NEXT1:MOV DX,OFFSET OESG
           MOV AH,9
           INT 21H
           RET
     START ENDP
     CODE ENDS
          END START