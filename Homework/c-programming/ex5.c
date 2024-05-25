#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "readfile.h"

// chars is a string containing characters of increasing "density"
// these will be used to represent different levels of gray
// Two alternative strings are given below, you can choose which one to use.

// char *chars = " .:-=oO0@";      // Alternative for white on black terminals
char *chars = "@0Oo=-:. ";      // Alternative for black on white terminals

// An image = represented as a long* with
// *(long + 0) = width
// *(long + 1) = height
// *(long + 2) = unsigned char pointer to the multi-dimensional array of pixels.
//               This array is represented in "row major order" (https://en.wikipedia.org/wiki/Row-_and_column-major_order)

void print_grayscale_image(long *im)
{
    // TODO: implement this function for exercise 5
}

void read_bmp(long *img, char *filename)
{
    // TODO: implement this function for exercise 6
    // readfile will make the contents of the file with name filename 
    // available in memory, and will return the memory address at which
    // the file contents is loaded.
    // This function is implemented in readfile.h, and you do not need
    // to understand how it is implemented. (This will be covered in
    // the course Operating Systems)
    char* filedata = (char *)readfile(filename);
}

// The parameters with which main is called provide information of parameters
// given to the program at startup.
// See for instance: https://www.tutorialspoint.com/cprogramming/c_command_line_arguments.htm

int main(int argc, char **argv)
{
    long* im1 = (long *) malloc(3*8);

    if (argc <= 1)
    {
        // No argument provided, we just create an image with a diagonal gradient in grayscale
        *(im1 + 0) = 80;
        *(im1 + 1) = 80;
        unsigned char* data = (unsigned char *)malloc(80 * 80);
        *(im1 + 2) = (long) data;
        
        int i = 0;
        int j = 0;

        while (i < 80 ){
            j = 0;
            while (j < 80) {
                *(data + 80*i + j) = 255 * (i + j) / (2 * 80 - 2);
                j = j + 1;
            };
            i = i + 1;
        }
    }
    else
    {
        // Argument provided that we interpret as a filename of a .bmp file to render
        read_bmp(im1, *(argv + 1));
    }
    print_grayscale_image(im1);
}
