.eqv OK 1
.eqv UNINITIALIZED_LIST -1
.eqv OUT_OF_MEMORY -2
.eqv INDEX_OUT_OF_BOUNDS -3
.eqv UNINITIALIZED_RETVAL -4

.globl list_length
.text
list_length:	
	beqz a0, uninitializedList

	lw t2, (a0)		#t2 is the pointer to the next element stored at first element
	beqz t2, firstElementIsNull
	
	li a0, 0
	j loop

loop:
	lw t3, 4(t2)		#t3 is address next Node
	beqz t3, nextNodeIsNull
	mv t2, t3
	addi a0, a0, 1
	j loop
	
nextNodeIsNull:
	addi a0, a0, 1
	ret
	
firstElementIsNull:
	li a0, 0
	ret

uninitializedList:
	li a0, UNINITIALIZED_LIST
	ret