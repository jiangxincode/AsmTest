 ����,��������!


����ָ�������2��Ĵ�

5��˫�ֽ�����������ⲿRAM��barf��ʼ�ĵ�Ԫ�У������ǵĺͣ����ѽ������SUM��ʼ�ĵ�Ԫ�У����ʵ��

���ڲ�RAM20H��Ԫ��ʼ���һ�������¦���ֽڸ�������1FH�У���ͳ�Ƴ����д���0������0��С��0��������Ŀ�����ѽ���ֱ����one,two ,three 3����Ԫ��


.model small
.386
.stack
.data
  barf dw 1234h,2345h,3456h,4567h,5678h
  sum  dd ?
  ram20 sbyte 1,2,0,0f0h,0a1h,0bch,4,5,0,100;�ɶ����������з����ֽ�����
  ram1f dw $-ram20          ;�������鳤��
  one db 0
  two db 0
  three db 0
.code
.startup
     xor eax,eax          ;eax��32λ�Ĵ���
     mov cx,5
     mov si,0
     begin1:
     add ax,barf[si]      ;16λ���
     .if carry?            ;����н�λ��CF=1
       add eax,10000h      ;EAX�ĸ�16λ�м�1
     .endif
     add si,4
     loop begin1
     mov sum, eax
    ;��2С��
     mov cx, ram1f
     mov si,0
     begin2:
     .if ram20[si]>0
      inc one
     .elseif ram20[si]==0
      inc two
     .else
      inc three
     .endif
     inc si
     loop begin2
     
     .exit 0
     END

     ;��MASM615���ͨ������DEBUG���Բ鿴�����SUM=018D02H
                                            ;ONE��TWO��THREE�ֱ�Ϊ5��2��3