
@ Stack Pointer Demo

	.global _start

_start:
	mov r7, #0x30
	push {r7}
	mov r7, #0x10
	pop {r7}

exit:
	mov r7, #1
	svc 0
