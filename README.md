# D3

This project is a source port of [Fantasy World Dizzy](https://en.wikipedia.org/wiki/Fantasy_World_Dizzy) from the [ZX Spectrum](https://en.wikipedia.org/wiki/ZX_Spectrum) / [Amstrad CPC](https://en.wikipedia.org/wiki/Amstrad_CPC) computers [z80](https://en.wikipedia.org/wiki/Zilog_Z80) codebase to the [BBC Micro](https://en.wikipedia.org/wiki/BBC_Micro) in [6502](https://en.wikipedia.org/wiki/MOS_Technology_6502) assembler.

The game was the third in the Dizzy series and was released on many platforms back in 1989, but never the BBC Micro. The only release for the 6502 CPU was on the [Commodore 64](https://en.wikipedia.org/wiki/Commodore_64). Unfortunately the stock BBC Micro lacked the required RAM to fit all the levels, sprites, music, text and game logic.

I've included playback of the original speech sample (Digitized on a C64 by G.Raeburn) and the Dizzy 2 painting closeup. The PCM playback used ideas and portions of code from [here](https://scarybeastsecurity.blogspot.com/2020/06/sampled-sound-1980s-style-from-sn76489.html) and [here](https://github.com/scarybeasts/misc).

NOTE : This project requires at least 2 x 16k banks of sideways RAM to be available. So it will work on a [BBC Master](https://en.wikipedia.org/wiki/BBC_Master) or a standard BBC Micro with added sideways RAM.

# Building

Development of this project has been done with Linux and as such the build scripts and environment are tailored to it. A Visual Studio Code project is included.

The build script, named "make.sh" can run either from the command line or from within [Visual Studio Code](https://code.visualstudio.com/). It will attempt to build anything which it thinks has changed.

img2beeb is a short C program to convert images to a Beeb friendly format. This uses the [DevIL](https://openil.sourceforge.net/) image library. I use it to convert the loader screen (XSCR) and Dizzy 2 screen (TREPIC) from png with associated palette files.

exomizer is a utility to compress data, I mainly use it to make things load faster. This is available from [Exomizer](https://bitbucket.org/magli143/exomizer/wiki/Home) website. Currently I've only used it on the loading screen.

SPEECH is a standalone BBC Micro machine code program to play back the original PCM speech sample, this is run from the BASIC loader.

MELODY is also a standalone BBC Micro machine code program to play back the loader music as used on the [Atari ST](https://en.wikipedia.org/wiki/Atari_ST) version, this will be played from the BASIC loader too.

RMDATA is the room data which is compiled from all the binary representation of the rooms, with offsets to each room being generated as RMTABLE. I originally paged this data in from disc on a room-by-room basis and so have included some of the text which only appears in that room, but using SWRAM negates the need for this. I've also created a "strings" room, which only contains static text just to move it out of the main source code. This is stored in the first SWRAM slot found.

XDATA is an extra blob of static data, including the frames used to make up a level and the Dizzy sprites. I may add the Dizzy sprite mask data back in which I previously removed to save space. This is stored in the second SWRAM slot found.

The BASIC loader uses a bit of embedded machine code to search for SWRAM. To create this I first tokenise the BASIC to binary (loadertok.bin) then append the machine code, which is hidden by the BASIC EOF token. Although I need to leave some blank space between them for BASIC variable use.

I use the excellent [beebasm](https://github.com/stardot/beebasm) assembler to build all the components of the project and to generate a .SSD disc image file.

# Running on real hardware

On my childhood BBC Micro model B, I've installed a [solderless 32k RAM+ROM upgrade kit](http://www.boobip.com/hardware/32kb-ram-32kb-rom).

Then I've used a Gotek device powered by the BBC Micro auxillary power port to load the software via the floppy disc interface.

Currently I'm detecting the SWRAM by cycling through the slots with ROMSEL to test writeability, although I'm aware that not all legacy SWRAM solutions supported this method. So at some point in the future I'll extend the SWRAM code to support more hardware.

# Running in an emulator

I have tested the code on several emulators.

Using [b2](https://github.com/tom-seddon/b2) - single SWRAM (13) by default, either enable another or use BBC B + 128k / BBC Master config.

Using [beebjit](https://github.com/scarybeasts/beebjit) - default BBC Micro config has no SWRAM by default. Specify with e.g. -swram 0 and -swram 1 or use Master 128 config.

Using [BeebEm](https://en.wikipedia.org/wiki/BeebEm) - default BBC Micro config has 4 x SWRAM slots 4-7 enabled. BBC B + has 3 x SWRAM slots 0-1 and 12, and both BBC B + Integra-B and BBC Master 128 have 4 x SWRAM slots 4-7.

Using [jsbeeb](https://bbc.godbolt.org/) - default BBC Micro config has 8 x SWRAM slots 0-7 enabled.

# Test

As part of the development, I made use of Javascript to rapidly prototype some of the routines for decoding and displaying the data.

[Online level viewer and tester](https://picosonic.github.io/D3/)

# Credits

Original source/assets copyright to respective owner(s).

Original source code is available here :

[Wireframe Magazine issue 19](https://github.com/Wireframe-Magazine/Wireframe19)
