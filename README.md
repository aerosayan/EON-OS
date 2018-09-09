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
And it will probably take me, by myself, an eon to make it powerful as Linux/Microsoft.</br>
Still, this is my project and as of 09-SEP-2018 it has helped me learn a lot of things.</br>

### Tools required
+ Make build system
+ NASM compiler
+ QEMU virtualization system

#### Started on  08-SEP-2018
### Current status
Date : 09-SEP-2018 </br>
+ Build system works,
+ Virtualization system works,
+ Boots successfully into 16-bit Real Mode,
+ Printing strings work using BIOS INT 10h,
+ Printing HEX work in LITTLE ENDIAN format using BIOS INT 10h,
+ Reading from disk works using BIOS INT 13h,
+ Global Descriptor Table (GDT) defined for Protected Mode,

### Todo
+ Switch to 32-bit Protected Mode using the GDT,
+ Load a kernel 

