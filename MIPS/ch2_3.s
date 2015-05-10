####################################################################################
#  Program Name: ch2_3.s
#  Programmer: jiangxin
#  Data last modified: 2014-04-26
####################################################################################
#  Functional Description:
#  Calculate: sp = sp - 16
####################################################################################
#  Pseudocode description of algorithm:
#  sp = sp - 16
####################################################################################
#  Cross References:
####################################################################################
	.data
Start:	.asciiz "At Start,the sp is:"
End:	.asciiz	"At End,the sp is:"
Bye:	.asciiz	"\n *** JiangXin -Have a good day***"
	.globl main
	.text
main:
	li $v0,4 # system call code for Print String
	la $a0,Start # promote for inputing t2
	syscall
	
	li $v0,1 # Print the $sp at Start
	move $a0,$sp
	syscall
	
	subu $sp,$sp,16
	
	li $v0,4 # system call code for Print String
	la $a0,End # promote for inputing s1
	syscall
	
	li $v0,1 # Print the $sp at End
	move $a0,$sp
	syscall	
end:
	li $v0,4 # system call code for PrintString
	la $a0,Bye # output the Bye
	syscall
	
	li $v0,10 # system call code for Exit
	syscall
