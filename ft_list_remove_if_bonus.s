extern free

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
; (*cmp)(list_ptr->data, data_ref);
; (*free_fct)(list_ptr->data);

section .text
    global ft_list_remove_if

ft_list_remove_if:
        ; prologue
        push    rbp
        mov     rbp, rsp
        push    rbx
        push    r12
        push    r13
        push    r14
        push    r15

        ; if a ptr is NULL, do nothing
        test    rdi, rdi
        jz      .end
        test    rsi, rsi
        jz      .end
        test    rdx, rdx
        jz      .end

        mov     rbx, [rdi]          ; rbx = *begin
        mov     r12, rsi            ; r12 = data_ref
        mov     r13, rdx            ; r13 = cmp()
        mov     r14, rcx            ; r14 = free()

        mov     r15, 0              ; r15 = previous node
    .loop:
        test    rbx, rbx
        jz      .end
        push    rdi
        push    r15
        mov     rdi, [rbx]
        mov     rsi, r12
        sub     rsp, 8
        call    r13
        add     rsp, 8
        pop     r15
        pop     rdi
        test    eax, eax
        jnz     .next
        mov     rsi, [rbx+8]
        test    r15, r15
        jz      .remove_data
        mov     [r15+8], rsi
    .remove_data:
        test    r14, r14
        jz      .update_begin
        push    rdi
        mov     rdi, [rbx]
        call    r14
        pop     rdi
    .update_begin:
        mov     r15, [rbx+8]
        cmp     [rdi], rbx
        jne     .free_node
        mov     [rdi], r15
    .free_node:
        push    rdi
        mov     rdi, rbx
        call    free
        pop     rdi
        mov     rbx, r15
        jmp     .loop
    .next:
        mov     r15, rbx
        mov     rbx, [rbx+8]
        jmp     .loop

    .end:
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp
        ret

        ;TODO : utiliser que la fonction free pour data, si elle n est pas null