.data
prompt:      .asciz "Enter an integer m: "
result_msg:  .asciz "The mth Fibonacci number is: "
newline:     .asciz "\n"

    .text
    .globl main

main:
    # 打印提示信息
    li a7, 4                       # syscall: print_string
    la a0, prompt                  # 加载提示信息地址
    ecall

    # 读取输入整数
    li a7, 5                       # syscall: read_int
    ecall                           # 读取整数，结果在 a0 中

    # 计算 Fibonacci 数
    li t0, 1                       # F(0) = 1
    li t1, 1                       # F(1) = 1

    # 检查 m 的值
    beq a0, zero, return_one       # 如果 m == 0，返回 1
    beq a0, t1, return_one         # 如果 m == 1，返回 1

    # 计算 Fibonacci
    li t2, 2                       # 从第 2 项开始
compute_fib:
    bge t2, a0, print_result       # 如果 t2 >= m，跳转到打印结果
    add t3, t0, t1                 # F(n) = F(n-1) + F(n-2)
    mv t0, t1                      # F(n-1) = F(n)
    mv t1, t3                      # F(n) = F(n)
    addi t2, t2, 1                 # t2++
    j compute_fib                  # 继续循环

return_one:
    mv a0, t0                      # 返回结果 1
    j print_result

print_result:
    # 输出结果
    li a7, 4                       # syscall: print_string
    la a0, result_msg              # 加载结果提示信息地址
    ecall

    li a7, 1                       # syscall: print_int
    mv a0, t1                      # 最终结果在 t1 中
    ecall                           # 打印结果

    # 输出换行
    li a7, 4                       # syscall: print_string
    la a0, newline                 # 加载换行符地址
    ecall

    # 退出程序
    li a7, 10                      # syscall: exit
    ecall