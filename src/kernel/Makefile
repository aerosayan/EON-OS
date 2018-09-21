all: $(SRC_KERNEL)
	@echo "COMPILING KERNEL..."
	$(CC) $(CC_FLAGS) kernel.c -o kernel.o
	#objcopy -O binary -j .text kernel.o kernel.bin
	ld -o kernel.bin -melf_i386 -Ttext 0x1000 kernel.o --oformat binary
	# ndisasm -b 32 kernel.bin
	mv kernel.bin ../build/kernel.bin
	rm kernel.o
