;
; SPDX-License-Identifier: GPL-2.0
;
; Copyright (C) 2021  Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
;


[org 0x7c00]

_start:
	mov	bp, 0x8000
	mov	sp, bp

	lea	di, my_str
	call	print

	mov	di, my_str
	mov	si, (end_my_str - my_str)
	call	print_hexdump

.end:
	rep	nop
	jmp 	.end


my_str:
	db `Hello World!\r\n\0`
end_my_str:


%include "lib/print.asm"
%include "lib/hexdump.asm"

	; Padding and magic number
	times 510 - ($ - $$) db 0
	dw 0xaa55
