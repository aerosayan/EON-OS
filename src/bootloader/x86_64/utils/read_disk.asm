;==============================================================================
;                         UTILITY : READ DISK 
;==============================================================================
; info : Reads magnetic floppy(also usb) or hard disks using BIOS INT 13h
; in   : Can set up AL or CL register to allow control of reading 
;      : Where,
;      : AL = Total number of sectors to be read
;      : CL = Sector to start reading from
; out  : nothing for now...
;------------------------------------------------------------------------------

; READ_DISK : Read data from disk
read_disk:
	pusha
	mov ah, 0x02                          ; Enable reading from disk
	mov dl, 0x80                          ; DL = Drive to read from 
	                                      ; DL == 0x00 for Floppy Disks
	                                      ; NOTE : USB are taken as floppy disks
	                                      ; DL == 0x80 for Hard Disk Drives
	                                      ; NOTE : QEMU is taken as HDD
	mov ch, 0x00                          ; CH = Starting cyllinder
	mov dh, 0x00                          ; DH = Starting head
	;--------------------------------------------------------------------------
	; It is possible to set the AL and CL registers beforehand to allow better
	; control for reading from disks. Thus, AL and CL registers are not set.
	;--------------------------------------------------------------------------
	;mov al, 1                             ; AL = Sectors to read Count
	;mov cl, 2                             ; CL = Sector to start reading from
	;--------------------------------------------------------------------------
	;--------------------------------------------------------------------------
	; Adress buffer pointer setup : TODO: Understand this!
	;--------------------------------------------------------------------------
	push bx
	mov bx, 0x00
	mov es, bx
	pop bx
	mov bx, 0x7c00 + 512                 ; Read from second sector
	                                     ; NOTE : Make it user controlled?
	int 0x13                             ; Run BIOS interrupt 13h to read
	jc  read_disk_error                  ; Jump if carry is set indicating 
	                                     ; an error in reading from disk
	popa
	ret

; READ_DISK_ERROR : Handle error during disk read
read_disk_error:
	mov dx, 0x0100                       ; ERROR_CODE : read disk error
	call print_hex
	call new_line
	jmp $                                ; Infinite loop

