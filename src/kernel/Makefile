all: $(SRC_KERNEL)
	@echo "COMPILING KERNEL..."
	$(CC) $(CC_FLAGS) kernel.c -o kernel.o
	#objcopy -O binary -j .text kernel.o kernel.bin
	ld -melf_i386 -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary
	# ndisasm -b 32 kernel.bin
	mv kernel.bin ../build/kernel.bin
	rm kernel.o
