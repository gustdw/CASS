#include <stdio.h>
#include <stdlib.h>

#define WIDTH 80
#define HEIGHT 80

// We will now represent an image as a pointer to WIDTH * HEIGHT unsigned chars
// For the moment, these unsigned chars (1 byte) are either 0x00 or 0xFF

void print_binary_bitmap(unsigned char* im)
{
    // TODO: implement this function for exercise 3
}

void invert_image(unsigned char* im)
{
    // TODO: implement this function for exercise 3
}

int main(int argc, char const *argv[])
{
    unsigned char* im1 = (unsigned char *) malloc(WIDTH * HEIGHT);

    // This creates an image of a disk with radius 30, by making all pixels
    // with distance from the point (WIDTH/2, HEIGHT/2) smaller than 30 white
    // and all other pixels black
    int radius = 30;
    int i = 0;
    int j = 0;
    int square_of_distance;

    while (i < HEIGHT) {
        j = 0;
        while (j < WIDTH) {
            square_of_distance = (i - HEIGHT/2) * (i - HEIGHT/2) + (j - WIDTH/2) * (j - WIDTH/2);
            if (square_of_distance < radius * radius)
                *(im1 + i * WIDTH + j) = 0xFF;
            else
                *(im1 + i * WIDTH + j) = 0x00;
            j = j + 1;
        };
        i = i +1;
    }
    // print the disk
    print_binary_bitmap(im1);

    // invert it and print again
    invert_image(im1);
    print_binary_bitmap(im1);
}
