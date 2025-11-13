extern  ft_list_size

; void ft_list_sort(t_list **begin_list, int (*cmp)());
; (*cmp)(list_ptr->data, list_other_ptr->data);

section .text
    global ft_list_sort

ft_list_sort:
        ; prologue
        push    rbp
        mov     rbp, rsp
        
        test    rdi, rdi
        jz      .end            ; if begin_list is NULL, do nothing

        push    rdi
        push    rsi
        mov     rdi, [rdi]
        call    ft_list_size
        pop     rsi
        pop     rdi
        mov     r12, rax        ; r12 = number of nodes to compare left        

    .loop:
        cmp     r12, 2
        jl      .end            ; finish if < 2
        mov     r13, r12
        dec     r13
        .inner_loop:
            

    .end:
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