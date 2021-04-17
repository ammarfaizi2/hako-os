#
# SPDX-License-Identifier: GPL-2.0
#
# Copyright (C) 2021  Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
#


NASM = nasm
QEMU = qemu-system-x86_64


$(BASE_DIR)/boot/hello:	$(BASE_DIR)/boot/hello.asm \
			$(BASE_DIR)/boot/lib/print.asm \
			$(BASE_DIR)/boot/lib/hexdump.asm
	cd $(BASE_DIR)/boot; $(NASM) -fbin $(<) -o $(@)

boot: $(BASE_DIR)/boot/hello
	$(QEMU) $(<)


.PHONY: boot
