.data
prompt: .string "Please input an integer: \n"
result_msg: .string "It is an odd number (0: false, 1: true): "
.text
main:
    la a0, prompt           # Load address of prompt into a0
    li a7, 4                # Syscall code 4: print string
    ecall                   # Print the prompt
    li a7, 5                # Syscall code 5: read integer
    ecall                   # Read integer into a0
    li t1, 1                # Load 1 into t1 (to check LSB)
    mv t0, a0               # Copy input to t0
    and t2, t1, t0          # Check if odd (store result in t2: 1 if odd, 0 if even)
    la a0, result_msg       # Load address of result message into a0
    li a7, 4                # Syscall code 4: print string
    ecall                   # Print the result prompt
    mv a0, t2               # Move the odd/even result (0 or 1) to a0
    li a7, 1                # Syscall code 1: print integer
    ecall                   # Print the result (0 or 1)
    li a7, 10               # Syscall code 10: exit
    ecall                   # Exit the program
    