1.下面程序完成十进制数3298+4651的运算,并将结果存入SUM单元开始的2个字节单元中,请将程序补充完整; 
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

2.下面程序利用DOS系统功能调用,完成将键盘输入的小写字母转换成答谢字母后输出显示,直到输入"空格"符时结束,请将程序补充完整 
CODE SEGMENT 
ASSUME CS:CODE 
DISPLAY PROC NEAR 
BEGIN: MOV AH,01H 
INT 21H 
((1)_______) cmp al,20h;空格的ASCII码为20H
JZ STOP 
CMP AL,'a' 
JB STOP 
CMP AL,'z' 
JA STOP 
((2)________) sub al,20h
((3)________) MOV DL，AL
MOV AH,02H 
INT 21H 
JMP BEGIN 

STOP: RET 
DISPLAY ENDP 
CODE ENDS 


3.设X、Y均为存放在X和Y单元中的16位操作数，先判断X>30否，如满足条件则转到TOO_HIGH去执行，否则做X-Y，如溢出则转到OVERFLOW去执行，否则计算|X-Y|，并把结果存入RESULT中。请将程序补充完整 
MOV AX,X 
CMP AX,30 
((1)___)TOO_HIGH   ；JG TOO_HIGH
SUB AX，Y 
((2)___)OVERFLOW   ；JO OVERFLOW
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
问:该程序执行后,AL=((1)_0F9H_),CF=((2)_1__) 

2.MOV AX,BX 
NEG AX 
ADD AX,BX 
问:该程序执行后AX=((3)_____),CF=((4)_______) 
有两种情况：当BX初值为0时，结果为AX=0，CF=0
            当BX初值不为0时，结果为AX=0，CF=1


3.BUF DW 0000H 
. 
. 
LEA BX,BUF 
STC 
RCR WORD PTR[BX],1 
MOV CL ,3 
SAR WORD PTR[BX],CL 
问:该程序段执行后,存储单元BUF的内容为((5)_0F000H___) 

4.BLOCK DB 20H,1FH,08H,81H,0FFH …… 
RESULT DB ？ 
。 
。 
START： LEA SI，BLOCK 
MOV CX，[SI] 
INC SI 
MOV AL，[SI] 
LOP1： CMP AL，[SI+1] 
JNG NEXT 
MOV AL，[SI+1] 
NEXT： INC SI 
LOOP LOP1 
MOV RESULT，AL 
HLT 

问：该程序完成的功能是((6)___把BLOCK表中的最大值存入RESULT中__) 
该程序执行的循环次数是((7)___20H次____) 

5.MOV AX,00FFH 
MOV BX,0FFFFH 
XOR AX,BX 
NEG AX 
问:该程序段执行后AX=((8)__100H___),CF=((9)___1____) 

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

问:该程序所完成的功能可用算术表达式表示为((10)__1+2*3+3*4+4*5+5*6___) 
该程序完成后CX=((11)____69_____) 



顺便还有几道填空 
1.假设某个字的值是1234H,其低位字节地址是42H,高位字节地址是43H,那该字的字地址是( 42H) 
2."SHL OPR,CNT"指令中的OPR不允许使用段寄存器和( 立即数)操作数 
3."VAR DB 4 DUP(8,2 DUP(5))"语句汇编应分配( 44)个字节单元. 
4.指令"MOV AX,20H[SI]"中源操作数的物理地址表达式是( DS*16+SI+20H) 
5.乘法指令语句"MUL CX",32位的乘积存放在( DX：AX)中. 
6.指令LOOPZ的循环执行条件是(CX>0并且ZF=1 ) 
7.表示段定义结束的命令是( ENDS) 
 
