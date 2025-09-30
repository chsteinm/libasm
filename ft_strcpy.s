section .text
    global  ft_strcpy

ft_strcpy:
        mov     rax, rdi
    .loop:
        cmp byte [rsi], 0
        je  .end
        mov al, [rsi]
        mov [rdi], al
        inc rdi
        inc rsi
        jmp .loop
    .end:
        mov byte [rdi], 0
        ret