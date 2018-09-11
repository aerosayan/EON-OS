# EON OS

My fun little hobby Operating System(OS).</br>

#### Author ... Sayan Bhattacharjee
#### Email .... aero.sayan@gmail.com
#### License .. DEFAULT for now

#### DISCLAIMER
Please do not be tempted to run this project directly on your hardware, as that can probably damage your system.
It is recommended to run it inside a virtual environment to allow safe use. You have been warned and the author
will not be responsible for any damage caused due to the un-autorized and un-safe use of this software.

### Why the name EON OS?
Because this is an educational / learning kernel/OS, this will not be as powerfull as Microsoft/GNU-Linux.</br>
And it will probably take me, by myself, an EON (billion years) to make it powerful as Linux/Microsoft.</br>
Still, this is my project and as of 09-SEP-2018 it has helped me learn a lot of things.</br>

### Tools required
DEV:
+ Make : Build system,
+ NASM : compiler,
+ QEMU : Virtualization system,
+ ld   : Dynamic Linker from linux,

DEBUG: 
+ ndisasm or any other disassembler capable of disassembling 32 bit flat binary 

#### Started on  08-SEP-2018
### Milestones
Date : 09-SEP-2018 </br>
+ Build system works,
+ Virtualization system works,
+ Boots successfully into 16-bit Real Mode,
+ Printing strings work using BIOS INT 10h,
+ Printing HEX work in LITTLE ENDIAN format using BIOS INT 10h,
+ Reading from disk works using BIOS INT 13h,
+ Global Descriptor Table (GDT) defined for Protected Mode,

Date : 10-SEP-2018 </br>
+ Switched to 32-bit Protected Mode using the GDT,

Date : 11-SEP-2018 </br>
+ Build system updated to handle compiling kernels,
+ Build system updated to keep built files in seperate build directory,
+ Loaded a kernel written in C into memory from disk while in Real Mode,
+ Switched over to protected mode and printed * to VGA 0xb8000 as a proof of concept

### Todo
+ Implement the display driver

