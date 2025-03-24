 .include "macro_print_str.asm"
 .data
 arrayx: .space 10 
str: .asciz "\nThearrayxis:  "
 .text
 main:
 print_string("Please input 10 integers: \n")
 add t0, zero, zero
 addi t1, zero, 10
 la t2, arrayx