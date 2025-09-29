#include <stdio.h>
#include <string.h>
#include <inttypes.h>

int64_t ft_strlen(const char* str);

int main(int argc, char** argv) {
    printf("Testing ft_strlen vs strlen from libc (add some argv for more tests):\n\n");
    for (int i = 0; i < argc; i++) {
        char* str = argv[i];
        size_t len = strlen(str);
        printf("For the str '%s':\nC strlen: %ld\n", str, len);
        size_t len_asm = ft_strlen(str);
        printf("ft_strlen: %ld\n\n", len_asm);
    }
    return 0;
}