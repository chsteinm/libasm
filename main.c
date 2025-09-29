#include <stdio.h>
#include <string.h>
#include <inttypes.h>

int64_t ft_strlen(const char* str);
char* ft_strcpy(char* dest, const char* src);
int ft_strcmp(const char* s1, const char* s2);

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
    return 0;
}