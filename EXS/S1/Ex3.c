#include <stdio.h>

int main(void) {
	int n;
    printf("Please enter an integer:\n");
	scanf("%d", &n);
	
	printf("The address of this integer is: %p\n", &n);
	printf("The value of this integer is: %d\n", n);
	printf("The size of this integer is: %ld\n", sizeof(n));
	
	int* pointer = &n;
	
	printf("The address of this pointer is: %p\n", &pointer);
	printf("The value of this pointer is: %d\n", *pointer);
	printf("The size of this pointer is: %ld\n", sizeof(pointer));
    return 0;
}
