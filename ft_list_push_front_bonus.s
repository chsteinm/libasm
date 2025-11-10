extern malloc

section .text
    global  ft_list_push_front

; void ft_list_push_front(t_list **begin_list, void *data)
; rdi = begin_list (t_list **)
; rsi = data (void *)
ft_list_push_front:
        test    rdi, rdi
        jz      .ret

        push    rbp
        mov     rbp, rsp
        push    rdi            ; save begin_list
        push    rsi            ; save data
        sub     rsp, 8         ; align stack to 16 before calling malloc

        mov     rdi, 16        ; size of t_list: 2 pointers (16 bytes)
        call    malloc

        add     rsp, 8
        pop     rsi            ; restore data -> rsi
        pop     rdi            ; restore begin_list -> rdi

        test    rax, rax
        jz      .end           ; malloc failed -> do nothing

        mov     [rax], rsi     ; node->data = data
        mov     rdx, [rdi]     ; rdx = *begin_list
        mov     [rax+8], rdx   ; node->next = old head
        mov     [rdi], rax     ; *begin_list = new node

    .end:
        pop     rbp
    .ret:
        ret
