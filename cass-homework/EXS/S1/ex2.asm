.data
	a: .word 5
	b: .word 3
	c: .space 4

.text
	lw a1, a
	lw a2, b
	
	mul a1, a1, a1
	mul a2, a2, a2
	li a0, 0
	add a0, a1, a2
	