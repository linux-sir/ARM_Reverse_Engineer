@ LR Demo --- Link  Register Demo
    .global _start

_start:
    mov r7, #0x30
    b no_return

no_return:
    mov r7, #1
    bl my_function

wrap_up:
    mov r7, #0x12
    b exit

my_function:
    mov r0, #10
    mov pc,lr


exit:
    mov r7, #1
    svc 0
