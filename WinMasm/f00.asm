1.����������ʮ������3298+4651������,�����������SUM��Ԫ��ʼ��2���ֽڵ�Ԫ��,�뽫���򲹳�����; 
DA1 DB 98H, 32H 
DA2 DB 51H, 46H 
SUM DB 2 DUP(?) 
. 
. 
MOV SI, OFFSET DA1 
LEA DI, DA2 
((1)_______) mov al,[si]
ADD AL, [DI] 
((2)_______) daa
MOV SUM, AL 
MOV AL, [SI+1] 
((3)_______) adc al,[di+1]
DAA 
MOV SUM+1,AL 
HLT 

2.�����������DOSϵͳ���ܵ���,��ɽ����������Сд��ĸת���ɴ�л��ĸ�������ʾ,ֱ������"�ո�"��ʱ����,�뽫���򲹳����� 
CODE SEGMENT 
ASSUME CS:CODE 
DISPLAY PROC NEAR 
BEGIN: MOV AH,01H 
INT 21H 
((1)_______) cmp al,20h;�ո��ASCII��Ϊ20H
JZ STOP 
CMP AL,'a' 
JB STOP 
CMP AL,'z' 
JA STOP 
((2)________) sub al,20h
((3)________) MOV DL��AL
MOV AH,02H 
INT 21H 
JMP BEGIN 

STOP: RET 
DISPLAY ENDP 
CODE ENDS 


3.��X��Y��Ϊ�����X��Y��Ԫ�е�16λ�����������ж�X>30��������������ת��TOO_HIGHȥִ�У�������X-Y���������ת��OVERFLOWȥִ�У��������|X-Y|�����ѽ������RESULT�С��뽫���򲹳����� 
MOV AX,X 
CMP AX,30 
((1)___)TOO_HIGH   ��JG TOO_HIGH
SUB AX��Y 
((2)___)OVERFLOW   ��JO OVERFLOW
((3)___)           ;NEG AX
NONNEG: MOV RESULT,AX 
. 
. 
TOO_HIGH: 
. 
. 
OVERFLOW: 
. 
. 



1.MOV AL, 0FEH 
ADD AL, AL 
ADC AL, AL 
��:�ó���ִ�к�,AL=((1)_0F9H_),CF=((2)_1__) 

2.MOV AX,BX 
NEG AX 
ADD AX,BX 
��:�ó���ִ�к�AX=((3)_____),CF=((4)_______) 
�������������BX��ֵΪ0ʱ�����ΪAX=0��CF=0
            ��BX��ֵ��Ϊ0ʱ�����ΪAX=0��CF=1


3.BUF DW 0000H 
. 
. 
LEA BX,BUF 
STC 
RCR WORD PTR[BX],1 
MOV CL ,3 
SAR WORD PTR[BX],CL 
��:�ó����ִ�к�,�洢��ԪBUF������Ϊ((5)_0F000H___) 

4.BLOCK DB 20H,1FH,08H,81H,0FFH ���� 
RESULT DB �� 
�� 
�� 
START�� LEA SI��BLOCK 
MOV CX��[SI] 
INC SI 
MOV AL��[SI] 
LOP1�� CMP AL��[SI+1] 
JNG NEXT 
MOV AL��[SI+1] 
NEXT�� INC SI 
LOOP LOP1 
MOV RESULT��AL 
HLT 

�ʣ��ó�����ɵĹ�����((6)___��BLOCK���е����ֵ����RESULT��__) 
�ó���ִ�е�ѭ��������((7)___20H��____) 

5.MOV AX,00FFH 
MOV BX,0FFFFH 
XOR AX,BX 
NEG AX 
��:�ó����ִ�к�AX=((8)__100H___),CF=((9)___1____) 

6.CODE SEGMENT 
ASSUME CS:CODE 
ST ART MOV CX,1 
MOV BL,2 
AGAIN: MOV AL,BL 
INC BL 
MUL BL 
ADD CX,AX 
CMP AX,002AH 
JB AGAIN 
MOV AH,4CH 
INT 21H 
CODE ENDS 
END START 

��:�ó�������ɵĹ��ܿ����������ʽ��ʾΪ((10)__1+2*3+3*4+4*5+5*6___) 
�ó�����ɺ�CX=((11)____69_____) 



˳�㻹�м������ 
1.����ĳ���ֵ�ֵ��1234H,���λ�ֽڵ�ַ��42H,��λ�ֽڵ�ַ��43H,�Ǹ��ֵ��ֵ�ַ��( 42H) 
2."SHL OPR,CNT"ָ���е�OPR������ʹ�öμĴ�����( ������)������ 
3."VAR DB 4 DUP(8,2 DUP(5))"�����Ӧ����( 44)���ֽڵ�Ԫ. 
4.ָ��"MOV AX,20H[SI]"��Դ�������������ַ���ʽ��( DS*16+SI+20H) 
5.�˷�ָ�����"MUL CX",32λ�ĳ˻������( DX��AX)��. 
6.ָ��LOOPZ��ѭ��ִ��������(CX>0����ZF=1 ) 
7.��ʾ�ζ��������������( ENDS) 
 
