;==============================================================================
;                            EON-OS : BOOTLOADER
;==============================================================================
;                            EXECUTION STARTS HERE 
;------------------------------------------------------------------------------

[bits 16]
[org 0x7c00]          ; Organise the global starting point to 0x7c00
                      ; NOTE: it is important to do pointer arithmentic

mov [BOOT_DRIVE], dl  ; The BIOS stores the drive info in DL register
                      ; This will be used to read from disk and load our kernel

KERNEL_OFFSET equ 0x1000         ; Memory position set by ld where kernel is 


mov bp, 0x9000        ; Set up the stack
mov sp, bp

mov si, MSG_RMODE
call print            ; Print info in real mode
call new_line

call load_kernel      ; Load kernel from disk

call switch_to_pm     ; Swtich to protected mode
                      ; NOTE : EXECUTION IS NEVER RETURNED FROM HERE

;mov dx, [0x7c00+512]
;call print_hex
;call new_line

;mov dx, [0x7c00+1024]
;call print_hex
;call new_line

;mov dx, [0x7c00+2048]
;call print_hex
;call new_line

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
	;----------------- ---------------------------------------------------------
	pusha
	mov si,MSG_KLOAD
	call print
	call new_line

	;--------------------------------------------------------------------------
	; Setup registers to call read_disk and read in the kernel
	;--------------------------------------------------------------------------
	mov bx, 0x00
	mov es, bx
	mov bx, 0x7c00 + KERNEL_OFFSET
	mov dh, 1                            ; Number of sectors to read
	mov dl, [BOOT_DRIVE]
	
	;--------------------------------------------------------------------------

	call read_disk
	popa
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
