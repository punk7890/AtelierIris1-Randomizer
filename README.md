A basic randomizer for Atelier Iris: Eternal Mana for the PlayStation 2. Currently only includes random music and random enemies with no logic. Pressing R3 when watching an event scene will skip it. This also works in-battle.

# Patching
1. You will need a redump verified dump of the USA version. Non redump dumps have not been checked.
2. xdeltaUI for applying the patch. Grab it at: https://www.romhacking.net/utilities/598/
3. Apply "Randomizer.xdelta" to your ISO.

# Contributing and Testing
You will need the ARMIPS exe to compile your code changes for testing. Grab it here and select the latest automated build: https://github.com/Kingcom/armips

1. Move SLUS_211.13 to the working directiory.
2. Run Compile-log.bat (this also outputs a log file for useful debugging)
3. Copy the bytes from "Randomizer.bin" and paste them at 0x9AF40000 in your ISO.
4. Copy the bytes from "SLUS_211.13" and paste them at 0xFE800 in your ISO.
