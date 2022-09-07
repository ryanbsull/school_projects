############################################################################
#                       Lab 3
#                       EC413
#
#    		Assembly Language Lab -- Programming with Loops.
#
############################################################################
#  DATA
############################################################################
        .data           # Data segment
Hello:  .asciiz " \n Hello World! \n "  # declare a zero terminated string
Hello_len: .word 16
AnInt:	.word	12		# a word initialized to 12
space:	.asciiz	" "	# declare a zero terminate string
WordAvg:   .word 0		#use this variable for part 4
ValidInt:  .word 0		#
ValidInt2: .word 0		#
lf:     .byte	10, 0	# string with carriage return and line feed
InLenW:	.word   4       # initialize to number of words in input1 and input2
InLenB:	.word   16      # initialize to number of bytes in input1 and input2
        .align  4
Input1:	.word	0x01020304,0x05060708
	    .word	0x090A0B0C,0x0D0E0F10
        .align  4
Input2: .word   0x01221117,0x090b1d1f   # input
        .word   0x0e1c2a08,0x06040210
        .align  4
Copy:  	.space  0x80    # space to copy input word by word
        .align  4
 
Enter: .asciiz "\n"
Comma: .asciiz ","
############################################################################
#  CODE
############################################################################
        .text                   # code segment
#
# print out greeting
#
main:
        la	$a0,Hello	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string

	
#Code for Item 2
#Count number of occurences of letter "l" in Hello string
        lw      $s0,InLenW      # stored for later use
        lw      $s1,InLenB      # stored for later use
        la      $t0,Hello       # address of string
        li      $t1,0           # counts number of "l" occurences in string
        lw      $t3,Hello_len   # stores the length of the string
        li      $t4,0           # counter variable
loop1:
        lb      $t2,0($t0)      # loads the letter of the string at memory location $t0
        beq     $t4,$t3,exit1   # checks if the end of the string has been reached
        bne     $t2,0x6C,noL    # checks if the byte is equal to 0x6C = 'l'
        addi    $t1,$t1,1       # increments the L count variable $t1
noL:
        addi    $t0,$t0,1       # increment to next byte of char array
        addi    $t4,$t4,1       # increments counter variable
        j       loop1
exit1:
        add     $a0,$zero,$t1   # loads number into argument register
        li      $v0,1           # system call code for print_int
        syscall                 # print the number
################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
################################################################################

#
# Code for Item 3 -- 
# Print the integer value of numbers from 0 and less than AnInt
#
        li      $t0,0           # initializes counter $t0 to 0
        lw      $t1,AnInt       # loads integer AnInt into $t1
loop2:
        add     $a0,$zero,$t0   # loads number into argument register
        li      $v0,1           # system call code for print_int
        syscall                 # print the integer
        la      $a0,space       # address of string to print
        li      $v0,4           # system call code for print_str
        syscall                 # print " "
        beq     $t0,$t1,exit2   # if counter == AnInt then exit the loop
        addi    $t0,$t0,1       # increments counter
        j       loop2
exit2:
###################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
###################################################################################
#
# Code for Item 4 -- 
# Print the integer values of each byte in the array Input1 (with spaces)
#
        la      $t0,Input1      # loads the initial address of Input1[]
        li      $t1,0           # counter to check as cycling through array
loop3:
        lb      $t2,0($t0)      # loads byte at address stored in $t0 to $t2
        add     $a0,$zero,$t2   # loads integer value of $t2 into argument register
        li      $v0,1           # system call code for print_int
        syscall                 # print the int
        la      $a0,space       # loads " " into argument register
        li      $v0,4           # system call code for print_str
        syscall                 # print the string
        addi    $t0,$t0,1       # increments to the next byte of array Input1[i] -> Input1[i+1]
        addi    $t1,$t1,1       # increments counter
        beq     $t1,$s1,exit3   # checks if counter == InLenB and exits if true
        j       loop3
exit3:
###################################################################################
#
# Code for Item 5 -- 
# Write code to copy the contents of Input2 to Copy
#
        la      $t0,Input2      # loads address of Input2[0]
        la      $t1,Copy        # loads address of Copy[0]
        li      $t2,0           # initializes counter
loop4:
        lw      $t3,0($t0)      # loads value of Input2[i]
        sw      $t3,0($t1)      # copies value of Input2[i] to Copy[i]
        addi    $t0,$t0,4       # increments to next element of Input2
        addi    $t1,$t1,4       # increments to next element of Copy
        addi    $t2,$t2,1       # increments counter
        beq     $t2,$s0,exit4   # checks if counter == InLenW and exits if true
        j       loop4
exit4:
#################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
###################################################################################
#
# Code for Item 6 -- 
# Print the integer average of the contents of array Input2
#
        la      $t0,Input2      # loads address of Input2[0]
        lw      $t1,0($t0)      # initializes min value to Input2[0]
        lw      $t2,0($t0)      # initializes max value to Input2[0]
        li      $t3,0           # initializes sum value to 0
        li      $t5,0           # initializes counter to 0
loop5:
        lw      $t4, 0($t0)     # loads value of Input2[i]
        add     $t3,$t3,$t4     # sum = sum + Input2[i]
        addi    $t0,$t0,4       # Input2[i] -> Input2[i+1]
        bge     $t1,$t4,notMin  # checks if Input2[i] >= min, if not then min = Input2[i]
        add     $t1,$zero,$t4   # min = Input2[i]
notMin:
        ble     $t2,$t4,notMax  # checks if Input2[i] <= max, if not then max = Input2[i]
        add     $t2,$zero,$t4   # max = Input2[i]
