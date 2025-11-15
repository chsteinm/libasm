%define SYS_WRITE 1

extern __errno_location

section .text
    global  ft_write

ft_write:
        mov     rax, SYS_WRITE
        syscall
        cmp     rax, 0
        jge     .end
        neg     rax
        mov     rdi, rax
        push    rdi
        call    __errno_location
        pop     rdi
        mov     [rax], edi      ; *errno = error code (32-bits)
        mov     rax, -1
    .end:
        ret