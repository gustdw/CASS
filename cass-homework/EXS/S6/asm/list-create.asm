.eqv OK 1
.eqv UNINITIALIZED_LIST -1
.eqv OUT_OF_MEMORY -2
.eqv INDEX_OUT_OF_BOUNDS -3
.eqv UNINITIALIZED_RETVAL -4

.text
.globl list_create
list_create:
	addi sp, sp, -4
	sw ra, (sp)
	
	li a0, 1
	jal malloc
	bnez a0, end
	
	li a0, OUT_OF_MEMORY
	
end:
	lw ra, (sp)
	addi sp, sp, 4
	ret