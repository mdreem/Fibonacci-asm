section .data
    msg db `Result: %d\n`  ; backticks for \n
 
section .text
    global main
    extern printf
main:
    push    rbp
    mov     rbp, rsp

    mov     rdi, 25
    call    fib

    lea     rdi, [msg]  ; moves adress of msg into rdi
    mov     rsi, rax
    xor     eax, eax    ; no floating point paramters
    call    printf
    xor     eax, eax    ; return 0
    pop     rbp
    ret

; int fib(int n)
; n in rdi
; return value in rax
fib:
    push    rbp
    mov     rbp, rsp

    cmp     rdi, 0      ; n == 0
    jz      .iszero
    cmp     rdi, 1      ; n == 1
    jz      .isone

    sub     rsp, 0x20   ; space for local variables

    mov     [rbp-0x8], rdi ; save n

    sub     rdi, 1      ; n-1
    call    fib         ; fib(n-1)

    mov     [rbp-0x10], rax ; t = fib(n-1)
    mov     rdi, [rbp-0x8] ; restore n
    
    sub     rdi, 2      ; n-2 
    call    fib         ; fib(n-2)

    mov     rsi, [rbp - 0x10] ; fib(n-1) to rsi
    add     rax, rsi    ; fib(n-2) + fib(n-1)

    leave
    ret
.iszero:
    mov     rax, 0
    pop     rbp
    ret
.isone:
    mov     rax, 1
    pop     rbp
    ret

        
