; Processor port

CPU_DDR = &00

CPU_CONFIG = &01
LORAM_A000_RAM    = %00000000
LORAM_A000_ROM    = %00000001 ; BASIC
HIRAM_E000_RAM    = %00000000
HIRAM_E000_ROM    = %00000010 ; KERNAL
CHAREN_ROM        = %00000000
CHAREN_IO         = %00000100
CASSETTE_SWITCH   = %00010000
CASSETTE_OFF      = %00100000

; VIC-II = &D000 .. &D3FF

SPR_MSB_X = &D010
GFX_VICII_REG1 = &D011
GFX_RASTER_LINE = &D012
SPR_ENABLE = &D015
GFX_VICII_REG2 = &D016
SPR_Y_EXP = &D017
GFX_MEM_PTR = &D018
SPR_PRIORITY = &D01B
SPR_MULTICOLOUR = &D01C
SPR_X_EXP = &D01D
SPR_COLLISION = &D01E ; Sprite-sprite collision
SPR_COLLISION2 = &D01F ; Sprite-data collision
GFX_BORDER_COLOUR = &D020
SPR_MULTICOLOUR_01 = &D025
SPR_MULTICOLOUR_11 = &D026
SPR_0_COLOUR = &D027

; SID (audio) = &D400 .. &D7FF
SID_CH1_FREQ_L  = &D400 ; LLLLLLLL
SID_CH1_FREQ_H  = &D401 ; HHHHHHHH
SID_CH1_PULSE_L = &D402 ; LLLLLLLL
SID_CH1_PULSE_H = &D403 ; ----HHHH
SID_CH1_CTRL    = &D404 ; NPST-RSG Noise / Pulse / Saw / Tri / Ring / Sync / Gate
SID_CH1_ATDK    = &D405 ; AAAADDDD Attack / Decay
SID_CH1_SURL    = &D406 ; SSSSRRRR Sustain / Release

SID_CH2_FREQ_L  = &D407 ; LLLLLLLL
SID_CH2_FREQ_H  = &D408 ; HHHHHHHH
SID_CH2_PULSE_L = &D409 ; LLLLLLLL
SID_CH2_PULSE_H = &D40A ; ----HHHH
SID_CH2_CTRL    = &D40B ; NPST-RSG Noise / Pulse / Saw / Tri / Ring / Sync / Gate
SID_CH2_ATDK    = &D40C ; AAAADDDD Attack / Decay
SID_CH2_SURL    = &D40D ; SSSSRRRR Sustain / Release

SID_CH3_FREQ_L  = &D40E ; LLLLLLLL
SID_CH3_FREQ_H  = &D40F ; HHHHHHHH
SID_CH3_PULSE_L = &D410 ; LLLLLLLL
SID_CH3_PULSE_H = &D411 ; ----HHHH
SID_CH3_CTRL    = &D412 ; NPST-RSG Noise / Pulse / Saw / Tri / Ring / Sync / Gate
SID_CH3_ATDK    = &D413 ; AAAADDDD Attack / Decay
SID_CH3_SURL    = &D414 ; SSSSRRRR Sustain / Release

SID_FLT_CUT_L   = &D415 ; -----LLL
SID_FLT_CUT_H   = &D416 ; -----LLL
SID_FLT_CTRL    = &D417 ; RRRREVVV Resonance / External / Voice (3-1)
SID_VOL_FLT     = &D418 ; MHBLVVVV Mute / Highpass / Bandpass / Lowpass / Volume

SID_CH3_WAV     = &D41B ; DDDDDDDD Waveform output (RO)
SID_CH3_ADSR    = &D41C ; DDDDDDDD ADSR output (RO)

CIA1_PRA = &DC00
CIA2_PRA = &DD00

; OS related

KEY_PRESSED = &C5

KEY_INSTDEL = &00
KEY_RETURN  = &01
KEY_CRSRLR  = &02 ; Cursor left / right
KEY_F7F8    = &03
KEY_F1F2    = &04
KEY_F3F4    = &05
KEY_F5F6    = &06
KEY_CRSRUD  = &07 ; Cursor up / down
KEY_3       = &08
KEY_W       = &09
KEY_A       = &0A
KEY_4       = &0B
KEY_Z       = &0C
KEY_S       = &0D
KEY_E       = &0E
KEY_UNUSED1 = &0F ; [Internal - Left Shift or Shift Lock]

KEY_5       = &10
KEY_R       = &11
KEY_D       = &12
KEY_6       = &13
KEY_C       = &14
KEY_F       = &15
KEY_T       = &16
KEY_X       = &17
KEY_7       = &18
KEY_Y       = &19
KEY_G       = &1A
KEY_8       = &1B
KEY_B       = &1C
KEY_H       = &1D
KEY_U       = &1E
KEY_V       = &1F

KEY_9       = &20
KEY_I       = &21
KEY_J       = &22
KEY_0       = &23
KEY_M       = &24
KEY_K       = &25
KEY_O       = &26
KEY_N       = &27
KEY_PLUS    = &28
KEY_P       = &29
KEY_L       = &2A
KEY_MINUS   = &2B
KEY_GREATER = &2C ; Greater than >
KEY_LSQBR   = &2D ; Left square bracket
KEY_AT      = &2E ; @
KEY_LESS    = &2F ; Less than <

KEY_POUND   = &30 ; Pound sign
KEY_STAR    = &31
KEY_RSQBR   = &32 ; Right square bracket
KEY_CLRHOME = &33 ; Clear / Home
KEY_UNUSED2 = &34 ; [Internal - Right Shift]
KEY_EQUALS  = &35
KEY_UPARROW = &36 ; Up arrow
KEY_QUERY   = &37 ; Question mark ?
KEY_1       = &38
KEY_LARROW  = &39 ; Left arrow
KEY_UNUSED3 = &3A ; [Internal - Ctrl]
KEY_2       = &3B
KEY_SPACE   = &3C
KEY_UNUSED4 = &3D ; [Internal - Commodore logo]
KEY_Q       = &3E
KEY_RUNSTOP = &3F ; Run / Stop

KEY_NONE    = &40 ; No key pressed

KEY_SHIFT   = &028D ; Shift key indicator

ISR = &0314
KERNAL_ISR = &EA31
