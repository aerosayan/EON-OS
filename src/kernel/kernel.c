#include "screen.h"                           // Framebuffer drivers

// Execution startng point of the kernel
void kmain()
{
	// clear the screen using memory mapped I/O
	clear_screen();
	// set cursor to 1st row and 1st column using I/O port
	// example : fb_move_cursor(0); 
}

#include "screen.c"