notMax:
        addi    $t5,$t5,1       # increment counter
        beq     $t5,$s0,exit5   # if counter == InLenW then exit the loop
        j       loop5
exit5:
        div     $t3,$t5         # sum/counter
        mflo    $t6             # moves the quotient to register $t6
        add     $a0,$zero,$t1   # loads min into argument register
        li      $v0,1           # system call code for print_int
        syscall                 # print min
        la      $a0,space       # loads " " into argument register
        li      $v0,4           # system call code for print_str
        syscall                 # print the string
        add     $a0,$zero,$t2   # loads max into argument register
        li      $v0,1           # system call code for print_int
        syscall                 # print max
        la      $a0,space       # loads " " into argument register
        li      $v0,4           # system call code for print_str
        syscall                 # print the string
        add     $a0,$zero,$t6   # loads integer average of Input2[] into argument register
        li      $v0,1           # system call code for print_int
        syscall                 # print average
#################################################################################
        la	$a0,Enter	# address of string to print
        li	$v0,4		# system call code for print_str
        syscall                 # print the string
##################################################################################
#
# Code for Item 7 -- 
# Display the first 25 integers that are divisible by either 7 and 13 (with comma)
#
        li      $t0,0           # number that increases by 7
        li      $t1,0           # number that increases by 13
        li      $t2,0           # initializes counter
        li      $t3,25          # counter max
loop6:
        bne     $t0,$t1,pOne    # checks if both numbers are not equal and if not then will check which to print first
        add     $a0,$zero,$t0   # loads number1 into argument register
        li      $v0,1           # system call code for print_str
        syscall                 # print number
        la      $a0,Comma       # loads address of ","
        li      $v0,4           # system call code for print_str
        syscall                 # print ","
        addi    $t0,$t0,7       # increments number 1 by 7
        addi    $t1,$t1,13      # increments number 2 by 13
        addi    $t2,$t2,1       # increments counter
        beq     $t2,$t3,exit6   # if counter == counter_max then exit loop
        j       loop6
pOne:
        bgt     $t0,$t1,pTwo    # if number 1 > number 2 then print number 2
        add     $a0,$zero,$t0   # loads number1 into argument register
        li      $v0,1           # system call code for print_str
        syscall                 # print number
        la      $a0,Comma       # loads address of ","
        li      $v0,4           # system call code for print_str
        syscall                 # print ","
        addi    $t0,$t0,7       # increments number 1 by 7
        addi    $t2,$t2,1       # increments counter
        beq     $t2,$t3,exit6   # if counter == counter_max then exit loop
        j       loop6
pTwo:
        add     $a0,$zero,$t1   # loads number2 into argument register
        li      $v0,1           # system call code for print_str
        syscall                 # print number
        la      $a0,Comma       # loads address of ","
        li      $v0,4           # system call code for print_str
        syscall                 # print ","
        addi    $t1,$t1,13      # increments number 1 by 7
        addi    $t2,$t2,1       # increments counter
        beq     $t2,$t3,exit6   # if counter == counter_max then exit loop
        j       loop6
exit6:
        la      $a0,Enter
        li      $v0,4
        syscall
#
# Code for Item 8 -- 
# Repeat step 7 but display the integers in 5 lines with 5 integers with spaces per line
# This must be implemented using a nested loop.
#
        li      $t0,0           # number that increases by 7
        li      $t1,0           # number that increases by 13
        li      $t2,0           # initializes counter
        li      $t3,25          # counter max
        li      $t4,0           # counts every 5 and then resets to 0
loop7:
        bne     $t4,5,noEnter   # if the loop has printed 5 numbers then print Enter otherwise skip
        add     $t4,$zero,$zero # reset 5 counter
        la      $a0,Enter       # loads address of "\n"
        li      $v0,4           # system call code for print_str
        syscall                 # print "\n"
noEnter:
        bne     $t0,$t1,pOne1    # checks if both numbers are not equal and if not then will check which to print first
        add     $a0,$zero,$t0   # loads number1 into argument register
        li      $v0,1           # system call code for print_str
        syscall                 # print number
        la      $a0,Comma       # loads address of ","
        li      $v0,4           # system call code for print_str
        syscall                 # print ","
        addi    $t0,$t0,7       # increments number 1 by 7
        addi    $t1,$t1,13      # increments number 2 by 13
        addi    $t2,$t2,1       # increments counter
        addi    $t4,$t4,1       # increment 5 counter
        beq     $t2,$t3,exit7   # if counter == counter_max then exit loop
        j       loop7
pOne1:
        bgt     $t0,$t1,pTwo1    # if number 1 > number 2 then print number 2
        add     $a0,$zero,$t0   # loads number1 into argument register
        li      $v0,1           # system call code for print_str
        syscall                 # print number
        la      $a0,Comma       # loads address of ","
        li      $v0,4           # system call code for print_str
        syscall                 # print ","
        addi    $t0,$t0,7       # increments number 1 by 7
        addi    $t2,$t2,1       # increments counter
        addi    $t4,$t4,1       # increment 5 counter
        beq     $t2,$t3,exit7   # if counter == counter_max then exit loop
        j       loop7
pTwo1:
        add     $a0,$zero,$t1   # loads number2 into argument register
        li      $v0,1           # system call code for print_str
        syscall                 # print number
        la      $a0,Comma       # loads address of ","
        li      $v0,4           # system call code for print_str
        syscall                 # print ","
        addi    $t1,$t1,13      # increments number 1 by 7
        addi    $t2,$t2,1       # increments counter
        addi    $t4,$t4,1       # increment 5 counter
        beq     $t2,$t3,exit7   # if counter == counter_max then exit loop
        j       loop7
exit7:

Exit:
	jr $ra
