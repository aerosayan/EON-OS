all: boot_sector.bin kernel.bin
	cat boot_sector.bin kernel.bin > os_image.bin

run: os_image.bin
	@echo "-------------------------------"
	@echo "RUNNING BOOTLOADER..."
	qemu-system-i386.exe -d guest_errors os_image.bin
	@echo "-------------------------------"
clean:
	@echo "-------------------------------"
	@echo "CLEANING BOOTLOADER..."
	rm boot_sector.bin kernel.bin os_image.bin
	@echo "-------------------------------"
xxd:
	@echo "-------------------------------"
	xxd os_image.bin
	@echo "-------------------------------"
dis: kernel.bin 
	@echo "-------------------------------"
	@echo "DISASSEMBLING BINARY FILE..."
	ndisasm -b 32 kernel.bin
	@echo "-------------------------------"
