����������ǽ�1110111110111001bת�������bcd���ʾ�ĸ�ʮ������λ����
����MASEdit1.0.8�����꣬û�д�����ʾ�����޷����ӣ����λָ��

Stack segment stack
     dw 2 dup(0)
stack ends


data segment
     array    dw 5 dup(?)����Ÿ�λ����
     table dw 30h,31h,32h,33h,34h,35h,36h,37h,38h,39h
     count db 0    ����¼siƫ����
     data    ends


code segment  'code'
      assume    cs:code,ds:data,ss:stack
start:mov  ax,data
      mov  ds,ax
      mov  dx,1110111110111001b
      xor    ax,ax    �����ѭ������
      mov  bx,10000   ����һ�α�����Ϊ10000��bx��ű�����
      mov  cx,5    ������ѭ����������λ����
      lea  si,array    �����array����Ч��ַ
AGAIN:div   bx    ��bx�ڴ�ű�����
      push  dx    ������ÿ�γ����������
      call  THENUM    ���ӳ��򱣴��λ�������ı䱻����
      pop   dx    ����������
      loop  AGAIN    ��ѭ�����λ����
      push  bx    �����汻������bl��ʱ���si��λ����
      mov   bl,count
      sub   si,bx    ���ص���λ���ֵ�ַ
      pop   bx    ����������
      mov   cx,5    ��ת����bcd�����ʾ�����ѭ������
BCDCODE:mov  bx,table
        mov  al,[si]
        xlat    ������ָ����õ�ǰ���ֵ�bcd��
        mov   dl,al    �������λ
        mov   ah,2
        int   21h
        add   si,2    ������һλ
        loop  BCDCODE    ��ѭ������һλ
        mov   ax,4c00h
        int   21h
THENUM proc    ���ӳ��򣺱����λ���ֲ��ı䱻����
       mov   [si],ax    �����浱ǰλ������
       add   si,2    ������һλ
       add   count,2    ����������¼si��ƫ��
       xor   ax,ax    ��������
       mov   dx,bx    ������һ�εı������͸�dx��׼���������ʮ
       mov   bx,10
       div   bx    ������������ʮ
       mov   bx,ax    �����µı������͸�bx
       ret
THENUM  endp
code    ends
        end  start