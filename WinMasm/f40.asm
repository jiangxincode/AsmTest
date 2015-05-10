;此程序用来打印ASCII码
STACK SEGMENT STACK
      DB 200 DUP(0)
STACK ENDS
CODE  SEGMENT
      ASSUME CS:CODE,SS:STACK
START:MOV BL,0H
      MOV BH,0H
OUTER1: ADD BL,BH
;处理特殊字符（不可输出字符）
        CMP BL,0AH
        JE COUT_BREAK
        CMP BL,0DH
        JE COUT_BREAK
        CMP BL,07H
        JE COUT_BREAK
        CMP BL,08H
        JE COUT_BREAK
        CMP BL,09H
        JNE OUTER2
COUT_BREAK:MOV DL,20H
           MOV AH,2
           INT 21H
           JMP OUTER3
;处理可输出字符
OUTER2: MOV DL,BL
        MOV AH,2
        INT 21H
OUTER3: MOV DL,20H ;输出空格
        MOV AH,2
        INT 21H
        ADD BL,10H  ;改变列循环变量
        SUB BL,BH
        CMP BL,0F0H  ;比较列循环变量与转移条件的值
        JNE OUTER1
        MOV BL,0F0H   ;输出每一行的最后一个字符
        ADD BL,BH
        MOV DL,BL
        MOV AH,2
        INT 21H
OUTER4: MOV DL,0AH   ;输出回车换行
        MOV AH,2
        INT 21H
        MOV DL,0DH
        MOV AH,2
        INT 21H
        INC BH    ;改变行循环变量
        MOV BL,0H   ;列循环变量置零
        CMP BH,0FH   ;比较行循环变量与转移条件的值
        JLE OUTER1
        MOV AH,4CH
        INT 21H
CODE  ENDS
      END START