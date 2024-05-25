#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

// The helper function below will make the contents of the file with name filename
// available in memory, and the return value is a pointer to these contents
// NO NEED TO UNDERSTAND THE IMPLEMENTATION OF THE FUNCTION
char *readfile(char* filename) {
    int fd = open(filename, O_RDONLY);
    if (fd < 0)
    {
        printf("Error: could not open %s\n", filename);
        exit(-1);
    }
    struct stat s;
    if (fstat(fd, &s) == -1) {
        printf("Error: could not fstat %s\n", filename);
        exit(-1);
    }
    void* result = mmap(NULL,s.st_size,PROT_READ,MAP_PRIVATE,fd,0);
    if (result == MAP_FAILED) {
        printf("Error: could not mmap %s\n", filename);
        exit(-1);
    }
    close(fd);
    return result;
}

