 # Piece 5-11
 .data
 str1:  .ascii "Welcome"
 .align 2
 str2:  .ascii "to"
 str3:  .asciz "RISC-VWorld"
 .text
 la t0, str2
 lw t1, (t0)
 addi t1, t1, -32
 sw t1, (t0)
 la a0, str1
 li a7, 4
 ecall
 li a7, 10
 ecall
 #output is 'Welcome'