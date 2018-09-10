;==============================================================================
;                       PROTECTED MODE : SWITCH
;==============================================================================
; info : Switch from 16-bit real mode to 32-bit protected mode
;------------------------------------------------------------------------------ 

[bits 16]                                  ; Called in 16-bit real mode
; SWTICH_TO_PM
switch_to_pm:                              ; Switch to protected mode
;------------------------------------------------------------------------------
	cli                                    ; Step 1 : Disable all interrupts
	lgdt [gdt_descriptor]                  ; Step 2 : Load GDT descriptor
	mov eax, cr0                           ; CR0 can't be directly changed
	or  eax, 0x1                           ; Step 3 : Set 32-mode-bit in CR0
	mov cr0, eax                           ;        : Set the CR0 register

	;--------------------------------------------------------------------------
	; NOTE : The CPU architechture may be using pipelining to perform multiple
	;      : instructions in parrallel. That is a problem for us.
	; 
	;      : We are switching over to 32-bit protected mode, to allow using 32
	;      : bit registers. However, due to CPU pipelining, we may prematurely
	;      : switch over to 32-bit mode while using 16-bit mode tasks.
	;      : And that unfortunately will cause a crash.
	;      
	;      : Thus, it is important to finish all of the unfinished 16-bit tasks.
	;      
	;      : Thus, we execute a far jump in Step 4.
	;      : This will update the CS register and flush the pipeline and 
	;      : finally take us to 32-bit protected mode segment.
	;--------------------------------------------------------------------------
	jmp CODE_SEG:init_pm                   ; Step 4 : Jump to CODE_SEG defined
	                                       ; in global_descriptor_table.asm 
	                                       ; and execute init_pm in 32-bits

;------------------------------------------------------------------------------

[bits 32]                                  ; Called in 32-bit protected mode
; INIT_PM
init_pm:
;------------------------------------------------------------------------------
	;--------------------------------------------------------------------------
	; NOTE : Now, we are in protected mode.
	;      : First and foremost, we need to update all the registers that may
	;      : possibly be pointing to our now invalid 16-bit real mode segments.
	;--------------------------------------------------------------------------
	mov ax, DATA_SEG                       ; Step 5 : Update the data segment
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000                       ; Step 6 : Update the stack position
	mov esp, ebp                           ; to point to the absolute top of our
	                                       ; free space.
	call BEGIN_PM                          ; Start executing our 32-bit mode



	

