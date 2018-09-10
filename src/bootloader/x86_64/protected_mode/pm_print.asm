;==============================================================================
;                       PROTECTED MODE : PRINT 
;==============================================================================
; info : Print directly to the VGA address of the screen in text mode
; in   : Zero terminated string is input using the EBX register, 
; out  : Print to the VGA address of the screeen
;
; NOTE : Unfortunately, right now, it can only print to the top left corner
;      : of the screen and needs to be fixed later on using C language.
;      : This, method is meant to be initially used as a testing framework 
;      : to validate the starting up of the protected mode.
;------------------------------------------------------------------------------

[bits 32]                               ; 32 bit protected mode

;------------------------------------------------------------------------------
; CONSTANTS
;------------------------------------------------------------------------------
VGA equ 0xb8000                         ; Video memory address
WHITE_BLACK equ 0x0f                    ; White text on black screen

;------------------------------------------------------------------------------
; PM_PRINT : Print text in protected mode
pm_print:
;------------------------------------------------------------------------------
	pusha 
	mov edx, VGA                        ; Assign video memory address to EDX

	pm_print_string_loop:
		mov al, [ebx]                   ; Set the current character to print
		mov ah, WHITE_BLACK             ; Set the color for printing the text

		cmp al, 0                       ; Check if null termination of string 
		je pm_print_end                 ; If 0 encountered then exit

		;----------------------------------------------------------------------
		; PRINT TO SCREEEN
		;----------------------------------------------------------------------
		mov [edx], ax
		;----------------------------------------------------------------------

		add ebx, 1                      ; Set ebx pointer to next char to print
		add edx, 2                      ; Next video memory postion to print to
		                                ; NOTE : EDX is incremented by 2 
		                                ; since text and color info requires it
		jmp pm_print_string_loop        ; Print next character
;------------------------------------------------------------------------------

; PM_PRINT_END
pm_print_end:                           ; Exit the function
;------------------------------------------------------------------------------
	popa
	ret
;------------------------------------------------------------------------------

