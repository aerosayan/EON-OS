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
		video_mem[i+1] = COL_WB;
}

//-----------------------------------------------------------------------------
// print_banner :
// Print the OS banner and info onto the screen
//-----------------------------------------------------------------------------
void print_banner()
{

	// Location of VGA memory 1st row
	unsigned char* video_mem = (unsigned char*) VID_MEM;

	char str0[] = " _____ _____ _____    _____ _____ ";
	char str1[] = "|   __|     |   | |  |     |   __|";
	char str2[] = "|   __|  |  | | | |  |  |  |__   |";
	char str3[] = "|_____|_____|_|___|  |_____|_____|";
	
	int i=0;
	// Iterate till the end of string 
	while(str0[i]){
		
		*video_mem++ = str0[i++];
		*video_mem++ = COL_WB;
	}

	// Location of 2nd row
	video_mem = (unsigned char*) VID_MEM + 80*2;
	
	i=0;
	// Iterate till the end of string 
	while(str1[i]){
		
		*video_mem++ = str1[i++];
		*video_mem++ = COL_WB;
	}
	
	/*
	// Location of 3rd row
	video_mem =  (unsigned char*)VID_MEM + 80*4;
	
	i=0;
	// Iterate till the end of string 
	while(str2[i]){
		
		*video_mem++ = str2[i++];
		*video_mem++ = COL_WB;
	}
	
	// Location of 4th row
	video_mem = (unsigned char*) VID_MEM + 240*2;
	
	i=0;
	// Iterate till the end of string 
	while(str3[i]){	
		*video_mem++ = str3[i++];
		*video_mem++ = COL_WB;
	}
	*/
}
//-----------------------------------------------------------------------------
// fb_move_cursor:
// Move the cursor to the location after the currently printed character
//-----------------------------------------------------------------------------
void fb_move_cursor()
{

}

//-----------------------------------------------------------------------------
// print :
// Print text onto screen
//-----------------------------------------------------------------------------
void print(char * strx)
{
	char  str[] = "INF-Screen clear completed";

	// Location of VGA memory
	unsigned char* video_mem = (unsigned char*) VID_MEM;

	int i=0;
	// Iterate till the end of string 
	while(str[i]){
		
		*video_mem++ = str[i++];
		*video_mem++ = COL_WB;
	}
}
