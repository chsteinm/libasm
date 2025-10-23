extern ft_strlen

section .text
    global ft_atoi_base

; Fonction principale: int atoi_base(char *str, char *base)
; mov r12, rdi        ; r12 = str (1er argument)
; mov r13, rsi        ; r13 = base (2ème argument) 
; mov r14, rax        ; r14 = base_len
; mov r15, rdx        ; r15 = sign
ft_atoi_base:
        ; prologue
        push    rbp
        mov     rbp, rsp
        push    rbx
        push    r12
        push    r13
        push    r14
        push    r15

        mov     r12, rdi        ; r12 = str (1er argument)
        mov     r13, rsi        ; r13 = base (2ème argument)

        mov     rdi, r13
        call    is_valid_base
        test    rax, rax
        jz      .end

        mov     rdi, r13
        call    ft_strlen
        mov     r14, rax        ; r14 = base_len

        jmp .skip_wspace
        .skip_char
            inc r12
        .skip_wspace:
            mov al, byte [r12]
            cmp al, ' '
            je .skip_char
            cmp al, 9
            jl .suite ;;;;;
            cmp al, 13
            jle .skip_char


    .end:
        pop r15
        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp
        ret

is_valid_base:
        ; prologue
        push    rbp
        mov     rbp, rsp
        push    r12
        push    r13

        mov     r12, rdi
        call    ft_strlen
        cmp     rax, 2
        jl      .invalid        ; longueur < 2
        mov     r13, rax        ; r13 = longueur

        xor     rbx, rbx        ; rbx = i = 0  
    .check_loop:
        cmp     rbx, r13
        je      .valid

        mov al, byte [r12 + rbx]
        cmp al, ' '
        je .invalid
        cmp al, '+'
        je .invalid
        cmp al, '-'
        je .invalid
        cmp al, 9
        jl .check_duplicates
        cmp al, 13
        jle .invalid

    .check_duplicates:
        mov rcx, rbx
        .duplicates_loop:
            inc rcx
            cmp rcx, r13
            jge .next_char

            mov dl, byte [r12 + rcx]
            cmp al, dl
            je .invalid
            jmp .duplicates_loop

    .next_char:
        inc rbx
        jmp .check_loop

    .invalid:
        xor rax, rax
        jmp .check_end

    .valid:
        mov rax, 1
        jmp .check_end
        
    .check_end:
        pop r13
        pop r12
        pop rbp    
        ret