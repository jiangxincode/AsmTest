####################################################################################
#  Program Name: ch2_2.s
#  Programmer: jiangxin
#  Data last modified: 2014-04-26
####################################################################################
#  Functional Description:
#  Calculate: s3 = t2 / (s1 - 54321)
####################################################################################
#  Pseudocode description of algorithm:
#  s3 = t2 / (s1 - 54321)
####################################################################################
#  Cross References:
####################################################################################
	.data
Promote1:.asciiz	"\n Please Inout a value for t2:"
Promote2:.asciiz	"\n Please Inout a value for s1:"

Result:	.asciiz	"\n s3 is:\t"
Bye:	.asciiz	"\n *** JiangXin -Have a good day***"
	.globl main
	.text
main:
	li $v0,4 # system call code for Print String
	la $a0,Promote1 # promote for inputing t2
	syscall
	
	li $v0,5 # Read Integer:s0 for t2
	syscall
	move $t2,$v0
	
	li $v0,4 # system call code for Print String
	la $a0,Promote2 # promote for inputing s1
	syscall
	
	li $v0,5 # Read Integer:s1 for s1
	syscall
	move $s1,$v0
	
	li $t0,54321
	sub $t0,$s1,$t0
	div $t2,$t0
	mflo $s3
	
	li $v0,4 # system call code for Print String
	la $a0,Result # output the result of s3
	syscall
	
	li $v0,1 # system call code for Print String
	move $a0,$s3
	syscall
	
end:
	li $v0,4 # system call code for PrintString
	la $a0,Bye # output the Bye
	syscall
	
	li $v0,10 # system call code for Exit
	syscall
