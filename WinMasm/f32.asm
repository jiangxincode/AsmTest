.model small
.stack
.data

   student struct    ;�ṹ����
          snumber db 0   ;��ţ���������
          sid db 15 dup(0)  ;ѧ��
          sname db 20 dup('-');���20λ������
          score1  dw 0  ;�ɼ�1
          score2  dw 0  ;�ɼ�2
          score3  dw 0  ;�ɼ�3
          ttscore dw 0 ; �ܷ�
   student ends
   
   scoresheet student <1,'computer01$','zhangsan$',90,70,60,>
              student <2,'computer02$','lisi$',100,0,100,>
              student <3,'computer03$','wanger$',95,66,88,>
              student <4,'computer04$','zhuwu$',120,90,99,>
              student <5,'computer05$','john$',90,80,95,>
           ;�ɼ������ȿ������⣬����ֻ�о�5����¼
   sheetlength=($-scoresheet)/(type scoresheet);�ɼ������ȣ�����¼����

.code
    nextline macro  ;��ʾ���к�
      mov ah,2
      mov dl,10
      int 21h
      mov ah,2
      mov dl,13
      int 21h
     endm
     dispblank macro  ;��ʾ�ո��
      mov ah,2
      mov dl,' '
      int 21h
     endm
     dispscore macro  ;��ʾ3λʮ������ �ĺ�
     mov bl,100
     div bl
     mov bh,ah
     mov dl,al
     add dl,30h
     mov ah,2
     int 21h
     mov al,bh
     mov ah,0
     mov bl,10
     div bl
     mov dl,al
     mov dh,ah
     add dl,30h
     mov ah,2
     int 21h
     mov dl,dh
     add dl,30h
     mov ah,2
     int 21h
     endm
.startup

  lea bx, scoresheet
  mov cx,sheetlength
  .repeat                       ;ͳ���ܷ�
    mov ax,[bx].student.score1
    add ax,[bx].student.score2
    add ax,[bx].student.score3
    mov [bx].student.ttscore,ax
    mov [bx].student.snumber, 0   ;���γ�ʼ��Ϊ0
    add bx, type scoresheet
  .untilcxz

   mov dx,0  ;DX������ѭ������
   push dx
  begin:
   lea bx, scoresheet
   mov cx, sheetlength
  .repeat
    .if [bx].student.snumber==0
      mov ax,[bx].student.ttscore  ;�ҵ���һ��δ�����ļ�¼
      .break
    .else
      add bx, type scoresheet
    .endif
  .untilcxz

    mov bx,offset scoresheet
    mov cx,sheetlength
   .repeat
    .if [bx].student.snumber==0
      .if [bx].student.ttscore>=ax  ;��һ�Ƚϣ��ҵ�һ��δ��������ܷ���ߵļ�¼
         mov ax,[bx].student.ttscore
         mov di,bx
      .endif
    .endif
     add bx, type scoresheet
   .untilcxz

    nextline
    mov bx,di
    pop dx
    inc dl
    push dx
    mov [bx].student.snumber,dl
    mov dl,[bx].student.snumber   ;��ʾ����
    add dl,30h
    mov ah,2
    int 21h
    dispblank
    lea dx, [bx].student.sid       ;��ʾѧ��
    mov ah,9
    int 21h
    dispblank
    lea dx, [bx].student.sname   ;��ʾNAME
    mov ah,9
    int 21h
    mov di,bx
     dispblank
     mov ax, [di].student.score1   ;��ʾ�ɼ�1
     dispscore
     dispblank
     mov ax, [di].student.score2   ;��ʾ�ɼ�2
     dispscore
     dispblank
     mov ax, [di].student.score3   ;��ʾ�ɼ�3
     dispscore
     dispblank
     mov ax, [di].student.ttscore  ;��ʾ�ܷ�
     dispscore
    pop dx
    push dx
    .if dl==sheetlength
     .exit 0
    .endif
    jmp begin

 end

1 computer04 zhuwu 120 090 099 309
2 computer05 john 090 080 095 265
3 computer03 wanger 095 066 088 249
4 computer01 zhangsan 090 070 060 220
5 computer02 lisi 100 000 100 200
