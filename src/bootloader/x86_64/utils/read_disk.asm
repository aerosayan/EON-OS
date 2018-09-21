;==============================================================================
;                         UTILITY : READ DISK 
;==============================================================================
; info : Reads magnetic floppy(also usb) or hard disks using BIOS INT 13h
; in   : Can set up AL,CH,CL,DH,DL,&  ES:BX  register to allow control
;      : WARNING : Documentation to be updated after refactoring
;      : Where,
;      : AL = Total number of sectors to be read
;      : CH = Cyllinder
;      : CL = Sector to start reading from (1 indexed)
;      : DH = Head
;      : DL = Drive (Generally set by BIOS automatically)
;      : ES:BX = Buffer Adress Pointer
;      : Source : INT_3H service wikipedia 
;------------------------------------------------------------------------------

[bits 16]

; READ_DISK : Read data from disk
read_disk:
	;--------------------------------------------------------------------------
	pusha
	push dx

	mov ah, 0x02                          ; Enable reading from disk
	;--------------------------------------------------------------------------
	; EXAMPLE : How the user should setup the registers to use read_disk
	;--------------------------------------------------------------------------
	;mov dl, 0x80                         ; DL = Drive to read from 
	;                                     ; DL == 0x00 for Floppy Disks
	;                                     ; NOTE : USB are taken as floppy disks
	;                                     ; DL == 0x80 for Hard Disk Drives
	;                                     ; NOTE : QEMU is taken as HDD
	;                                     ; NOTE : DL is set by BIOS itself
	;mov ch, 0x00                         ; CH = Starting cyllinder
	;mov dh, 0x00                         ; DH = Starting head
	;--------------------------------------------------------------------------
	; It is possible to set the AL and CL registers beforehand to allow better
	; control for reading from disks. Thus, AL and CL registers are not set.
	;--------------------------------------------------------------------------
	;mov al, 1                            ; AL = Sectors to read Count
	;mov cl, 2                            ; CL = Sector to start reading from
	;--------------------------------------------------------------------------
	;--------------------------------------------------------------------------
	; Adress buffer pointer : [es:bx] eg. 0x0000:0x7c00+512 = 0x7c00 + 512
	;--------------------------------------------------------------------------
	;push bx
	;mov bx, 0x00
	;mov es, bx
	;pop bx
	;mov bx, 0x7c00 + 512                ; Read from second sector
	;--------------------------------------------------------------------------

	; Prepare data for loading disk
	mov al, dh
	mov ch, 0x00
	mov dh, 0x00
	mov cl, 0x02

	; [es:bx] => it is caller's responsibility to fix es:bx to the position
	; on which 0x13 is to act upon and read in. No assumptions have been made 
	; on the pointer es:bx since, full control is given to user
	int 0x13                             ; Run BIOS interrupt 13h to read
	jc  read_disk_error                  ; Jump if carry is set indicating 
	                                     ; an error in reading from disk

	; compare if the requested number of sectors have been read or not
	pop dx
	cmp dh, al                           ; If sectors_read != sectors_to_read
	jne read_disk_sectors_error          ; then, throw an error
	
	; restore registers and return
	popa
	ret
	;--------------------------------------------------------------------------

; READ_DISK_ERROR : Handle error during disk read
read_disk_error:
	;--------------------------------------------------------------------------
	pusha
	mov dx, 0xE002                       ; ERROR_CODE : read disk error
	call print_hex
	call new_line
	mov dh, ah
	call print_hex
	call new_line
	popa
	jmp $                                ; Infinite loop
	;--------------------------------------------------------------------------
read_disk_sectors_error:
	pusha
	mov dx, 0xE003
	call print_hex
	call new_line
	mov dx, ax
	call print_hex
	call new_line
	popa
	jmp $

;------------------------------------------------------------------------------
; Simple read_disk test to read second sector from the disk
;------------------------------------------------------------------------------
; TEST_READ_DISK
;test_read_disk:
;------------------------------------------------------------------------------
	;mov bx, 0x00
	;mov es, bx
	;mov bx, 0x7c00+512  ; es:bx = 0x0000 : 0x7c00 + 512 = 0x7c00 + 512
	;mov al,1      ; read one sector
	;mov cl,2      ; start reading from the second sector
	;mov ch,0x00   ; cyllinder = 0
	;mov dh,0      ; head = 0
	;;mov dl,0x80   ; drive = set automatically by BIOS

	;call read_disk
	; First sector will be read in correctly
	;mov dx, [0x7c00+512]
	;call print_hex
	;call new_line
;------------------------------------------------------------------------------


