extern  ft_list_size

; void ft_list_sort(t_list **begin_list, int (*cmp)());
; (*cmp)(list_ptr->data, list_other_ptr->data);

section .text
    global ft_list_sort

ft_list_sort:
        ; prologue
        push    rbp
        mov     rbp, rsp
        push    rbx
        push    r12
        push    r13
        push    r14
        push    r15

        
        test    rdi, rdi
        jz      .end            ; if begin_list is NULL, do nothing
        test    rsi, rsi
        jz      .end

        mov     r15, rsi        ; r15 = cmp()
        mov     rbx, [rdi]      ; rbx = *begin
        test    rbx, rbx
        jz      .end

    .loop:
        mov     r12, 0          ; r12 = bool
        mov     r13, rbx        ; r13 = current node
        .inner_loop:
            mov     r14, [r13+8]    ; r14 = node->next
            test    r14, r14
            jz      .end_inner_loop
            mov     rdi, [r13]
            mov     rsi, [r14]
            sub     rsp, 8
            call    r15
            add     rsp, 8
            cmp     eax, 0
            jle     .next
            ; swap
            mov     rax, [r13]      ; a
            mov     rdx, [r14]      ; b
            mov     [r14], rax
            mov     [r13], rdx
            mov     r12, 1          ; true
        .next:
            mov     r13, [r13+8]
            jmp     .inner_loop
    .end_inner_loop:
        test    r12, r12
        jnz     .loop


    .end:
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp
        ret



; void	ft_sort_params(int argc, char **argv)
; {
; 	int	i;

; 	while (--argc >= 1)
; 	{
; 		i = argc - 1;
; 		while (i > 0)
; 		{
; 			if (ft_strcmp(argv[i], argv[argc]) > 0)
; 				ft_swap(&argv[i], &argv[argc]);
; 			i--;
; 		}
; 	}
; }