%define SYS_WRITE 1

extern __errno_location

section .text
    global  ft_write

ft_write:
        mov rax, SYS_WRITE
        syscall
        cmp     rax, 0
        jge     .end
        neg     rax
        mov     rcx, rax
        call    __errno_location
        mov     [rax], ecx      ; *errno = error code
        mov     rax, -1
    .end:
        ret