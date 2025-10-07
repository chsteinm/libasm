section .text
    global  ft_strcmp

ft_strcmp:
    .loop:
        mov     al, [rdi]
        cmp     al, [rsi]
        jne     .dif
        cmp     al, 0
        je      .equal
        inc     rdi
        inc     rsi
        jmp     .loop
    .dif:
        mov     bl, [rsi]
        sub     al, bl
        movsx   rax, al
        ret
    .equal:
        xor     rax, rax
        ret
