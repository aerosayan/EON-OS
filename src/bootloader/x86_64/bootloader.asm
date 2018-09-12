;==============================================================================
;                            EON-OS : BOOTLOADER
;==============================================================================
;                            EXECUTION STARTS HERE 
;------------------------------------------------------------------------------

[org 0x7c00]          ; Organise the global starting point to 0x7c00
                      ; NOTE: it is important to do pointer arithmentic

KERNEL_OFFSET equ 0x1000         ; Memory position set by ld where kernel is 

mov [BOOT_DRIVE], dl  ; The BIOS stores the drive info in DL register
                      ; This will be used to read from disk and load our kernel

mov bp, 0x9000        ; Set up the stack
mov sp, bp

mov si, MSG_RMODE
call print            ; Print info in real mode
call new_line

call load_kernel      ; Load kernel from disk

call switch_to_pm     ; Swtich to protected mode
                      ; NOTE : EXECUTION IS NEVER RETURNED FROM HERE

jmp $                 ; Infinite loop to hang execution 
                      ; NOTE : WILL NEVER BE EXECUTED
;------------------------------------------------------------------------------
;  INCLUDES
;------------------------------------------------------------------------------
%include "utils/print.asm"
%include "utils/print_hex.asm"
%include "utils/read_disk.asm"
%include "protected_mode/global_descriptor_table.asm"
%include "protected_mode/pm_print.asm"
%include "protected_mode/pm_switch.asm"

;------------------------------------------------------------------------------
[bits 16]

; LOAD_KERNEL
load_kernel:
	;--------------------------------------------------------------------------
	mov si,MSG_KLOAD
	call print
	call new_line

	;--------------------------------------------------------------------------
	; Setup registers to call read_disk and read in the kernel
	;--------------------------------------------------------------------------
	mov bx, 0x00
	mov es, bx
	mov bx, 0x7c00 + KERNEL_OFFSET
	mov al, 1                          ; Number of sectors to read
	mov cl, 2                          ; Start reading from second sector
	mov ch, 0x0                        ; Cyllinder = 0
	mov dh, 0x0                        ; Head = 0
	;--------------------------------------------------------------------------

	call read_disk
	ret
	;--------------------------------------------------------------------------




;------------------------------------------------------------------------------
[bits 32]                 ; Start 32-bit protected mode

; BEGIN_PM
BEGIN_PM:                 ; Execution is transferred here from switch_to_pm
	;--------------------------------------------------------------------------
	mov ebx, MSG_PMODE
	call pm_print         ; Print info in protected mode

	call 0x7c00 + KERNEL_OFFSET


	jmp $                 ; Infinite loop hang execution

;------------------------------------------------------------------------------
; GLOBAL VARIABLES
;------------------------------------------------------------------------------
MSG_RMODE : db "INF - Started in 16-bit real mode...",0
MSG_PMODE : db "INF - Switched to 32-bit protected mode...",0
MSG_KLOAD : db "INF - Loading kernel...",0
BOOT_DRIVE : db 0

;------------------------------------------------------------------------------
; Padding and magic number for boot sector
times 510-($-$$) db 0
dw 0xaa55
;------------------------------------------------------------------------------
