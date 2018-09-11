//=============================================================================
// Test if the compiled C code is suitable for a kernel
//=============================================================================

//-----------------------------------------------------------------------------
// Files :
// kernel.c : source file
// kernel.o : object file produced from kernel.c
// kernel.bin : binary file produced from kernel.o
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// os-dev.pdf proposal
//-----------------------------------------------------------------------------
// Compile with : $ gcc -ffreestading -c kernel.c kernel.o
// LInk with    : $ ld -o kernel.bin -Ttext 0x0 --oformat binary kernel.o
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//  Windows solution
//-----------------------------------------------------------------------------
// However MinGW sometimes causes problems using ld thus we follow SO
// From StackOverflow (SO) question :
// stackoverflow.com/questions/25128579/ld-cannot-perform-pe-operations-on-non-pe-output-file-error/

// The solution to the problem was to link in two stages :
// $ kernel.tmp -Ttext 0x1000  kernel.o
// $ objcopy -O binary -j .text  kernel.tmp kernel.bin 

// Finally the OS image was proposed to be created using :
// $ copy /b boot_sect.bin+kernel.bin os-image
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//  Linux solution
//-----------------------------------------------------------------------------
// However, it was noticed that the Windows solution did not work in Linux
// TODO : Build a GCC cross compiler
// Compilation is going to be same obviously, the problem occurs in linking

// Linking intuition : We already have the binary code in the .o file
// the only problem is that, the .o file also contains a lot of annotations and 
// meta data provided by the GCC compiler.
// Our new born OS is not mature enough to understand the different meta data
// thrown it's way, thus we need to remove all of this and just put the bare
// essential binary instructions into the .bin file that will be run as a kernel.
// We do that using the objcopy software.
// Output .bin file with : 
// $ objcopy -O binary -j .text kernel.o kernel.bin
// where,
// -O binary : sets output target as binary
// -j .text  : gets only the bare minimum instructions produced from kernel.c
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//  Disassembly check
//-----------------------------------------------------------------------------
// We may require to look at our dissasembly of our .bin file 
// we do that using ndisasm
// $ ndisasm -b 32 kernel.bin
// Where, 
// -b 32 : tells the disassembler to decode to 32 bits instructions
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Unwanted assembly code appear in code error
//-----------------------------------------------------------------------------
// If unwanted assembly code appear in the dissasembled version, then make sure
// that it is not just a pointer to your variables, If you believe, something 
// may have seriously gone wrong and the results are not seeming correct, then
// try compiling the kernel.c using gcc with -m32 compilation option.
// I observed a problem like that and was able to solve it with -m32.
// objcopy method of creating the binary file works great with -m32 method.
// But, ld will not work in that case and say that i386 architechture of the 
// input file kernel.o is incompatible with i386-x86_x4 architechture of the 
// output file. In that case instead of -m32 use ld -melf_i386, this will allow the
// use of ld for creating the binary files.
//-----------------------------------------------------------------------------


// Test kernel function that is to be compiled
int kernel_function()
{
	return 0xabcd;
}
