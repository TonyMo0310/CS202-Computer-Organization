 # Piece 5-13
 .data
 str1:  .ascii "Welcome"
 str2:  .ascii "to"
 str3:  .asciz "RISC-VWorld"
 .text
 la t0, str2
 lb t1, (t0)
 addi t1, t1, -32
 sb t1, (t0)
 la a0, str1
 li a7, 4
 ecall
 li a7, 10
 ecall
 #output is 'WelcomeToRISC-VWorld'