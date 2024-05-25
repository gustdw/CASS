.eqv OK 1
.eqv UNINITIALIZED_LIST -1
.eqv OUT_OF_MEMORY -2
.eqv INDEX_OUT_OF_BOUNDS -3
.eqv UNINITIALIZED_RETVAL -4

.text
.globl list_insert
list_insert:
	addi sp, sp, -20
	sw a2, 16(sp)
	sw ra, 12(sp)
	sw a0, 8(sp)
	sw a1, 4(sp)
	
	beqz a0, uninitializedList

	#CHECK OUT OF BOUNDS
	bltz a1, indexOutOfBounds
	jal list_length
	ebreak
	blt a0, a1, indexOutOfBounds
	
	lw a0, 8(sp)
	lw t2, (a0)		#t2 is the pointer to the next element stored at first element = *currNode
	addi sp, sp, -4
	sw t2, (sp)
	
	#ALLOCATE SPACE FOR NEW NODE
	li a0, 2
	jal malloc
	
	lw t2, (sp)
	addi sp, sp 4
	
	beqz a0, outOfMemory
	
	sw a0, (sp)		#Store address of newly allocated space
	
	#if (index == 0)
	lw a1, 4(sp)
	beqz a1, indexIsZero
	
	j loop

loop:
	beqz a1, loopEnd
	
	mv t3, t2		#oldNode = currNode;
	lw t2, 4(t2)		#currNode = currNode->next
	
	#UPDATE COUNTER
	addi a1, a1, -1
	j loop
	
loopEnd:
	#newNode->nex = currNode
	sw t2, 4(a0)

	#newNode->value = value
	lw a2, 16(sp)
	sw a2, (a0)

	#oldNode->next = newNode
	sw a0, 4(t3)
	
	li a0, OK
	j end

indexIsZero:
	#LOAD VALUE AND NEXTPOINTER INTO NODE
	lw a0, 0(sp)		#a0 is address of allocated space
	mv t0, a0		#t0 is address of newly allocated space
	
	lw a2, 16(sp)
	sw a2, (t0)
	
	lw a0, 8(sp)		#a0 is pointer to where first is stored
	lw t2, (a0)		#t2 is pointer from where first is stored to the first node
	sw t2, 4(t0)
	
	#LOAD POINTER TO NEW NODE IN FIRST
	sw t0, (a0)
	
	li a0, OK
	j end

uninitializedList:
	li a0, UNINITIALIZED_LIST
	j end
	
indexOutOfBounds:
	li a0, INDEX_OUT_OF_BOUNDS
	j end
	
outOfMemory:
	li a0, OUT_OF_MEMORY
	j end
	
end:
	lw ra, 12(sp)
	addi sp, sp, 20
	ret
