.data
prompt:         .ascii "Enter your 8-digit SID: \0"  # 提示用户输入
welcome:        .ascii "\nWelcome \0"                   # 欢迎信息
to_riscvworld:  .asciz " to RISC-V World\0"           # 结束信息
sid:            .space  9                              # 为 SID 分配空间 (8 位 + null 终止符)

.text
.globl main

main:
    # 1. 提示用户输入 SID
    li a7, 4                      # syscall for print_string
    la a0, prompt                 # load address of prompt
    ecall                         # make syscall

    # 2. 读取 SID
    li a7, 8                      # syscall for read_string
    la a0, sid                    # load address of sid
    li a1, 9                      # max number of bytes to read
    ecall                         # make syscall

    # 3. 打印 "Welcome "
    li a7, 4                      # syscall for print_string
    la a0, welcome                # load address of welcome
    ecall                         # make syscall

    # 4. 打印 SID
    li a7, 4                      # syscall for print_string
    la a0, sid                    # load address of sid
    ecall                         # make syscall

    # 5. 打印 " to RISC-V World"
    li a7, 4                      # syscall for print_string
    la a0, to_riscvworld          # load address of the string
    ecall                         # make syscall

    # 6. 退出程序
    li a7, 10                     # syscall for exit
    ecall                         # make syscall