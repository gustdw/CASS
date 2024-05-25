.data
	start: .string "LinkedList = {"
	middle: .string " ,"
	end: .string "}\n"

.text
.globl list_print
	
list_print:
	beqz a0, uninitializedList

	lw t2, (a0)		#t2 is the pointer to the next element stored at first element
	li a7, 4
	la a0, start
	ecall
	j loop

loop:
	lw t2, 4(t2)		#t2 is address next Node
	beqz t2, nextNodeIsNull
	li a7, 56
	la a0, middle
	lw a1, (t2)
	ecall
	j loop
	
nextNodeIsNull:
	li a7, 56
	la a0, end
	lw a1, (t2)
	ecall
	ret

uninitializedList:
	li a0, -1
	ret
