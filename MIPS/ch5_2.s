####################################################################################
#  Program Name: SRC-DEST
#  Programmer: jiangxin
#  Data last modified: 2014-04-29
####################################################################################
#  Functional Description:
#  Write a MIPS assembly language program to transfer a block of 100 words starting
#  at memory location SRC to another area of memory beginning at memory location
#  DEST
####################################################################################
#  Pseudocode description of algorithm:
####################################################################################
#  Cross References:
#  $v1:Loop variable
#  $t0:Point the SRC
#  $t1:Point the DEST
#  $t2:temp variable
####################################################################################
	.data
SRC:
	.word	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
			0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
			0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
			0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
			0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
DEST:
	.space	400
Promte_SRC:
	.asciiz	"\nThe data from SRC lists below:"
Promte_DEST:
	.asciiz	"\nThe data from DEST lists below:"
Bye:
	.asciiz	"\nHave a good time!!"
	
	.globl main
	
	.text
main:
	li $v0,4 # Print the Promte_SRC
	la $a0,Promte_SRC
	syscall
	
	li $v1,100 # Initialize loop variable
	la $t0,SRC # Point the pozition of SRC
	
display1:
	blez $v1,return1
	addi $v1,$v1,-1 # Loop variable decrease 1
	
	lw $a0,0($t0)
	li $v0,1 # Print the data by sequence
	syscall
	
	addi $t0,$t0,4
	b display1
	
return1:
	li $v1,100 # Initialize loop variable
	la $t0,SRC
	la $t1,DEST

transfer:
	blez $v1,return2
	addi $v1,$v1,-1 # Loop variable decrease 1
	lw $t2,0($t0)
	sw $t2,0($t1)
	addi $t0,$t0,4 # $t0 points the next word
	addi $t1,$t1,4 # $t1 points the next word
	b transfer
	
return2:
	li $v0,4 #Print Promte_DEST
	la $a0,Promte_DEST
	syscall
	li $v1,100 # Initialize loop variable
	la $t0,DEST # Point the pozition of DEST
	
display2:
	blez $v1,Exit
	addi $v1,$v1,-1 # Loop variable decrease 1
	
	lw $a0,0($t0)
	li $v0,1 # Print the data by sequence
	syscall
	
	addi $t0,$t0,4
	b display2
	
Exit:
	li $v0,4 # Print the Bye
	la $a0,Bye
	syscall
	
	li $v0,10
	syscall
