.model small
.stack
.data
	score db 4,0,0,0,0
	prompt db 10,13,'please input a score:$'
.code
.startup
begin:
	mov dx,offset prompt    ;��ʾ��ʾ��Ϣ
	mov ah,9
	int 21h
	mov dx,offset score    ;�����ִ������3λ
	mov ah,10
	int 21h
	
	mov dl,10              ;����
	mov ah,2
	int 21h
	
	mov al,score[2]        ;score[2]�ǵ�һ��������ַ���ASCI��
	and al,0fh
	cmp al,0                ;��0���������
	je over
	
	cmp score[1],1          ;score[1],1 ��������������ָ���
	je grade                ;ֻ����1λ��ֱ��ת���ɼ���������ʱALΪ�ɼ�
	mov bl,10               ;���򣬸�λ����10
	mul bl
	and score[3],0fh
	add al,score[3]         ;�ټ�����һλ����
	
	cmp score[1],3          ;����������3λ�������ٳ���10�ټ��ϵ���λ��
	jne grade
	mul bl
	and score[4],0fh
	add al,score[4]

grade:
	 XOR AH,AH            ;ֻ��AL�Ϳ��Ա�ʾ100�������ڵ���ֵ
	.if aX>=90
	  mov dl,'A'
	.elseif aX>=80
	  mov dl,'B'
	.elseif aX>=70
	  mov dl,'C'
	.elseif aX>=60
	  mov dl,'D'
	.else
	  mov dl,'E'
	.endif

	mov ah,2              ;��ʾ�ȼ���ĸ
	int 21h
	
	jmp begin
over:

.exit 0
end