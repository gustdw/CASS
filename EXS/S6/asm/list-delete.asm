.eqv OK 1
.eqv UNINITIALIZED_LIST -1
.eqv OUT_OF_MEMORY -2
.eqv INDEX_OUT_OF_BOUNDS -3
.eqv UNINITIALIZED_RETVAL -4

.text
.globl list_delete
list_delete:
	addi sp, sp, -8
	sw ra, 4(sp)
	sw a0, (sp)
	beqz a0, uninitializedList

	lw t2, (a0)		#t2 is the pointer to the next element stored at first element = *nextNode
	beqz t2, firstElementIsNull
	
	j loop

loop:
	#clear toBeDeletedNode
	mv a0, t2
	jal free
	addi a0, a0, 4
	jal free
	
	lw t3, 4(t2)		#t3 is address next Node
	beqz t3, nextNodeIsNull
	
	mv t2, t3
	j loop
	
nextNodeIsNull:
	lw a0, (sp)
	jal free
	
	li a0, OK
	j end
	
firstElementIsNull:
	jal free
	li a0, OK
	j end

uninitializedList:
	li a0, UNINITIALIZED_LIST
	j end
	
end:
	lw ra, 4(sp)
	addi sp, sp, 8
	ret