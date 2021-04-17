;
; SPDX-License-Identifier: GPL-2.0
;
; Copyright (C) 2021  Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
;

; void print_hexdump(char *di);
print:
	cli
	pusha
	mov	ah, 0x0e ; TTY mode
.pr_loop:
	mov	al, [di]
	test	al, al
	jz	.pr_ret

	int	0x10

	inc	di
	jmp	.pr_loop
.pr_ret:
	popa
	sti
	ret
