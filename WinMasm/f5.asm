.model small
.386
.stack
.data
  array db 12,23,4,6,67,99,45,34,100,66,58 ;任意数组定义
  len equ $-array                      ;LEN为数组长度
  max db  ?
  min db  ?
 .code
 .startup

   MOV SI,0
   MOV AL,ARRAY
   MOV MAX,AL
   MOV MIN,AL
   MOV CX,LEN-1
  AGAIN: MOV AL,ARRAY[SI+1]
   .IF AL> MAX
     MOV MAX,AL
   .ENDIF
   .IF AL<MIN
     MOV MIN,AL
   .ENDIF
   INC SI
   LOOP AGAIN
  .exit 0
   end
   
  ;最大值在MAX中,最小值在MIN中