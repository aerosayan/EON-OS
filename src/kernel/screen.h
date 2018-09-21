//-------------------------
// SCREEN ATTRIBUTES
//-------------------------
#define VID_MEM  0xb8000            // VGA video memory address
#define MAX_ROWS 25                 // Max number of rows on the sreen
#define MAX_COLS 80                 // Max number of columns on the sreen

//-------------------------
// FRAMEBUFFER 
//-------------------------
#define FB_CMD_PORT  0x3d4          // Framebuffer command port
#define FB_DATA_PORT 0x3d5          // Framebuffer data port
#define FB_HIGH_BYTE_CMD   14       // Framebuffer I/O high byte command
#define FB_LOW_BYTE_CMD    15       // Framebuffer I/O low byte command


//-------------------------
// SCREEN COLOR ATTRIBUTES
//-------------------------
#define COL_WHITE_ON_BLACK 0x0f    // White text on black screen 
#define COL_WB             0x0f    // Shortcut for white on black screen


//-----------------------------------------------------------------------------
// clear_screen :
// Clears the screen 
//-----------------------------------------------------------------------------
void clear_screen();

//-----------------------------------------------------------------------------
// print_banner :
// Print the OS banner and info onto the screen
//-----------------------------------------------------------------------------
void print_banner();

//-----------------------------------------------------------------------------
// print :
// Print text onto screen
// @param str, the text/string to be printed
//-----------------------------------------------------------------------------
void print(char * str);

