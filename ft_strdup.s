extern malloc
extern ft_strlen
extern ft_strcpy

section .text
    global  ft_strdup

ft_strdup:
        push    rdi
        test    rdi, rdi
        jz      .error
        call    ft_strlen
        inc     rax
        mov     rdi, rax
        call    malloc
        test    rax, rax
        jz      .error
        pop     rsi
        mov     rdi, rax
        call    ft_strcpy
        ret
    .error:
        pop     rdi
        xor     rax, rax
        ret