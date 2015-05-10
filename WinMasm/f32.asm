.model small
.stack
.data

   student struct    ;结构定义
          snumber db 0   ;编号，代表名次
          sid db 15 dup(0)  ;学号
          sname db 20 dup('-');最多20位，姓名
          score1  dw 0  ;成绩1
          score2  dw 0  ;成绩2
          score3  dw 0  ;成绩3
          ttscore dw 0 ; 总分
   student ends
   
   scoresheet student <1,'computer01$','zhangsan$',90,70,60,>
              student <2,'computer02$','lisi$',100,0,100,>
              student <3,'computer03$','wanger$',95,66,88,>
              student <4,'computer04$','zhuwu$',120,90,99,>
              student <5,'computer05$','john$',90,80,95,>
           ;成绩单长度可以任意，这里只列举5个纪录
   sheetlength=($-scoresheet)/(type scoresheet);成绩单长度，即纪录条数

.code
    nextline macro  ;显示换行宏
      mov ah,2
      mov dl,10
      int 21h
      mov ah,2
      mov dl,13
      int 21h
     endm
     dispblank macro  ;显示空格宏
      mov ah,2
      mov dl,' '
      int 21h
     endm
     dispscore macro  ;显示3位十进制数 的宏
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
  .repeat                       ;统计总分
    mov ax,[bx].student.score1
    add ax,[bx].student.score2
    add ax,[bx].student.score3
    mov [bx].student.ttscore,ax
    mov [bx].student.snumber, 0   ;名次初始化为0
    add bx, type scoresheet
  .untilcxz

   mov dx,0  ;DX控制总循环次数
   push dx
  begin:
   lea bx, scoresheet
   mov cx, sheetlength
  .repeat
    .if [bx].student.snumber==0
      mov ax,[bx].student.ttscore  ;找到第一个未排名的纪录
      .break
    .else
      add bx, type scoresheet
    .endif
  .untilcxz

    mov bx,offset scoresheet
    mov cx,sheetlength
   .repeat
    .if [bx].student.snumber==0
      .if [bx].student.ttscore>=ax  ;逐一比较，找到一个未排序的且总分最高的纪录
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
    mov dl,[bx].student.snumber   ;显示名次
    add dl,30h
    mov ah,2
    int 21h
    dispblank
    lea dx, [bx].student.sid       ;显示学号
    mov ah,9
    int 21h
    dispblank
    lea dx, [bx].student.sname   ;显示NAME
    mov ah,9
    int 21h
    mov di,bx
     dispblank
     mov ax, [di].student.score1   ;显示成绩1
     dispscore
     dispblank
     mov ax, [di].student.score2   ;显示成绩2
     dispscore
     dispblank
     mov ax, [di].student.score3   ;显示成绩3
     dispscore
     dispblank
     mov ax, [di].student.ttscore  ;显示总分
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
