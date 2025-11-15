extern malloc
extern ft_strlen
extern ft_strcpy

section .text
    global  ft_strdup

ft_strdup:
        test    rdi, rdi
        jz      .error
        push    rdi
        call    ft_strlen
        inc     rax
        mov     rdi, rax
        call    malloc
        pop     rsi
        test    rax, rax
        jz      .error
        mov     rdi, rax
        call    ft_strcpy
        ret
    .error:
        ret