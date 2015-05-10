.model small
.stack
.data
.code
 SHIFT MACRO   RR,COUNT
 local next,next1
 MOV  AX,COUNT
 CMP  RR , 64
 JG   NEXT
 MOV  CL,3
 SHR  AX,CL
 JMP   NEXT1
NEXT: CMP   RR,96
 JG  NEXT1
 MOV  CL,6
 SHR  AX,CL
NEXT1:
 ENDM
.startup
mov bx,15
SHIFT  bx,7FFFH
mov bx,80
SHIFT  bx,9FFFH
 .exit 0
 end