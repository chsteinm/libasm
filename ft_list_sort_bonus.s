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

        mov     rdi, [rdi]
        push    rdi
        push    rsi
        sub     rsp, 8
        call    ft_list_size
        add     rsp, 8
        pop     r14             ; r14 = cmp()
        pop     r15             ; r15 = first node
        mov     r12, rax        ; r12 = number of nodes to compare left        

    .loop:
        cmp     r12, 2
        jl      .end            ; finish if < 2
        dec     r12
        mov     r13, r12
        mov     rbx, r15        ; rbx = current node

        .inner_loop:
            test    r13, r13
            jz      .loop
            mov     rdi, [rbx]      ; node->data
            mov     rax, [rbx+8]    ; node->next
            mov     rsi, [rax]
            sub     rsp, 8
            call    r14
            add     rsp, 8
            cmp     rax, 0
            jle      .inner_loop
            ; swap
            mov     rax, [rbx]      ; tmp node->a
            mov     rdx, rbx        ; tmp node 
            mov     rbx, [rbx+8]    ; node->next
            mov     rcx, [rbx]      ; node->next->b
            mov     [rdx], rcx      ; node->a = b
            mov     [rbx], rax      ; node->next->b = a
            dec     r13
            jmp     .inner_loop

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