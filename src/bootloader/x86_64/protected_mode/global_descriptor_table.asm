;==============================================================================
;      PROTECTED MODE INITIALIZATION : GLOBAL DESCRIPTOR TABLE DEFINATION
;==============================================================================
; DISCLAIMER : Copied directly from os-dev.pdf since GDT is boiler plate code
;            : The GDT is very difficult to implement, do not take any chance.
;            : Take the boiler plate code and stick it in here.
;------------------------------------------------------------------------------

; GDT_START
gdt_start:
;------------------------------------------------------------------------------

	; GDT_NULL
	gdt_null:                       ; First 8 bytes of the GDT set to 0
	;--------------------------------------------------------------------------
		dd 0x0                      ; (4 bytes)
		dd 0x0                      ; (4 bytes)
	;--------------------------------------------------------------------------

	; GDT_CODE
	gdt_code:                       ; GDT code segment descriptor
	;--------------------------------------------------------------------------
	;  FLAGS    : 
	;--------------------------------------------------------------------------
	; base      = 0x0 
	; limit     = 0xfffff
	;--------------------------------------------------------------------------
	; 1st flag  = 1 (present) 00 (privilage) 1 (type) 
	;           => 1001b
	;--------------------------------------------------------------------------
	; 2nd flag  = 1 (granularity) 1 (32-bit default) 0 (64-bit seg)  0 (AVL) 
	;           => 1100b
	;--------------------------------------------------------------------------
		dw 0xffff
		dw 0x0
		db 0x0
		db 10011010b
		db 11001111b
		db 0x0
	;--------------------------------------------------------------------------

	; GDT_DATA
	gdt_data:                       ; GDT data segment descriptor
	;--------------------------------------------------------------------------
	; Same as gdt_code except for the type flags
	;--------------------------------------------------------------------------
		dw 0xffff
		dw 0x0
		db 0x0
		db 10010010b
		db 11001111b
		db 0x0
	;--------------------------------------------------------------------------

; GDT_END
gdt_end:                            ; Marks the end of the GDT in the memory
;------------------------------------------------------------------------------

; GDT_DESCRIPTOR
gdt_descriptor:                     ; GDT descriptor 
;------------------------------------------------------------------------------
		dw gdt_end - gdt_start - 1
		dd gdt_start

;------------------------------------------------------------------------------
;  CONSTANTS
;------------------------------------------------------------------------------
CODE_SEG equ gdt_code - gdt_start   ; Memory segment denoting the code
DATA_SEG equ gdt_data - gdt_start   ; Memory segment denoting the data

