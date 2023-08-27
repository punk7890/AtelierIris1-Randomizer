.ps2


.open "SLUS_211.13", 0x00000000	;open elf file for writing



.org 0x002dcdd0 + ENTRY_OFFSET - ENTRY_VIRTUAL_ADDRESS	

j scePrintf		;call scePrintf instead of printF

.org 0x00c4f0d0 + ENTRY_OFFSET - ENTRY_VIRTUAL_ADDRESS

.d32 1	;enable SCE_CD_debug logging to printF




.org 0x0013B4F4 + ENTRY_OFFSET - ENTRY_VIRTUAL_ADDRESS

j Randomizer	;call randomizer

.org 0x29F74C + ENTRY_OFFSET - ENTRY_VIRTUAL_ADDRESS

j @LoadRandomizer - ENTRY_OFFSET + ENTRY_VIRTUAL_ADDRESS	;create call to load randomizer from disc

.org 0x2DE270 + ENTRY_OFFSET - ENTRY_VIRTUAL_ADDRESS




@LoadRandomizer:	;function runs once at boot
addiu sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
sd s4, 40(sp)
li a0, 0
li a1, 0x135E80	;sector start (9AF40000)
li a2, 0x20	;size in sectors. Size of file is 0x10000
jal 0x00101B90 ;load file from disc
lui a3, 0x01B0	;load to memory location 0x01B00000
li a0, @LoadRandomizerText - ENTRY_OFFSET + ENTRY_VIRTUAL_ADDRESS
jal scePrintf
nop
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld s4, 40(sp)
jr ra
addiu sp, sp, +48

@LoadRandomizerText:
.asciiz "Loaded RANDOMIZER.BIN\n"
;.align 4,0






.close

