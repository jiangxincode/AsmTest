####################################################################################
#  Program Name: Sum of Integers
#  Programmer: jiangxin
#  Data last modified: 2014-04-24
####################################################################################
#  Functional Description:
#  A Program to find the sum of the integers from 1 to N,where N is a value
#  read in from the keyboard.
####################################################################################
#  Pseudocode description of algorithm:
#  main:	cout << "\n Please input a value for N = "
#  		cin >> v0
#		if (v0 > 0)
#  ............................................
####################################################################################
#  Cross References:
#  v0: N
#  t0: Sum
####################################################################################
	.data
Promote:.asciiz	"\n Please Inout a value for N= "
Result:	.asciiz	"The Sum of integers from 1 to N is"
Bye:	.asciiz	"\n *** Adios Amigo -Have a good day***"
	.globl main
	.text
main:
	li
