all: bootloader.asm
	@echo "-------------------------------"
	@echo "COMPILING BOOTLOADER..."
	$(ASMC) $(ASMC_FLAGS)  bootloader.asm -o bootloader.bin
	mv bootloader.bin ../../build/bootloader.bin
	@echo "-------------------------------"
