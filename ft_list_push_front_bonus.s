extern malloc

section .text
    global  ft_list_push_front

; void ft_list_push_front(t_list **begin_list, void *data)
; rdi = begin_list (t_list **)
; rsi = data (void *)
ft_list_push_front:
        ; prologue
        push    rbp
        mov     rbp, rsp

        test    rdi, rdi
        jz      .end           ; do nothing if begin_list is NULL

        push    rdi            ; save begin_list
        push    rsi            ; save data
        mov     rdi, 16        ; size of t_list: 2 pointers (16 bytes)
        call    malloc
        pop     rsi
        pop     rdi
        test    rax, rax
        jz      .end           ; ret 0 if malloc failed

        mov     [rax], rsi     ; node->data = data
        mov     rdx, [rdi]     ; rdx = *begin_list
        mov     [rax + 8], rdx   ; node->next = old head
        mov     [rdi], rax     ; *begin_list = new node
    .end:
        pop     rbp
        ret
