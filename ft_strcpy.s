section .text
    global  ft_strcpy

ft_strcpy:
        push    rbp
        mov     rbp, rsp
        mov     rax, rdi
    .loop:
        cmp     byte [rsi], 0
        je      .end
        movsb ; same as :
        ; mov     dl, [rsi]
        ; mov     [rdi], dl
        ; inc     rdi
        ; inc     rsi
        jmp     .loop
    .end:
        pop     rbp
        mov     byte [rdi], 0
        ret