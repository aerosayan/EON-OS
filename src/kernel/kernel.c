void kmain()
{
	// Location of VGA memory
	char* video_memory = (char*) 0xb8000;
	// Print '*' onto screen
	*video_memory = '*';
}
