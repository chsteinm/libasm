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
        sub     rsp, 8
        call    __errno_location
        add     rsp, 8
        mov     [rax], rdi      ; *errno = error code
        mov     rax, -1
    .end:
        ret