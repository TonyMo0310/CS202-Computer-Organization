 # Piece 5-12
 .data
 .align 2
 str1:  .ascii "Welcome"
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
 #line 9: Runtime exception at 0x00400008: Load address not aligned to word boundary 0x10010007