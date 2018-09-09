;==============================================================================
;                            UTILITY : PRINT 
;==============================================================================
; info  : Print a string in REAL MODE using BIOS interrupt 10h
; in    : String pointer stored in the register SI
; out   : Print the 0 terminated string to the screen
;------------------------------------------------------------------------------

; PRINT : print a string
print:
;------------------------------------------------------------------------------
	pusha   ; Push everything to stack to prevent accidental rewrite
	str_loop:
		mov al, [si] ; Move data in si into al register
		cmp al, 0    ; Compare to tell if value stored in al is 0 or not
		jne print_char ; If value stored in si is not 0 then jump to print_char
		popa         ; Else pop everything from the stack
		ret          ; Return control to calling location
;------------------------------------------------------------------------------

; PRINT_CHAR : print a single character
print_char:
;------------------------------------------------------------------------------
	mov ah, 0x0e  ; Move cursor to left
	int 0x10      ; Print the value stored in al
	add si, 1     ; Increment the pointer si by 1 to get next character 
	jmp str_loop ; Jump back to str_loop
;------------------------------------------------------------------------------

; NEW_LINE : print a new line and carriage return
new_line:
;------------------------------------------------------------------------------
	mov ah, 0x0e
	mov al, 0x0a
	int 0x10
	mov al, 0x0d
	int 0x10
	ret
;------------------------------------------------------------------------------


