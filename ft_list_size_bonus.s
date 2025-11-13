; int     ft_list_size(t_list *begin_list);

section .text
    global ft_list_size

ft_list_size:
        ; prologue
        push    rbp
        mov     rbp, rsp

        xor     rax, rax
    .loop:
        test    rdi, rdi
        jz      .end
        inc     rax
        mov     rdi, [rdi+8]
        jmp     .loop
    .end:
        pop     rbp
        ret