#ASMC = nasm.exe # Assembly compiler
#ASMC_FLAGS = -fbin # Assembly compilation flags
#SRC_MAIN_ASM = main.asm

all: boot_sector.asm
	@echo "-------------------------------"
	@echo "COMPILING BOOTLOADER..."
	$(ASMC) $(ASMC_FLAGS)  boot_sector.asm -o start.bin
	@echo "-------------------------------"

run: start.bin
	@echo "-------------------------------"
	@echo "RUNNING BOOTLOADER..."
	qemu-system-x86_64.exe start.bin
	@echo "-------------------------------"
clean:
	@echo "-------------------------------"
	@echo "CLEANING BOOTLOADER..."
	rm start.bin
	@echo "-------------------------------"
xxd:
	@echo "-------------------------------"
	xxd start.bin
	@echo "-------------------------------"
