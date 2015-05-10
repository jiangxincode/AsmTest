 STACK  SEGMENT   STACK'stack'
              DW        40 DUP(0)
       STACK  ENDS
       DATA  SEGMENT
input db'please input n(0-7):$'
lfb db '  1$  2$  4$  8$ 16$ 32$ 64$128$'
       DATA  ENDS
        CODE  SEGMENT
       START  PROC      FAR
              ASSUME    SS:STACK,CS:CODE,DS:DATA
              PUSH      DS
              SUB       AX,AX
              PUSH      AX
              MOV       AX,DATA
              MOV       DS,AX
              MOV       DX,OFFSET INPUT
              MOV       AH,9
              INT       21H
              MOV       AH,1
              INT       21H
              and   AL,0fh
              shl al,1
              shl al,1
              mov bh,0
              mov bl,al
              lea       DX, LFB[bx]
              MOV       AH,9
              INT       21H
              RET
       START  ENDP
        CODE  ENDS
              END       START