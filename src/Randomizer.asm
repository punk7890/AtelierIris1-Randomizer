.ps2

;Loaded at 0x01B00000 in memory

.create "RANDOMIZER.bin", 0x01B00000
.area 0x10000, 0xFF		;randomizer size. fill empty space with Fs

Randomizer:
addiu sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
sd s4, 40(sp)
lw v0, gR3SkipFlag
beq v0, r0, @@RestoreSkip
sw r0, 0x00106ED4
b @@RandomMusicCheck
nop

@@RestoreSkip:
li v0, 0x34630004
sw v0, 0x00106ED4
b @@RandomMusicCheck
nop

@@RandomMusicCheck:
lw v0, gRandomMusicFlag
beq v0, r0, @@RestoreMusic
lw a0, gRandomMusicSeek
la v0, gRandomMusicSeek
lw v1, gRandomMusicMax
beql a0, v1, @@RandomEnemiesNoLogicCheck
sw r0, 0x0000(v0)
addiu a0, a0, 1
sw a0, 0x0000(v0)
lw v0, gRandomMusicHook
sw v0, 0x00137064
li v0, 0x0080802D
sw v0, 0x00137068
b @@RandomEnemiesNoLogicCheck
nop

@@RestoreMusic:
li v0, 0x0080802D
sw v0, 0x00137064
li v0, 0x001010C0
sw v0, 0x00137068
b @@RandomEnemiesNoLogicCheck
nop

@@RandomEnemiesNoLogicCheck:
lw v0, gRandomEnemiesNoLogicFlag
beq v0, r0, @@RestoreEnemiesNoLogic
li v0, 0x2405
sh v0, 0x001d00a2
lw v0, gRandomEnemiesNoLogicCounter
addiu v0, v0, 1
li v1, 0x76
beql v0, v1, @@ResetRandomEnemiesNoLogicCounter
daddu v0, r0, r0
@@ResetRandomEnemiesNoLogicCounter:
sh v0, 0x001d00a0
sw v0, gRandomEnemiesNoLogicCounter
b @@ExitRandomizer
nop

@@RestoreEnemiesNoLogic:
li v0, 0x86050000	;lh a1, $0000(s0)
sw v0, 0x001d00a0
b @@ExitRandomizer
nop

@@ExitRandomizer:
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld s4, 40(sp)
jr ra
addiu sp, sp, +48
nop

FUNC_RandomMusic:	;runs from game code if on
lw s0, gRandomMusicSeek
la at, RandomMusicTable
sll s0, s0, 2
addu at, s0, at
lw s0, 0x0000(at)
jr ra
sll      v0, s0, 3
nop

gR3SkipFlag:	;some debug feature for skipping scenes or resetting the map if r3 is pressed
.d32 1

gRandomMusicFlag:
.d32 1

gRandomMusicHook:
jal FUNC_RandomMusic
nop
gRandomMusicSeek:
.d32 0
gRandomMusicMax:
.d32 54
RandomMusicTable:
.d32 0x0
.d32 0x1
.d32 0x2
.d32 0x3
.d32 0x4
.d32 0x5
.d32 0x6
.d32 0x7
.d32 0x9
.d32 0xA
.d32 0xB
.d32 0xD
.d32 0xE
.d32 0xF
.d32 0x10
.d32 0x12
.d32 0x13
.d32 0x14
.d32 0x15
.d32 0x16
.d32 0x17
.d32 0x18
.d32 0x19
.d32 0x1B
.d32 0x1D
.d32 0x1E
.d32 0x1F
.d32 0x20
.d32 0x21
.d32 0x22
.d32 0x24
.d32 0x26
.d32 0x35
.d32 0x37
.d32 0x38
.d32 0x3A
.d32 0x3D
.d32 0x3E
.d32 0x3F
.d32 0x40
.d32 0x41
.d32 0x42
.d32 0x43
.d32 0x48
.d32 0x49
.d32 0x4A
.d32 0x4B
.d32 0x4C
.d32 0x4D
.d32 0x4E
.d32 0x4F
.d32 0x50
.d32 0x51
.d32 0x5B
.d32 0x5E
.d32 -1

gRandomEnemiesNoLogicFlag:
.d32 1
gRandomEnemiesNoLogicCounter:
.d32 0
gRandomEnemiesFlag:
.d32 0
gEnemyTableEasy:	;0x76 seems to be last valid enemy
.d32 0x0 ;Puni
.d32 0x1 ;Mini-Puni
.d32 0x3 ;Ice Puni
.d32 0x4 ;Red Puni
.d32 0x8 ;Mountain Pig
.d32 0x9 ;Baby Pig
.d32 0xC ;Wolf
.d32 0x10 ;Falcon Hawk
gEnemyTableMed:
.d32 0x5 ;Golden Puni
.d32 0x6 ;Faux Puni
.d32 0x7 ;Invisible Puni
.d32 0xB ;Invisible Pig
.d32 0xE ;Wolf Leader
.d32 0x11 ;Vulture
gEnemyTableHard:
.d32 0x2 ;Giant Puni
.d32 0xA ;Sr. Mountain Pig
.d32 0xD ;Cerberus
.d32 0xF ;Supreme Wolf

.endarea
.close