.eqv OK 1
.eqv UNINITIALIZED_LIST -1
.eqv OUT_OF_MEMORY -2
.eqv INDEX_OUT_OF_BOUNDS -3
.eqv UNINITIALIZED_RETVAL -4

.text
.globl list_get
list_get:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw a0, 8(sp)
	sw a1, 4(sp)
	sw a2, (sp)
	
	beqz a0, uninitializedList
	
	jal list_length
	
	lw a1, 4(sp)
	ble a0, a1, indexOutOfBounds
	bltz a1, indexOutOfBounds
	lw a2, (sp)
	beqz a2, uninitializedRetval
	
	mv t0, a1
	lw a0, 8(sp)
	lw t2, (a0)		#t2 bezit nu het adres naar het eerste node
	
	j loop

loop:
	blez t0, endLoop	
	lw t2, 4(t2)		#t2 is address next Node
	addi t0, t0, -1
	j loop
	
endLoop:
	lw t1, (t2)		#value van node waar t2 naar wijst
	sw t1, (a2)
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
	lw ra, 12(sp)
	addi sp, sp, 16
	ret
