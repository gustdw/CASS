 #include <stdio.h>

int fac(int n) {
	if (n == 0) {
		return 1;
	}
	else {
		return n * fac(n-1);
	}
}
 
 void main(void) {
	for (int i=1; i<=10; i++) {
		printf("The factorial of %d is %d\n", i, fac(i));
	}
 }
 
