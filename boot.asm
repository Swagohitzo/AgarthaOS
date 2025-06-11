; boot.asm — BIOS bootloader
bits 16
org 0x7C00        ; BIOS loads this sector at 0x0000:0x7C00

start:
    mov si, msg           ; Point SI at our message
    call print_string     ; Print it
    jmp $                 ; Hang here forever

print_string:
    mov ah, 0x0E          ; BIOS teletype function
.next_char:
    lodsb                 ; Load byte at [DS:SI] into AL, SI++
    cmp al, 0
    je .done
    int 0x10              ; BIOS interrupt to print AL
    jmp .next_char
.done:
    ret

msg db "Welcome to AgarthaOS!", 0  ; Our message, zero-terminated

times 510-($-$$) db 0       ; Pad the rest of the 512-byte sector with zeros
dw 0xAA55                   ; Boot signature (must be at offset 510–511)