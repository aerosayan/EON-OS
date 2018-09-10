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
call new_line
;------------------------------------------------------------------------------
; TMEPORARY TEST
;------------------------------------------------------------------------------
; read_disk test for loading kernel in future
mov bx, 0x00
mov es, bx
mov bx, 0x7c00+512  ; es:bx = 0x0000 : 0x7c00 + 512 = 0x7c00 + 512
mov al,1      ; read one sector
mov cl,2      ; read the second sector
mov ch,0x00   ; cyllinder = 0
mov dh,0      ; head = 0
;mov dl,0x80   ; drive = set automatically by BIOS

call read_disk
; First sector will be read in correctly
mov dx, [0x7c00+512]
call print_hex
call new_line

; Since AL was set to 1, the second sector will not be read in correctly
mov dx, [0x7c00+1024]
call print_hex
call new_line
;------------------------------------------------------------------------------

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
times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes
