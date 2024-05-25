#include <stdio.h>

struct dataTypes {
	float f;		//4
	double d;		//8
	long l;			//8
	int* p;			//8
	char c;			//1
};

void main(void) {
	struct dataTypes data;
	printf("The size of the struct is %ld\n", sizeof(data));
	printf("The address of the float is %p\n", &data.f);
	printf("The size of the float is %ld\n", sizeof(data.f));
	printf("The address of the double is %p\n", &data.d);
	printf("The size of the double is %ld\n", sizeof(data.d));
	printf("The address of the long is %p\n", &data.l);
	printf("The size of the long is %ld\n", sizeof(data.l));
	printf("The address of the pointer is %p\n", &data.p);
	printf("The size of the pointer is %ld\n", sizeof(data.p));
	printf("The address of the char is %p\n", &data.c);
	printf("The size of the char is %ld\n", sizeof(data.c));
}