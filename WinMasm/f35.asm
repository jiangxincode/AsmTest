.model  small
.386
.stack
.data
 tishi1 db 10,13,'please input a:',13,10,'$'
 tishi2 db 10,13,'please input b:',13,10,'$'
 tishi3 db 10,13,'please input c:',13,10,'$'
 temp db 4 dup(?);������ʱ���������ĸ��ַ�
.code
    output macro  tishi ;��ʾ��ʾ��Ϣ
      lea dx, tishi
      mov ah,9
      int 21h
    endm

    input macro ;����4���ַ�
      local first,second,third,forth,inputend
      MOV DWORD PTR TEMP,-1 ;����ǰʹ4���ֽڶ���Ϊ��Чֵ
      first:
        mov ah,1
        int 21h
        .if   al=='+' || al=='-'  ;��һ���ַ�������+��-�ţ�������Ч����������
            mov temp[0],al
        .else
            jmp first
        .endif
     second:
        mov ah,1
        int 21h
        .if   al>=30h && al<=39h ;�ڶ����ַ����������֣�������Ч����������
            and al,0fh
            mov temp[1],al
        .else
            jmp second
        .endif
     third:
        mov ah,1
        int 21h
        .if   al>=30h && al<=39h ;�������ַ����������֣���������������������
            and al,0fh
            mov temp[2],al
        .else
            jmp inputend
        .endif
     forth:
        mov ah,1
        int 21h
        .if   al>=30h && al<=39h
            and al,0fh    ;��4���ַ����������֣���������������������
            mov temp[3],al
        .else
            jmp inputend
        .endif
      inputend:
    endm

    covert macro    ;�ú��������ַ�ת��Ϊ�з���������ѹ���ջ
      local theend
           mov ax,0
           mov al,temp[1]     ;����temp��4���ֽ���������Ϊ-234��
          .if temp[2]>=0 && temp[2]<=9 ; �򱾴����2*10+3 ����ax
              mov bl,10
              mul bl
              add al,temp[2]
              adc ah,0
           .else
              jmp theend
           .endif

          .if temp[3]>=0 && temp[3]<=9 ;����temp��4���ֽ���������Ϊ-234��
              mov bl,10                ; �򱾴���ɣ�2*10+3��*10+4 ����ax
              mul bl
              add al,temp[3]
              adc ah,0
          .endif

         theend:            ;�������ķ���λΪ-�ţ���ȡ���෴��
         .if temp[0]== '-'
             neg ax
         .endif
          push ax        ;��ջ
      endm

       DISPCHAR MACRO NUMBER  ;�ú���ʾax�Ĵ���ֵ����NUMBER���õ�1λ10������
        POP ax
        
          MOV DX,0
          mov bX,NUMBER
          div bX
          PUSH DX     ;������ջ��Ϊ��ʵ��һλ׼��
          MOV DL,AL
          ADD DL,30H
          MOV AH,2
          INT 21H
        
       ENDM

.startup
       output tishi1
       input
       covert       ;�ѵ�1�����������ת��Ϊ16λ������������ջ
       output tishi2
       input
       covert         ;�ѵ�2�����������ת��Ϊ16λ������������ջ
       output tishi3
       input
       covert        ;�ѵ�3�����������ת��Ϊ16λ������������ջ
       
        mov ah,2
        mov dl,10
        int 21h
        
       pop cx        ;������3����c
       pop bx        ;������2����b
       pop ax        ;������1����a
       add ax,bx     ;a+b
       imul ax,cx    ;(a+b)*c

       or ax,ax
       .if sign?
         mov dl,'-'  ;��ʾ��������
         neg ax
       .else
         mov dl,'+'
       .endif
        PUSH AX
        mov  ah,2
        int 21h

        DISPCHAR 10000 ;��ʾ��λ
        DISPCHAR 1000  ;��ʾǧλ
        DISPCHAR 100   ;��ʾ��λ
        DISPCHAR 10    ;��ʾʮλ
        DISPCHAR 1     ;��ʾ��λ

 .exit 0
end

���룺+5
      +10
      -20
��ʾ��-300

���룺-100
      -100
      +100
��ʾ��-20000