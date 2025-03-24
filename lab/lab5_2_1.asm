.data
dvalue1:    .word 0x1   # -2^31 = -2147483648
dvalue2:    .word 0x1           # 1
no_overflow_msg:    .asciz "\nNo overflow occurred."
overflow_msg:       .asciz "\nOne overflow occurred."

.text
    lw t1, dvalue1          # t1 = -2147483648
    lw t2, dvalue2          # t2 = 1
    sub t0, t1, t2          # t0 = t1 - t2 = -2147483648 - 1
    
    # Overflow checking
    slti t3, t2, 0          # t3 = 1 if t2 < 0 (0 here)
    slti t4, t1, 0          # t4 = 1 if t1 < 0 (1 here)
    slti t5, t0, 0          # t5 = 1 if t0 < 0 (0 here)
    
    # Case 1: t1 < 0 && t2 >= 0 && t0 >= 0
    xori t3, t3, 1          # t3 = 1 if t2 >= 0 (reuse t3)
    and t6, t4, t3          # t6 = (t1 < 0) && (t2 >= 0)
    xori t5, t5, 1          # t5 = 1 if t0 >= 0 (reuse t5)
    and t6, t6, t5          # t6 = 1 if Case 1 overflow
    
    # Case 2: t1 >= 0 && t2 < 0 && t0 < 0
    xori t4, t4, 1          # t4 = 1 if t1 >= 0 (reuse t4)
    slti t3, t2, 0          # t3 = 1 if t2 < 0 (recompute)
    and t5, t4, t3          # t5 = (t1 >= 0) && (t2 < 0)
    slt t4, t0, zero        # t4 = 1 if t0 < 0 (reuse t4)
    and t5, t5, t4          # t5 = 1 if Case 2 overflow
    
    # Combine results
    or t6, t6, t5           # t6 = 1 if any overflow occurs
    
    # Print result
    mv a0, t0               # Move result to a0
    li a7, 1                # Print integer
    ecall
    
    # Check overflow
    bnez t6, overflow
    
    la a0, no_overflow_msg
    li a7, 4
    ecall
    j exit
    
overflow:
    la a0, overflow_msg
    li a7, 4
    ecall
    
exit:
    li a7, 10
    ecall