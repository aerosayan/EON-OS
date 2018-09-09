;==============================================================================
;             UTILITY : PRINT HEXADECIMAL NUMBERS IN ASCII FORMAT
;==============================================================================
; info : Prints hexadecimal numbers in ASCII format (currently Little Endian)
; in   : Receiving the hexadecimal number in the DX register
; out  : Print to screen the ASCII form the hexadecimal number
; ex   : If DX = 0x1234 then it is a single number and can't be printed directly
;      : thus, it is required to convert such a hex number to the ascii form
;      : "0x1234" such that the hex number can be printed on to screen
;------------------------------------------------------------------------------

; PRINT_HEX : Print the hexadecimal value to screen in ASCII form
print_hex:
	;--------------------------------------------------------------------------
	pusha                           ; Push every register to stack
	                                ; to prevent accidental overwrite
	mov cx, 0                       ; Intitilaize our count or index 

	;--------------------------------------------------------------------------
	; ALGORITHM : If the current given number is 0x1234 for example, then 
	;           : in order to convert it to the ascii string form, we need
	;           : to modify the given number digit by digit and print them
	;           :
	;           : For example : hex number in range[0,9] can be converted to 
	;           : it's ASCII form by adding 30H. Since the ASCII code for the 
	;           : characters ["0"..."9"] are [30H...39H].
	;           :
	;           : Similarly the hex number in range[A,F] can be converted to 
	;           : it's ASCII form by adding 37H to it. Since, the ASCII for the 
	;           : characters ["A"..."F"] are [41H...46H].
	;           :
	;           : It is to be noted that H in 30H denotes it as a hex number
	;--------------------------------------------------------------------------

	hex_print_loop:                 ; Print each character in the hex number
		cmp cx,4                    ; Loop 4 times to handle 4 digits of hex
		je end                      ; Jump to end when 4 iterations are done

		;----------------------------------------------------------------------
		; Convert the current hex digit to ascii
		;----------------------------------------------------------------------
		mov ax, dx                  ; Use ax as working register
		shr al, 4                   ; Shift right by 4 to put the upper nibble 
		                            ; in lower spot
		add al, 0x30                ; Add 30H to convert hex N to ASCII "N"
		                            ; for N in range [0..9]
		cmp al, 0x39                ; Compare current digit with 0x39
		jle print_hex_char          ; Print the result if [al] < 0x39
		add al, 0x07                   ; Else convert hex N to ascii "N"
		                            ; for N in range [A...F]

	print_hex_char:
		;----------------------------------------------------------------------
		; Print the current hex character which has been converted to ASCII
		;----------------------------------------------------------------------
		mov ah, 0x0e               ; Activate printing to screen
		int 0x10                   ; Print data in al register
		add cx, 1                  ; Increment counter
		rol dx, 4                  ; Rotate left by 4 : TODO : Understand HOW?
		jmp hex_print_loop         ; Jump back to print next character


	end:                           ; End of the function
		mov ah, 0x0e               ; Activate printing to screen
		mov al, 'x'
		int 0x10
		mov al, 'L'
		int 0x10

		popa                       ; Pop everything saved from the stack
		ret                        ; Return to the caller

