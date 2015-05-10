####################################################################################
#  Program Name: ch2_4.s
#  Programmer: jiangxin
#  Data last modified: 2014-04-26
####################################################################################
#  Functional Description:
#  cout << t3;
#  cin >> t0;
#  a0 = &array;
#  t8 = Mem(a0);
#  Mem(a0+16) = 32768;
#  cout << "Hello World";
####################################################################################
#  Pseudocode description of algorithm:
#  cout << t3;
#  cin >> t0;
#  a0 = &array;
#  t8 = Mem(a0);
#  Mem(a0+16) = 32768;
#  cout << "Hello World";
####################################################################################
#  Cross References:
####################################################################################
	.data
Prompt1:	.asciiz "\nInput the value for t0:"
Prompt2:	.asciiz "\nNow the value of t0 is:"
Prompt3:	.asciiz "\nThe value of t3 is:"
Prompt4:	.asciiz "\nHello World!!"
Bye:	.asciiz	"\n *** JiangXin -Have a good day***"
array:	.word 4096
	.globl main
	.text
main:
################################################
#  cout << t3
################################################
	li $v0,4
	la $a0,Prompt3
	syscall
	
	li $v0,1
	move $a0,$t1
	syscall
################################################
#  cout << t3
################################################

################################################
#  cin >> t0
################################################
	li $v0,4
	la $a0,Prompt2
	syscall
	
	li $v0,1
	move $a0,$t0 # Print t0
	syscall
	
	li $v0,4
	la $a0,Prompt1
	syscall
	
	li $v0,5
	syscall
	move $t0,$v0
	
	li $v0,4
	la $a0,Prompt2
	syscall
	
	li $v0,1
	move $a0,$t0 # Print t0
	syscall
################################################
#  cin >> t0
################################################

################################################
#  a0 = &array;
#  t8 = Mem(a0);
#  Mem(a0+16) = 32768;
################################################
	la $a0,array
	move $t8,$a0
	li $t0,32768
	sw $t0,64($a0)
	
	li $v0,1
	move $a0,$t0
	syscall
################################################
#  a0 = &array;
#  t8 = Mem(a0);
#  Mem(a0+16) = 32768;
################################################

################################################
#  cout << "Hello World";
################################################
	li $v0,4
	la $a0,Prompt4
	syscall
################################################
#  cout << "Hello World";
################################################

end:
	li $v0,4 # system call code for PrintString
	la $a0,Bye # output the Bye
	syscall
	
	li $v0,10 # system call code for Exit
	syscall
