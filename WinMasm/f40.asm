;�˳���������ӡASCII��
STACK SEGMENT STACK
      DB 200 DUP(0)
STACK ENDS
CODE  SEGMENT
      ASSUME CS:CODE,SS:STACK
START:MOV BL,0H
      MOV BH,0H
OUTER1: ADD BL,BH
;���������ַ�����������ַ���
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
;���������ַ�
OUTER2: MOV DL,BL
        MOV AH,2
        INT 21H
OUTER3: MOV DL,20H ;����ո�
        MOV AH,2
        INT 21H
        ADD BL,10H  ;�ı���ѭ������
        SUB BL,BH
        CMP BL,0F0H  ;�Ƚ���ѭ��������ת��������ֵ
        JNE OUTER1
        MOV BL,0F0H   ;���ÿһ�е����һ���ַ�
        ADD BL,BH
        MOV DL,BL
        MOV AH,2
        INT 21H
OUTER4: MOV DL,0AH   ;����س�����
        MOV AH,2
        INT 21H
        MOV DL,0DH
        MOV AH,2
        INT 21H
        INC BH    ;�ı���ѭ������
        MOV BL,0H   ;��ѭ����������
        CMP BH,0FH   ;�Ƚ���ѭ��������ת��������ֵ
        JLE OUTER1
        MOV AH,4CH
        INT 21H
CODE  ENDS
      END START