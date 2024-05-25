#include <stdio.h>
#include <stdlib.h>

// Now we represent an image as a long pointer pointing to three longs:
//  - a long representing the width
//  - a long representing the height
//  - an unsigned char pointer to (width x height) bytes representing grayscales

void print_binary_bitmap(long* im)
{
    // TODO: implement this function for exercise 4
}

void invert_image(long* im)
{
    // TODO: implement this function for exercise 4
}

int main(int argc, char const *argv[])
{
    // This creates an image of a disk with radius 30, by making all pixels
    // with distance from the point (WIDTH/2, HEIGHT/2) smaller than 30 white
    // and all other pixels black

    long* im1 = (long *) malloc(3 * sizeof(long));
    int radius = 30;
    *im1 = 80;       //width
    *(im1 + 1) = 80; //height
    unsigned char* data =(unsigned char *) malloc(80 * 80);
    *(im1 + 2) = (long) data;

    int i = 0;
    int j = 0;
    int square_of_distance;

    while (i < 80) {
        j = 0;
        while (j < 80) {
            square_of_distance = (i - 40) * (i - 40) + (j - 40) * (j - 40);
            if (square_of_distance < radius * radius)
                *(data + i * 80 + j) = 0xFF;
            else
                *(data + i * 80 + j) = 0x00;
            j = j + 1;
        };
        i = i +1;
    }

    print_binary_bitmap(im1);
    invert_image(im1);
    print_binary_bitmap(im1);
}
