.data
prompt:          .asciz "9x9 Multiplication Table:\n"
newline:         .asciz "\n"
multiply_symbol: .asciz " × "
equal_symbol:    .asciz " = "
space:           .asciz " "

    .text
    .globl main

main:
    # Print the prompt
    li a7, 4                   # syscall: print_string
    la a0, prompt              # Load address of the prompt
    ecall

    li t0, 1                   # t0 = 1 (被乘数)

outer_loop:
    li t1, 1                   # t1 = 1 (乘数，从1开始)

inner_loop:
    mul t2, t0, t1             # t2 = 被乘数 * 乘数

    # Print formatted output
    li a7, 1                   # syscall: print_integer
    mv a0, t0                  # Load the multiplicand
    ecall

    li a7, 4                   # Print " × "
    la a0, multiply_symbol      # Load multiplication symbol
    ecall

    li a7, 1                   # syscall: print_integer
    mv a0, t1                  # Load the multiplier
    ecall

    li a7, 4                   # Print " = "
    la a0, equal_symbol        # Load equal sign
    ecall

    li a7, 1                   # syscall: print_integer
    mv a0, t2                  # Load the product
    ecall

    # Print space after each inner loop (for the same multiplicand)
    li a7, 4                   # syscall: print_string
    la a0, space               # Load space
    ecall

    addi t1, t1, 1             # 乘数加1
    ble t1, t0, inner_loop     # Continue inner loop while 乘数 <= 被乘数

    # Print newline after finishing inner loop
    li a7, 4                   # syscall: print_string
    la a0, newline             # Load newline
    ecall

    addi t0, t0, 1             # 被乘数加1
    li t3, 9                  # Load 10 into t3
    ble t0, t3, outer_loop     # Continue outer loop while 被乘数 <= 9

    # Exit program
    li a7, 10                 # syscall: exit
    ecall