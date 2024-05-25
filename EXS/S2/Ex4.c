 #include <stdio.h>
 
 void printList(int listSize, int array[listSize]) {
	 for (int i=0; i<listSize; i++) {
		printf("Element %d = %d, address = %p. ", i, array[i], &(array[i]));
	 }
	 printf("\n");
 };
 
 void main(void) {
	 int array[5] = {1, 2, 3, 4, 5};
	 
	 int n;
	 printf("Please enter the number you want to multiply the elemnts with: \n");
	 scanf("%d", &n);
	 
	 for (int i=0; i<5; i++) {
		 array[i] = n*array[i];
	 }
	 printList(5, array);
 };
 
 
 