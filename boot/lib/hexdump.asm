;
; SPDX-License-Identifier: GPL-2.0
;
; Copyright (C) 2021  Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
;


; void print_hexdump(void *di, size_t si);
print_hexdump:
	test	si, si
	jz	.pr_ret_direct	; Skip everything, we have nothing to print.

	cli
	pusha
	mov	ah, 0x0e ; TTY mode
	mov	bx, .hex_chars
	xor	cl, cl
.pr_loop:
	and	cl, 0xf
	jnz	.pr_hex

	; Print a CRLF `\r\n`
	mov	al, 0x0d
	int	0x10
	mov	al, 0x0a
	int	0x10
.pr_hex:
	mov	dl, [di]
	mov	al, dl
	shr	al, 4
	xlatb
	int	0x10

	mov	al, dl
	and	al, 0xf
	xlatb
	int	0x10

	mov	al, ' '
	int	0x10

	inc	cl
	inc	di
	dec	si
	jnz	.pr_loop
.pr_ret:
	popa
	sti
.pr_ret_direct:
	ret

.hex_chars:
	db	"0123456789abcdef"
