.data
prompt:      .asciz "Please input the number of integers:\n"
array_prompt: .asciz "Please input the array:\n"
empty_msg:   .asciz "No numbers to process.\n"
min_value:   .word 0
min_value_msg: .asciz "The minimum value is: "

    .text
    .globl main

main:
    # Print prompt
    li a7, 4                       # syscall: print_string
    la a0, prompt                  # Load address of prompt
    ecall

    # Read an integer for the number of integers
    li a7, 5                       # syscall: read_int
    ecall
    mv t0, a0                      # t0 is the number of integers

    # Check if t0 is zero
    beq t0, zero, handle_empty

    # Allocate heap for t0 integers
    slli a0, t0, 2                 # New a heap with 4*t0
    li a7, 9                       # syscall: sbrk (allocate memory)
    ecall
    mv t1, a0                      # t1 is the start of the heap
    mv t2, a0                      # t2 is the pointer
    li t3, 0                       # Set t3 as index

    # Prompt for array input
    li a7, 4                       # syscall: print_string
    la a0, array_prompt            # Load address of array input prompt
    ecall

loop_read:                   
    li a7, 5                       # syscall: read_int
    ecall
    # Store input in heap
    sw a0, (t2)                   # Store input in heap
    addi t2, t2, 4                # Move to next integer
    addi t3, t3, 1                # Increment count
    bne t3, t0, loop_read         # If not all read, repeat

    # Initialize the min_value
    lw a0, (t1)                   # Load first value for min_value
    la t4, min_value              # Load address of min_value
    sw a0, (t4)                   # Store initial min_value
    add t3, zero, zero
    add t2, t1, zero              # Reset t2 to start of heap

loop_find_min:
    lw a0, min_value
    lw a1, (t2)                   # Load current value
    jal find_min                  # Find minimum
    la t4, min_value
    sw a0, (t4)                   # Update min_value
    addi t2, t2, 4                # Move to next integer
    addi t3, t3, 1
    bne t3, t0, loop_find_min     # Repeat for all integers

    # Print the min value
    li a7, 4                       # syscall: print_string
    la a0, min_value_msg          # Load address of min value message
    ecall

    li a7, 1                       # syscall: print_int
    la t4, min_value
    lw a0, (t4)                   # Load min_value
    ecall

    j end

handle_empty:
    # Print empty message
    li a7, 4                       # syscall: print_string
    la a0, empty_msg              # Load address of empty message
    ecall

end:
    li a7, 10                      # syscall: exit
    ecall

find_min:
    blt a0, a1, not_update         # If a0 < a1, update min
    mv a0, a1                      # Otherwise, keep a0
not_update:
    jr ra