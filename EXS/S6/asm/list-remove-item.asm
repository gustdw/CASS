.globl list_remove_item
.eqv OK 1
.eqv UNINITIALIZED_LIST -1
.eqv OUT_OF_MEMORY -2
.eqv INDEX_OUT_OF_BOUNDS -3
.eqv UNINITIALIZED_RETVAL -4

.text
list_remove_item:
	addi sp, sp, -12
	sw ra, 8(sp)
	sw a0, 4(sp)
	sw a1, (sp)
	
	beqz a0, uninitializedList
	
	jal list_length
	
	lw a1, (sp)
	ble a0, a1, indexOutOfBounds
	bltz a1, indexOutOfBounds
	
	mv t0, a1
	lw a0, 4(sp)
	li t3, 0		#initialiseer t3 op NULL
	lw t2, (a0)		#t2 bezit nu het adres naar de eerste node

	j loop

loop:
	blez t0, endLoop	
	mv t3, t2		#t3 is pointer oldNode naar currNode
	lw t2, 4(t3)		#t2 is pointer currNode naar next Node
	addi t0, t0, -1
	j loop
	
endLoop:
	beqz t3, oldNodeNull
	mv a0, t3
	jal free
	addi a0, a0, 4
	jal free
	lw t2, 4(t2)
	sw t2, 4(t3)		#vorige node aanpassen zodat deze de nieuwe waarde van t3 heeft
	li a0, OK
	j end

oldNodeNull:
	mv t3, t2
	lw t2, 4(t2)
	sw t2, (a0)
	lw a0, (t3)
	jal free
	addi a0, a0, 4
	jal free
	li a0, OK
	j end

uninitializedList:
	li a0, UNINITIALIZED_LIST
	j end

indexOutOfBounds:
	li a0, INDEX_OUT_OF_BOUNDS
	j end
	
uninitializedRetval:
	li a0, UNINITIALIZED_RETVAL
	j end
	
end:
	lw ra, 8(sp)
	addi sp, sp, 12
	ret
