#include <stdio.h>

int main(void) {
	int n;
    printf("Please enter an integer!\n");
	scanf("%d", &n);
	
	int n_squared = n*n;
	printf("The squared value of %d is %d.\n", n, n_squared);
    return 0;
}
