####################################################################################
#  Program Name: ch2_1.s
#  Programmer: jiangxin
#  Data last modified: 2014-04-26
####################################################################################
#  Functional Description:
#  Calculate: t3 = t4 + t5 - t6
####################################################################################
#  Pseudocode description of algorithm:
#  t3 = t4 + t5 - t6
####################################################################################
#  Cross References:
####################################################################################
	.data
Promote1:.asciiz	"\n Please Inout a value for t4:"
Promote2:.asciiz	"\n Please Inout a value for t5:"
Promote3:.asciiz	"\n Please Inout a value for t6:"

Result:	.asciiz	"\n t3 is:\t"
Bye:	.asciiz	"\n *** JiangXin -Have a good day***"
	.globl main
	.text
main:
	li $v0,4 # system call code for Print String
	la $a0,Promote1 # promote for inputing t4
	syscall
	
	li $v0,5 # Read Integer:s0 for t4
	syscall
	move $t4,$v0
	
	li $v0,4 # system call code for Print String
	la $a0,Promote2 # promote for inputing t5
	syscall
	
	li $v0,5 # Read Integer:s1 for t5
	syscall
	move $t5,$v0
	
	li $v0,4 # system call code for Print String
	la $a0,Promote3 # promote for inputing t6
	syscall
	
	li $v0,5 # Read Integer:s2 for t6
	syscall
	move $t6,$v0
	
	add $t3,$t4,$t5
	sub $t3,$t3,$t6
	
	li $v0,4 # system call code for Print String
	la $a0,Result # output the result of t3
	syscall
	
	li $v0,1 # system call code for Print String
	move $a0,$t3
	syscall
	
end:
	li $v0,4 # system call code for PrintString
	la $a0,Bye # output the Bye
	syscall
	
	li $v0,10 # system call code for Exit
	syscall
