.model small
.stack
.data
	score db 4,0,0,0,0
	prompt db 10,13,'please input a score:$'
.code
.startup
begin:
	mov dx,offset prompt    ;显示提示信息
	mov ah,9
	int 21h
	mov dx,offset score    ;输入字串，最多3位
	mov ah,10
	int 21h
	
	mov dl,10              ;换行
	mov ah,2
	int 21h
	
	mov al,score[2]        ;score[2]是第一个输入的字符的ASCI码
	and al,0fh
	cmp al,0                ;是0则结束程序
	je over
	
	cmp score[1],1          ;score[1],1 保存了输入的数字个数
	je grade                ;只输入1位则直接转到成绩评定，此时AL为成绩
	mov bl,10               ;否则，该位乘以10
	mul bl
	and score[3],0fh
	add al,score[3]         ;再加上下一位数据
	
	cmp score[1],3          ;如果输入的是3位数，则再乘以10再加上第三位数
	jne grade
	mul bl
	and score[4],0fh
	add al,score[4]

grade:
	 XOR AH,AH            ;只用AL就可以表示100及其以内的数值
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

	mov ah,2              ;显示等级字母
	int 21h
	
	jmp begin
over:

	.exit 0
	end