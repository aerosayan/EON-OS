all: $(SRC_BOOT_SECTOR)
	@echo "-------------------------------"
	@echo "COMPILING BOOTLOADER..."
	$(ASMC) $(ASMC_FLAGS)  boot_sector.asm -o boot_sector.bin
	mv boot_sector.bin ../../build/boot_sector.bin
	@echo "-------------------------------"
