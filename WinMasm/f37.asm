;��strin��Ԫ����100���ַ��������е����д�дӢ����ĸ�޸�ΪСд��Ӣ����ĸ��
;�����е�ʮ�������ַ���0��-��9���ҳ�����ŵ�dnum��Ԫ��Ĵ洢���У�
;�����ô洢�����ȴ���DNUML��Ԫ�С�������ʾ����
.model small
.stack
.data
strin db 'skdjfa!@kdjfALDJASFASDKFJASD34***%U534035023ASKDHalk()djas',0ah,0dh,'$'
lengths equ $-strin   ;�ַ����ĳ��ȿ������⣬��Ҫ��$��β���м䲻����$
dnum db 100 dup (?)
DNUML db 0
.code
.startup

  mov dx,offset strin ;��ʾԭ����strin
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
    mov dnum[di],'$'  ;Ϊ��� dnum��׼��
    mov ax,di
    dec ax
    mov dnuml,al     ;���泤��
  .endif
  
  mov dx,offset strin   ;��ʾת������strin
  mov ah,9
  int 21h
  
  mov dx,offset dnum
  mov ah,9
  int 21h

.exit 0
end