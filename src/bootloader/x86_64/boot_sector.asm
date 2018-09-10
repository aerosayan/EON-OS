;==============================================================================
;                            EON-OS : BOOT_SECTOR
;==============================================================================
;                            EXECUTION STARTS HERE 
;------------------------------------------------------------------------------

[org 0x7c00]          ; Organise the global starting point to 0x7c00
                      ; NOTE: it is important to do pointer arithmentic

mov bp, 0x9000        ; Set up the stack
mov sp, bp

mov si, MSG_RMODE
call print            ; Print info in real mode

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

[bits 32]            ; Start 32-bit protected mode
; BEGIN_PM
BEGIN_PM:            ; Execution is transferred here from switch_to_pm
	mov ebx, MSG_PMODE
	call pm_print    ; Print info in protected mode
	jmp $            ; Infinite loop hang execution

;------------------------------------------------------------------------------
; GLOBAL VARIABLES
;------------------------------------------------------------------------------
MSG_RMODE : db "INF - Started in 16-bit real mode...",0
MSG_PMODE : db "INF - Switched to 32-bit protected mode...",0

;------------------------------------------------------------------------------
; Padding and magic number for boot sector
times 510-($-$$) db 0
dw 0xaa55
;------------------------------------------------------------------------------



