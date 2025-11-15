section .text
    global  ft_strcmp

ft_strcmp:
    .loop:
        movzx   eax, byte [rdi]
        movzx   edx, byte [rsi]
        cmp     al, dl
        jne     .dif
        test    al, al
        jz      .equal
        inc     rdi
        inc     rsi
        jmp     .loop
    .dif:
        sub     eax, edx
        ret
    .equal:
        xor     rax, rax
        ret
