#
# SPDX-License-Identifier: GPL-2.0
#
# Copyright (C) 2021  Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
#


NASM = nasm
QEMU = qemu-system-x86_64

all: hello

hello: hello.asm lib/print.asm lib/hexdump.asm
	$(NASM)	-fbin hello.asm -o hello

run: hello
	$(QEMU) hello
