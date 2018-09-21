#include "screen.h"                           // Framebuffer drivers

// Execution startng point of the kernel
void kmain()
{
	// clear the screen using memory mapped I/O
	clear_screen();
	// print the banner
	print_banner();
}

#include "screen.c"
