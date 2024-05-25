.data
	a: .word 5
	b: .word 4
	operation: .word 1
	
	result: .space 4

.text
main:
	lw a1, a
	lw a2, b
	lw a3, operation
	
	la s0, result
	
	li a0, 0
	
	beqz a3, case0
	li t0, 1
	beq a3, t0, case1
	addi t0, t0, 1
	beq a3, t0, case2
	addi t0, t0, 1
	beq a3, t0, case3
	j notValid

case0:
	add a0, a1, a2
	j end

case1:
	sub a0, a1, a2
	j end

case2:
	addi a0, a1, 5

case3:
	addi a0, a2, 5

notValid:
	li a0, -1

end:
	sw a0, 0(s0)
	
	
