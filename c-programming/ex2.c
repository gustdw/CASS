/// NOTE: this is an implementation of exercises 1 and 2 using only a small set of C features
#include <stdlib.h>
#include "simple_bitmaps.h"

int main(int argc, char const *argv[])
{
    short* im1 = (short *) malloc( 16 * sizeof(short));
    *(im1 +  0) = 0b0000000110000000;
    *(im1 +  1) = 0b0000000110000000;
    *(im1 +  2) = 0b0000000110000000;
    *(im1 +  3) = 0b0000000110000000;
    *(im1 +  4) = 0b0000000110000000;
    *(im1 +  5) = 0b0000000110000000;
    *(im1 +  6) = 0b0000000110000000;
    *(im1 +  7) = 0b1111111111111111;
    *(im1 +  8) = 0b1111111111111111;
    *(im1 +  9) = 0b0000000110000000;
    *(im1 + 10) = 0b0000000110000000;
    *(im1 + 11) = 0b0000000110000000;
    *(im1 + 12) = 0b0000000110000000;
    *(im1 + 13) = 0b0000000110000000;
    *(im1 + 14) = 0b0000000110000000;
    *(im1 + 15) = 0b0000000110000000;

    short* im2 = (short *) malloc( 16 * sizeof(short));
    *(im2 +  0) = 0b0000000000000011;
    *(im2 +  1) = 0b0000000000000110;
    *(im2 +  2) = 0b0000000000001100;
    *(im2 +  3) = 0b0000000000011000;
    *(im2 +  4) = 0b0000000000110000;
    *(im2 +  5) = 0b0000000001100000;
    *(im2 +  6) = 0b0000000011000000;
    *(im2 +  7) = 0b0000000110000000;
    *(im2 +  8) = 0b0000001100000000;
    *(im2 +  9) = 0b0000011000000000;
    *(im2 + 10) = 0b0000110000000000;
    *(im2 + 11) = 0b0001100000000000;
    *(im2 + 12) = 0b0011000000000000;
    *(im2 + 13) = 0b0110000000000000;
    *(im2 + 14) = 0b1100000000000000;
    *(im2 + 15) = 0b1000000000000000;

    or_image_with(im1, im2);
    print_binary_bitmap(im1);
    invert_image(im1);
    print_binary_bitmap(im1);
}
