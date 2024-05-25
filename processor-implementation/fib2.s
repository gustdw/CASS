.text   
        addi x31, x3, 32        # x31 now points to gp + 32
        addi x5, x3, 4          # add 4 to gp (0 in the Verilog impl, 0x100000 in Venus simulator)
        addi x6, x0, 1          # x6 = 1
        addi x7, x0, 1          # x7 = 1
loop:   add x9, x7, x6          # x9 = x7 + x6  : fib_n = fib_{n-1} + fib_{n-2}
        add x6, x7, x0          # x6 = x7       
        add x7, x9, x0          # x7 = x9
        sw x9, 0(x5)            # store fib_n in memory 
        addi x5, x5, 4          # shift pointer 4 up (1 int = 4 bytes)
        beq x31,x5, exit        # are we at the end (gp + 32)?
        beq x0,x0, loop         # unconditional jump
exit:   add x0,x0, x0           # Seeing this instruction causes the processor to stop in Verilog impl
