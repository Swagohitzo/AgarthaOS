#MakeFile for the bootloader YAY

ASM = nasm
ASM_FLAGS = -f bin


BOOTLOADER = boot.asm
OUTPUT_BIN = boot.bin
DISK_IMG = boot.img

all: $(DISK_IMG)

$(OUTPUT_BIN): $(BOOTLOADER)
	$(ASM) $(ASM_FLAGS) $(BOOTLOADER) -o $(OUTPUT_BIN)

$(DISK_IMG): $(OUTPUT_BIN)
	dd if=/dev/zero of=$(DISK_IMG) bs=512 count=2880
	dd if=$(OUTPUT_BIN) of=$(DISK_IMG) conv=notrunc


run: $(DISK_IMG)
	qemu-system-x86_64 -drive format=raw,file=$(DISK_IMG)

clean:
	rm -f $(OUTPUT_BIN) $(DISK_IMG)
.PHONY: all run clean

# Makefile created with basic bootloader setup