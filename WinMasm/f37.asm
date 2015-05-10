;从strin单元起有100个字符，将其中的所有大写英文字母修改为小写的英文字母，
;将其中的十进制数字符‘0’-‘9’找出，存放到dnum单元起的存储区中，
;并将该存储区长度存入DNUML单元中。并将显示出来
.model small
.stack
.data
strin db 'skdjfa!@kdjfALDJASFASDKFJASD34***%U534035023ASKDHalk()djas',0ah,0dh,'$'
lengths equ $-strin   ;字符串的长度可以任意，但要以$结尾，中间不能有$
dnum db 100 dup (?)
DNUML db 0
.code
.startup

  mov dx,offset strin ;显示原来的strin
  mov ah,9
  int 21h
  
  mov si,0
  mov di,0
  .while strin[si]!='$'
    .if  strin[si]>='A' &&  strin[si]<='Z'
         add  strin[si],20h
    .elseif  strin[si]>='0' &&  strin[si]<='9'
         mov al,strin[si]
         mov dnum[di],al
         inc di
    .endif
    inc si
  .endw
  .if di>0
    mov dnum[di],'$'  ;为输出 dnum串准备
    mov ax,di
    dec ax
    mov dnuml,al     ;保存长度
  .endif
  
  mov dx,offset strin   ;显示转换过的strin
  mov ah,9
  int 21h
  
  mov dx,offset dnum
  mov ah,9
  int 21h

.exit 0
end