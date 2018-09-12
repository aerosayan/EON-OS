//-----------------------------------------------------------------------------
// USE DIRECTION : 
// include screen.h on the top of kernel.c
// include screen.c to the bottom of kernel.c
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// clear_screen :
// Clears the screen 
//-----------------------------------------------------------------------------
void clear_screen()
{
	// Location of VGA memory
	unsigned char* video_mem = (unsigned char*) VID_MEM;

	// Print a space ' ' character onto all the 80*25 postions on the screen
	for(int i=0;i<80*25;i+=2)
		video_mem[i]   = ' ',
		video_mem[i+1] = COL_BW;
}

//-----------------------------------------------------------------------------
// fb_move_cursor:
// Move the cursor to the location after the currently printed character
//-----------------------------------------------------------------------------
void fb_move_cursor()
{

}

