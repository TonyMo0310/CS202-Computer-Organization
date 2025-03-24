 # Piece 5-10
 .data
 str1:  .ascii "Welcome"
 str2:  .ascii "to"
 str3:  .asciz "RISC-VWorld"
 .text
 la t0, str2
 lh t1, (t0)
 addi t1, t1, -32
 sh t1, (t0)
 la a0, str1
 li a7, 4
 ecall
 li a7, 10
 ecall
 #line 8: Runtime exception at 0x00400008: Load address not aligned on halfword boundary 0x10010007