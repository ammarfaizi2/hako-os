#
# SPDX-License-Identifier: GPL-2.0
#
# Copyright (C) 2021  Ammar Faizi <ammarfaizi2@gmail.com> https://www.facebook.com/ammarfaizi2
#


NASM = nasm
QEMU = qemu-system-x86_64


PRINT_LIB = \
	$(BASE_DIR)/boot/lib/print.asm \
	$(BASE_DIR)/boot/lib/hexdump.asm


$(BASE_DIR)/boot/hello:	$(BASE_DIR)/boot/hello.asm $(PRINT_LIB)
	cd $(BASE_DIR)/boot; $(NASM) -fbin $(<) -o $(@)


$(BASE_DIR)/boot/disk: $(BASE_DIR)/boot/disk.asm $(PRINT_LIB)
	cd $(BASE_DIR)/boot; $(NASM) -fbin $(<) -o $(@)

boot_hello: $(BASE_DIR)/boot/hello
	$(QEMU) $(<)

boot_disk: $(BASE_DIR)/boot/disk
	$(QEMU) $(<)

.PHONY: boot_hello boot_disk
