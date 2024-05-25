# Homework assignment: C programming practice

The objective of this homework is to build up some practical experience with C
programming. All exercises can be solved using only the simple C subset for
which we discussed compilation in class (i.e., just using the basic integer
types, pointers, assignment, functions, while-loops, if-then-else, malloc() and
free()). (We recommend to stick to this subset, but if you want to use other
more advanced features of C, you are welcome to do so.)

You will develop a collection of programs that can manipulate grayscale images
and display them on a simple terminal using a technique known as
[ASCII art](https://en.wikipedia.org/wiki/ASCII_art).

To see an example image rendered with the final program of this homework:

- If you use a browser / terminal in _light mode_ (black characters on white
  blackground), look [here](turing-inv.txt)
- If you use a browser / terminal in _dark mode_ (white characters on a black
  background), look [here](turing.txt)

(Zoom out your browser / editor / terminal sufficiently to see the full
picture.)

We will build up gradually towards that final rendering program, using a series
of exercises that become gradually harder.

## Preparation

If you are not familiar with C, first read the
[C programming appendix](https://pages.hmc.edu/harris/ddca/ddcarv/DDCArv_AppC_Harris.pdf)
from Digital Design and Computer Architecture, RISC-V Edition, Harris and
Harris.

Also, make sure you have attended or watched the lecture on the simple subset of
C for which we discussed how to compile it to RISC-V.

## Exercise 1: Display a simple black-and-white bitmap

Study the code in `ex1.c`, `simple_bitmaps.c` and `simple_bitmaps.h`. It
represents a simple 16x16 binary image as a 16-element array of 16-bit integers.
Implement the `print_binary_bitmap()` function such that it prints the bitmap
provided as argument to the function on standard output. You should print a
black dot in the picture as a space (' ') and a white dot as '@'. For instance,
the call `print_binary_bitmap(im1)` in the main function should output:

```
       @@
       @@
       @@
       @@
       @@
       @@
       @@
@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@
       @@
       @@
       @@
       @@
       @@
       @@
       @@
```

Your task is to implement `print_binary_bitmap()` in the file
`simple_bitmaps.c`, and to test that it works correctly with the images
constructed in the `main()` method in file `ex1.c`.

Remember that you can compile the program by typing:

```
cc ex1.c simple_bitmaps.c -o ex1
```

After successful compilation, you can run the program by typing:

```
./ex1
```

Hints:

- The C library function `putchar(c)`, declared in`stdio.h`, prints character
  `c` on the console. Writing `putchar('\n');` prints a new line.

## Exercise 2: Implement some operations on images

Look at the code in `ex2.c`. It uses the same representation of 16x16
black-and-white images, but now, it uses two new fuctions:

- `or_image_with(im1,im2)`: updates `im1` to a new bitmap where each pixel is
  the logical or of the corrsponding pixel in the original `im1` with the
  corresponding pixel in `im2`.
- `invert_image(im)`: updates `im`, turning every white pixel in a black one and
  vice-versa, i.e., performing a logical not operation on every pixel.

If you correctly implement both functions, the `main()` function in `ex2.c`
should print out:

```
@@     @@
 @@    @@
  @@   @@
   @@  @@
    @@ @@
     @@@@
      @@@
@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@
       @@@@
       @@ @@
       @@  @@
       @@   @@
       @@    @@
       @@     @@
       @@      @
  @@@@@  @@@@@@@
@  @@@@  @@@@@@@
@@  @@@  @@@@@@@
@@@  @@  @@@@@@@
@@@@  @  @@@@@@@
@@@@@    @@@@@@@
@@@@@@   @@@@@@@


@@@@@@@    @@@@@
@@@@@@@  @  @@@@
@@@@@@@  @@  @@@
@@@@@@@  @@@  @@
@@@@@@@  @@@@  @
@@@@@@@  @@@@@
@@@@@@@  @@@@@@
```

Again, you can compile the program by typing:

```
cc ex2.c simple_bitmaps.c -o ex2
```

After successful compilation, you can run the program by typing:

```
./ex2
```

## Exercise 3: Generalize to arbitrary compile-time specified dimensions

Next, we will generalize the bitmaps in two ways:

- we want to work with bitmaps of arbitrary width and height, but for the moment
  we limit ourselves to _compile-time_ constants for width and height.
- rather than representing a pixel as a single _bit_, we use a _byte_, so we can
  represent images with 256 different levels of gray, rather than just black and
  white. (For this exercise, we will still only use images with black and white,
  so we only use bytes `0x00` and `0xFF`, but the generalization is useful for
  later exercises in this homework.)

Study the code provided in `ex3.c`. Make sure you understand the representation
of images, and the code in the `main()` function that creates an image of a
disk.

Now, it is your task to implement the `print_binary_bitmap()` and
`invert_image()` functions in the file `ex3.c`. If you do so correctly, running
`ex3` will print a disk, followed by an inverted disk.

To compile the program:

```
cc ex3.c -o ex3
```

## Exercise 4: Generalize to arbitrary dimensions

Next, we develop a representation of images that also includes the dimensions of
the image.

Study the code in `ex4.c`. Again, make sure you understand the representation of
images, and the code in the `main()` function that creates an image of a disk.

**NOTE**: In this exercise and the following ones, we assume that a `long` and a
pointer have the same size and that casting back and forth between a pointer
type and the `long` type is well-defined. This is not considered good C
programming practice, as it is not portable: it is not guaranteed that on all
computer platforms the size of a long integer and a pointer are the same. C
provides other features (like
[exact-width integer types](https://en.wikibooks.org/wiki/C_Programming/stdint.h)
) to do this in a more portable way, but introducing these features would lead
us too far.

It is again your task to implement the `print_binary_bitmap()` and
`invert_image()` functions (you can reuse much of the code from the previous
exercise!). If you implement both functions correctly, running `ex4` will print
a disk, followed by an inverted disk on standard out.

## Exercise 5: Generalize display to use multiple gray levels

Now, we can start working with different levels of gray. One way to render
images with different levels of gray on a standard terminal is to use characters
of different "density" to display pixels of different levels of gray. For
instance `' '` could be black, `'@'` could be white, and `'O'` could be a shade
of gray. (This assumes a terminal with white text on a black background). More
characters can be used to represent more levels of gray. For instance, the
string `" .:-=oO0@"` contains 9 characters of increasing density to represent 9
levels of gray.

We can then print a grayscale image by choosing an appropriate character to
represent each pixel. Expanding on this idea, implement the
`print_grayscale_image()` in file `ex5.c`.

If you implement the function correctly, running `ex5` will output a square that
is colored gradually from black in one corner to white in the opposite corner.

## Exercise 6: Read a bmp file and display it

Finally, to finish this homework, we implement a function that reads a picture
in a `.bmp` format. While this format has many different variants, we will only
implement support for the 24-bit bmp format used by Microsoft Paint. (Hence, you
should be able to render any image that you saved from Paint using that file
format.) (If you want to understand all the variants of the format, you can
study the [specification](https://en.wikipedia.org/wiki/BMP_file_format) on
Wikipedia, but that is beyond the scope of this homework.)

The format we support looks as follows:

- The file starts with a 54 byte long header. The only information we need from
  that header is:
  - The bitmap width in pixels is at offset 18, as a 4-byte signed integer.
  - The bitmap height in pixels is at offset 22, as a 4-byte signed integer.
- After the header, starting a offset 54 in the file, there is the pixel data,
  which is represented as follows.

  - Each pixel is represented by three bytes (`r`, `g` and `b`, representing the
    red, green and blue levels of the pixel). You can convert this to a
    grayscale level by just taking the average of these three values (or,
    alternatively, a slightly more precise formula is a weighted average
    `gray = (3 * r + 6 * g + b) / 10` as not all three color components are
    perceived as brightly by the human eye).
  - A row of pixels is represented by concatenating the representations of all
    pixels in the row and then padding to a multiple of 4 bytes. Hence, the size
    of the representation of a row can be computed as (see the Wikipedia
    specification linked above for an explanation of this formula):
    ```
        int row_size = (( 24 * width + 31 ) / 32 ) * 4;
    ```
  - The full image is represented by concatenating the representations of all
    rows, from bottom to top. Hence the full size of the representation of the
    image can be computed as:
    ```
        int size = row_size * height;
    ```

Your task is to complete the implementation of the
`void read_bmp(image *img, char *filename)` function in the `ex5.c` file (NOTE:
**not** `ex6.c`, this builds further on your solution to exercise 5). The
implementation already places all the bytes in file `filename` in memory, and
the variable `filedata` is initialized to a pointer that will point to the first
byte.

You should write the code that creates a corresponding grayscale image, in the
pointer parameter `img`.

If you did this correctly, you can run `ex5` with as parameter a BMP file, and
it will be rendered. (If you run `ex5` without a parameter, it will just display
the gradient grayscale square from Exercise 5.)

For instance, try:

```
./ex5 bitmaps/turing.bmp
```

To fully appreciate the result, make sure to make your terminal font small
enough (or your terminal window big enough), that one row of the picture fits on
a single line!
