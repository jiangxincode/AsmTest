.model  small
.386
.stack
.data
 tishi1 db 10,13,'please input a:',13,10,'$'
 tishi2 db 10,13,'please input b:',13,10,'$'
 tishi3 db 10,13,'please input c:',13,10,'$'
 temp db 4 dup(?);用于临时存放输入的四个字符
.code
    output macro  tishi ;显示提示信息
      lea dx, tishi
      mov ah,9
      int 21h
    endm

    input macro ;输入4个字符
      local first,second,third,forth,inputend
      MOV DWORD PTR TEMP,-1 ;输入前使4个字节都设为无效值
      first:
        mov ah,1
        int 21h
        .if   al=='+' || al=='-'  ;第一个字符必须是+或-号，其他无效，重新输入
            mov temp[0],al
        .else
            jmp first
        .endif
     second:
        mov ah,1
        int 21h
        .if   al>=30h && al<=39h ;第二个字符必须是数字，否则无效，重新输入
            and al,0fh
            mov temp[1],al
        .else
            jmp second
        .endif
     third:
        mov ah,1
        int 21h
        .if   al>=30h && al<=39h ;第三个字符可以是数字，如果不是数字则结束输入
            and al,0fh
            mov temp[2],al
        .else
            jmp inputend
        .endif
     forth:
        mov ah,1
        int 21h
        .if   al>=30h && al<=39h
            and al,0fh    ;第4个字符可以是数字，如果不是数字则结束输入
            mov temp[3],al
        .else
            jmp inputend
        .endif
      inputend:
    endm

    covert macro    ;该宏把输入的字符转换为有符号数，并压入堆栈
      local theend
           mov ax,0
           mov al,temp[1]     ;假设temp的4个字节内容依次为-234，
          .if temp[2]>=0 && temp[2]<=9 ; 则本处完成2*10+3 存入ax
              mov bl,10
              mul bl
              add al,temp[2]
              adc ah,0
           .else
              jmp theend
           .endif

          .if temp[3]>=0 && temp[3]<=9 ;假设temp的4个字节内容依次为-234，
              mov bl,10                ; 则本处完成（2*10+3）*10+4 存入ax
              mul bl
              add al,temp[3]
              adc ah,0
          .endif

         theend:            ;如果输入的符号位为-号，则取其相反数
         .if temp[0]== '-'
             neg ax
         .endif
          push ax        ;入栈
      endm

       DISPCHAR MACRO NUMBER  ;该宏显示ax寄存器值除以NUMBER所得的1位10进制商
        POP ax
        
          MOV DX,0
          mov bX,NUMBER
          div bX
          PUSH DX     ;余数入栈，为现实下一位准备
          MOV DL,AL
          ADD DL,30H
          MOV AH,2
          INT 21H
        
       ENDM

.startup
       output tishi1
       input
       covert       ;把第1次数输入的数转化为16位二进制数并入栈
       output tishi2
       input
       covert         ;把第2次数输入的数转化为16位二进制数并入栈
       output tishi3
       input
       covert        ;把第3次数输入的数转化为16位二进制数并入栈
       
        mov ah,2
        mov dl,10
        int 21h
        
       pop cx        ;弹出第3个数c
       pop bx        ;弹出第2个数b
       pop ax        ;弹出第1个数a
       add ax,bx     ;a+b
       imul ax,cx    ;(a+b)*c

       or ax,ax
       .if sign?
         mov dl,'-'  ;显示正负符号
         neg ax
       .else
         mov dl,'+'
       .endif
        PUSH AX
        mov  ah,2
        int 21h

        DISPCHAR 10000 ;显示万位
        DISPCHAR 1000  ;显示千位
        DISPCHAR 100   ;显示百位
        DISPCHAR 10    ;显示十位
        DISPCHAR 1     ;显示个位

 .exit 0
end

输入：+5
      +10
      -20
显示：-300

输入：-100
      -100
      +100
显示：-20000