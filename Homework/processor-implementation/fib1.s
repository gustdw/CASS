# assume x3(gp) contains start address of data memory
# assume initial data memory contains following words:
# (in Venus simulator, the .data section below does this
# in the Verilog impl, it is in an initial block in DMem)
# [ 1 ] 
.data
        .word    1
# Program below will store Fibonnacci numbers in memory
.text   
        lw x1, 0(x3)            # x1 = 1 (we do not have addi!)
        add x2, x1, x1          # x2 = 2
        add x4, x2, x2          # x4 = 4 (to have the constant 4)
        add x8,x4,x4            # x8 = 8 (to have the constant 8)
        add x16, x8, x8         # x16 = 16 (to have the constant 16)
        add x31, x16, x16       # 
        add x31, x31, x3        # x31 now points to gp + 32
        add x5, x3, x4          # add 4 to gp (0 in the Verilog impl, 0x100000 in Venus simulator)
        add x6, x1, x0          # x6 = 1
        add x7, x1, x0          # x7 = 1
loop:   add x9, x7, x6          # x9 = x7 + x6  : fib_n = fib_{n-1} + fib_{n-2}
        add x6, x7, x0          # x6 = x7       
        add x7, x9, x0          # x7 = x9
        sw x9, 0(x5)            # store fib_n in memory 
        add x5, x5, x4          # shift pointer 4 up (1 int = 4 bytes)
        beq x31,x5, exit        # are we at the end (gp + 32)?
        beq x0,x0, loop         # unconditional jump
exit:   add x0,x0, x0           # Seeing this instruction causes the processor to stop in Verilog impl

