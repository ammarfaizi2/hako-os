;
; SPDX-License-Identifier: GPL-2.0
;
; Copyright (C) 2021  Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
;

[org 0x7c00]

_start:
	mov	bp, 0x8000
	mov	sp, bp

	mov	bx, 0x9000	; es:bx = 0x0000:0x9000 = 0x09000
	mov	dh, 2		; read 2 sectors
	call	disk_load


; Load `dh` sectors from drive `dl` into ES:BX
disk_load:
	pusha
	; Reading from disk requires setting specific values in all registers
	; so we will overwrite our input parameters from 'dx'. Let's save it
	; to the stack for later use.
	push	dx

	mov	ah, 0x02	; `ah` <- int 0x13 function. 0x02 = 'read'
	mov	al, dh		; `al` <- number of sectors to read (0x01 .. 0x80)
	mov	cl, 0x02	; `cl` <- sector (0x01 .. 0x11)
				; 0x01 is our boot sector, 0x02 is the first 'available' sector
	mov	ch, 0x00	; `ch` <- cylinder (0x0 .. 0x3FF, upper 2 bits in `cl`)
	; `dl` <- drive number. Our caller sets it as a parameter and gets it from BIOS
	; (0 = floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
	mov	dh, 0x00	; dh <- head number (0x0 .. 0xF)

	; [es:bx] <- Pointer to buffer where the data will be stored
	; Caller sets it up for us, and it is actually the standard location for int 13h
	int	0x13		; BIOS interrupt
	jc	disk_error	; if error (stored in the carry bit)

	pop	dx
	cmp	al, dh		; BIOS also sets 'al' to the # of sectors read. Compare it.
	jne	sectors_error
	popa
	ret
