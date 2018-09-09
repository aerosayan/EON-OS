;==============================================================================
;                            EON-OS : BOOT_SECTOR
;==============================================================================
;                            EXECUTION STARTS HERE 
;------------------------------------------------------------------------------

[org 0x7c00]          ; Organise the global starting point to 0x7c00
                      ; NOTE: it is important to do pointer arithmentic
mov bp, 0x9000        ; Set up the stack
mov sp, bp

mov al, 1             ; Disk sectors to read count
mov cl, 2             ; Sector to start reading from
call read_disk        ; Read from disk with the provided information

mov dx, [0x7c00+512]  ; Test if read form disk works
call print_hex
call new_line

call gdt_start        ; start up Global Descriptor Table
                      ; TODO : Switch to 32 bit protected mode

jmp $                 ; Infinite loop to halt execution

;------------------------------------------------------------------------------
;  INCLUDES
;------------------------------------------------------------------------------
%include "utils/print.asm"
%include "utils/print_hex.asm"
%include "utils/read_disk.asm"
%include "protected_mode/global_descriptor_table.asm"

;------------------------------------------------------------------------------


;------------------------------------------------------------------------------
; Padding and magic number for boot sector
times 510-($-$$) db 0
dw 0xaa55
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Extra padding to allow accessing second sector
dw 0xdada



