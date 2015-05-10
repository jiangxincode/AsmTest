####################################################################################
#  Program Name: Sum of chico
#  Programmer: jiangxin
#  Data last modified: 2014-04-28
####################################################################################
#  Functional Description:
#  Write a MIPS assembly language program to find the sum of the first 100 words of 
#  data in the memory data segment with the label "chico". Store the resulting sum 
#  in the next memory location beyond the end of array "chico"
####################################################################################
#  Pseudocode description of algorithm:
####################################################################################
#  Cross References:
#  a0: the address of the array
#  a1: count of the numbers
####################################################################################
	.data
array:
	.word	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
			0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
			0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
			0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
			0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
		.space 4
prompt:	.asciiz "\n The sum of the first 100 words of data in the memory data segment with the label \"chico\" is:"
bye:	.asciiz	"\nHave a good time...Bye!"
		.globl main
		
		.text
main:
	li $v0,4
	la $a0,prompt
	syscall # Print the promote
	
	la $a0,array # Initialize address parameter
	li $a1,100 # Initialize the count parameter
	jal Sum
	
	li $v0,1
	syscall # Print the sum of the numbers
	
	li $v0,4
	la $a0,bye
	syscall #Print the bye information
	
	li $v0,10
	syscall # Exit
	
Sum:
	li $v1,0 # Initialize the return value
	
loop:
	blez $a1,return
	addi $a1,$a1,-1
	lw $t0,0($a0)
	addi $a0,$a0,4
	add $v1,$v1,$t0
	b loop
return:
	move $a0,$v1
	jr $ra
