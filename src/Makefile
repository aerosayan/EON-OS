TARGET_ARCH = x86_64                  # Target architechture
ASMC = nasm                           # Assembly compiler
ASMC_FLAGS = -fbin                    # Assembly compilation flags
CC = gcc                              # C compiler
CC_FLAGS  = -c -m32                   # C compiler flags
CC_FLAGS += -ffreestanding -static -fno-builtin -nostdlib -nostdinc 
CC_FLAGS += -fno-stack-protector -fno-exceptions -fno-leading-underscore


# Source files for bootloader
SRC_BOOTLOADER = $(SRC_BOOT_SECTOR)  $(SRC_PROTECTED_MODE) $(SRC_KERNEL)

# Source files for boot sector
SRC_BOOT_SECTOR += boot_sector.asm

# Source files for kernel
SRC_KERNEL += kernel.c


# Directories for the source code
SRC_BOOTLOADER_DIR = $(bootloader/$(TARGET_ARCH))
SRC_UTILS_DIR  = $($(SRC_BOOTLOADER_DIR)/utils)
SRC_PROTECTED_MODE_DIR = $($(SRC_BOOTLOADER_DIR)/protected_mode)
SRC_KERNEL_DIR = $(kernel)

# Source files for boot loader utilities
SRC_UTILS += print.asm
SRC_UTILS += print_hex.asm 
SRC_UTILS += read_disk.asm 

# Source files for protected mode 
SRC_PROTECTED_MODE += global_descriptor_table.asm
SRC_PROTECTED_MODE += pm_print.asm
SRC_PROTECTED_MODE += pm_switch.asm



# All source files
SRC += $(addprefix $(SRC_BOOTLOADER_DIR)/      ,$( $(SRC_BOOTLOADER         )))
SRC += $(addprefix $(SRC_UTILS_DIR)/           ,$( $(SRC_UTILS              )))
SRC += $(addprefix $(SRC_PROTECTED_MODE_DIR)/  ,$( $(SRC_PROTECTED_MODE     )))
SRC += $(addprefix $(SRC_KERNEL_DIR)/          ,$( $(SRC_KERNEL             )))

# Paths for make to search
VPATH = $(SRC_BOOTLOADER_DIR) $(SRC_UTILS_DIR)  $(SRC_KERNEL_DIR)

# Export all variables to sub makes
export

# Build all sources
all: $(SRC) 
	@echo "-------------------------------------------------------------------"
	@echo "                COMPILING EON OS SOURCE CODE"
	@echo "                      Version : 0.0.1 "
	@echo "           Author : Sayan Bhattacharjee (aerosayan)"
	@echo "                Email  : aero.sayan@gmail.com"
	@echo "-------------------------------------------------------------------"
	+$(MAKE) -C bootloader/$(TARGET_ARCH)
	+$(MAKE) -C kernel/
	+$(MAKE) -C build/
	@echo "-------------------------------------------------------------------"

# Run the built source
run: 
	@echo "-------------------------------------------------------------------"
	@echo "                  RUNNING EON OS KERNEL "
	@echo "                      Version : 0.0.1 "
	@echo "           Author : Sayan Bhattacharjee (aerosayan)"
	@echo "                Email  : aero.sayan@gmail.com"
	@echo "-------------------------------------------------------------------"
	$(MAKE) -C build/  run
	@echo "-------------------------------------------------------------------"

# Check the flat binary file created for the os image
xxd:
	@echo "-------------------------------------------------------------------"
	@echo "           RUNNING EON OS KERNEL BINARY FILE CHECK "
	@echo "-------------------------------------------------------------------"
	$(MAKE) -C build/ xxd
	@echo "-------------------------------------------------------------------"
# Disassemble the flat binary file created
dis:
	@echo "-------------------------------------------------------------------"
	@echo "        RUNNING EON OS KERNEL BINARY DISSASEMBLY CHECK "
	@echo "-------------------------------------------------------------------"
	$(MAKE) -C build/ dis
	@echo "-------------------------------------------------------------------"

# Clean up the built files
clean:
	@echo "-------------------------------------------------------------------"
	$(MAKE) -C build/ clean
	@echo "-------------------------------------------------------------------"
