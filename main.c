#include <stdio.h>
#include <string.h>
#include <inttypes.h>
#include <unistd.h>
#include <errno.h>

int64_t ft_strlen(const char* str);
char* ft_strcpy(char* dest, const char* src);
int ft_strcmp(const char* s1, const char* s2);
ssize_t ft_write(int fd, const void* buf, size_t count);

int main(int argc, char** argv) {
    printf("Testing ft_strlen vs strlen from libc (add some argv for more tests):\n\n");
    for (int i = 0; i < argc; i++) {
        char* str = argv[i];
        size_t len = strlen(str);
        printf("For the str '%s':\nC strlen: %ld\n", str, len);
        size_t len_asm = ft_strlen(str);
        printf("ft_strlen: %ld\n\n", len_asm);
    }
    printf("\nTesting ft_strcpy vs strcpy from libc:\n\n");
    for (int i = 0; i < argc; i++) {
        char* str = argv[i];
        char dest[4096];
        char dest_asm[4096];
        strcpy(dest, str);
        printf("For the str '%s':\nC strcpy: %s\n", str, dest);
        ft_strcpy(dest_asm, str);
        printf("ft_strcpy: %s\n\n", dest_asm);
    }
    printf("\nTesting ft_strcpy vs strcpy from libc:\n\n");
    for (int i = 0; i < argc; i++) {
        char* str1 = argv[i];
        char* str2 = (i + 1 < argc) ? argv[i + 1] : "";
        int cmp = strcmp(str1, str2);
        printf("Comparing '%s' and '%s':\nC strcmp: %d\n", str1, str2, cmp);
        int cmp_asm = ft_strcmp(str1, str2);
        printf("ft_strcmp: %d\n\n", cmp_asm);
    }
    printf("\nTesting ft_write vs strcpy from libc:\n");
    for (int i = 0; i < argc; i++) {
        char* str = argv[i];
        dprintf(1, "\nC Write: '");
        ssize_t res = write(1, str, strlen(str));
        printf("'\nReturn: %ld\n", res);
        dprintf(1, "\nft_write: '");
        ssize_t res_asm = ft_write(1, str, strlen(str));
        printf("'\nReturn: %ld\n\n", res_asm);
    }
    printf("\nTest errno with C write (fd = -1):\n");
    errno = 0; // reset errno
    ssize_t ret = write(-1, "test", 4);
    printf("Return: %ld, errno: %d (%s)\n", ret, errno, strerror(errno));
    printf("\nTest errno with ft_write (fd = -1):\n");
    errno = 0; // reset errno
    ret = ft_write(-1, "test", 4);
    printf("Return: %ld, errno: %d (%s)\n", ret, errno, strerror(errno));
    return 0;
}