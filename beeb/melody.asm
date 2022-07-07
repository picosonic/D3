; OS defines
INCLUDE "os.asm"

; Variable and constant defines
INCLUDE "consts.asm"

; Zero page vars
ORG &50

; Keypress bitfield
.keys
 EQUB &00

; Number of frames, wraps around
.framecounter
  EQUB &00

; Temporary APU storage
.sound_temp
  EQUB &00

; Current melody (top bit set if already initialised)
.sound_music
  EQUB &00

.sound_note_timeout
  EQUB &00, &00, &00

.sound_notelen
  EQUB &00, &00, &00

; Current channel
.sound_chan
  EQUB &00

; Pointer
.sound_ptr
  EQUW &0000

; Progress through each channel of current melody (low)
.sound_cnt
  EQUB &00, &00, &00
; Progress through each channel of current melody (high)
.sound_page
  EQUB &00, &00, &00

; Sound sustain per channel
.sound_pause_point
  EQUB &00, &00, &00
.sound_pause_counter
  EQUB &00, &00, &00

ORG EXO_LOAD_ADDR

; Drum "snare" sound
;
; ENVELOPE 4,1,0,0,0,0,0,0,126,-1,0,-9,126,62
; SOUND&10,4,4,2

; Program entry point
.start
{
  ; Make sure we are not in decimal mode
  CLD

  ; Define ENVELOPE
  LDA #&08
  LDX #envelope1 MOD 256
  LDY #envelope1 DIV 256
  JSR OSWORD

  LDA #&08
  LDX #envelope2 MOD 256
  LDY #envelope2 DIV 256
  JSR OSWORD

   ; Set up vsync event handler
  LDA #&00:STA framecounter

  SEI
  LDA #sound_eventvhandler MOD 256:STA EVNTV
  LDA #sound_eventvhandler DIV 256:STA EVNTV+1
  CLI

  ; Enable vsync event handler
  LDA #&0E:LDX #&04:JSR OSBYTE

  ; Start playing music
  LDA #&01:STA sound_music

  ; Wait until music finished
.sound_waittune
  LDA #INKEY_SPACE:JSR scankey:BNE done ; If space pressed, end tune
  LDA sound_music:BNE sound_waittune ; Keep going until tune finished

.done
  ; Disable vsync event handler
  LDA #&0D:LDX #&04:JSR OSBYTE

  RTS
}

.sound_explosion
{
  PHA:TXA:PHA:TYA:PHA

  ; Set pointer to sound params in XY
  LDX #effectparams MOD 256
  LDY #effectparams DIV 256

  ; Action OS sound function
  LDA #&07:JSR OSWORD

  PLA:TAY:PLA:TAX:PLA

  RTS

  ; Sound parameter block
.effectparams
  EQUB &10 ; Channel LSB (noise channel 0, with flush)
  EQUB &00 ; Channel MSB
  EQUB &F7 ; Amplitude LSB
  EQUB &FF ; Amplitude MSB
  EQUB &06 ; Pitch LSB (low frequency white noise)
  EQUB &00 ; Pitch MSB
  EQUB &0C ; Duration LSB
  EQUB &00 ; Duration MSB
}

; Stop playing melody
.sound_stop
{
  LDA #&00:STA sound_music

  RTS
}

; Handler for VBLANK event
.eventhandler
{
  ; Save registers
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  ; Check if this is a VSYNC event
  CMP #4:BNE done

  INC framecounter

  JSR read_input
  JSR sound_eventvhandler

.done

  ; Restore registers
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP

  RTS
}

.sound_eventvhandler
{
  ; Do nothing if no melody is playing
  LDA sound_music:BEQ done

  ; Check for init already done
  BMI update_melody

  ; Flag current melody as initialised
  ORA #&80:STA sound_music  

  ; Init sound parameters
  LDA #&00
  STA sound_cnt:STA sound_cnt+1:STA sound_cnt+2
  STA sound_page:STA sound_page+1:STA sound_page+2

  LDA #&01
  STA sound_note_timeout:STA sound_note_timeout+1:STA sound_note_timeout+2
  STA sound_notelen:STA sound_notelen+1:STA sound_notelen+2

.update_melody
  ; Start at 3rd channel, then work backwards
  LDA #&02:STA sound_chan

  ; Play something for this channel
.next_channel
  LDX sound_chan
  DEC sound_note_timeout, X
  BEQ play_channel

  ; Move on to next channel for this melody
.advance_channel
  DEC sound_chan
  BPL next_channel

  RTS

.play_channel
  ; Load the pointer for the current channel
  TXA:ASL A:TAX
  LDA sound_chandat, X:STA sound_ptr
  LDA sound_chandat+1, X:CLC:ADC sound_page, X:STA sound_ptr+1

  ; Check for a null pointer (if so then move on to next channel)
  ORA sound_ptr:BEQ advance_channel

  JSR sound_write_regs
  JMP advance_channel

.done

  RTS
}

.sound_write_regs
{
  ; Get channel pointer
  LDX sound_chan
  LDY sound_cnt, X

  ; Read and cache next byte of channel data
  LDA (sound_ptr), Y:STA sound_temp

  ; Move channel pointer onwards
  INC sound_cnt, X
  BNE samepage
  INC sound_page, X
.samepage

  ; Check for control byte
  LDA sound_temp:BMI control_byte

  ; Set current note timeout from current channel note length 
  LDA sound_notelen, X
  STA sound_note_timeout, X

  ; Skip zeroes (rests)
  LDA sound_temp:BEQ abort_write

  ; Set sound channel (with flush enabled)
  TXA:ORA #&10:STA soundparams:INC soundparams

  LDA sound_temp
  ; Convert to BBC Micro note range
  ;CMP #&10:BCS inrange
  ;LDA #&10
;.inrange
  ;SEC:SBC #&0F
  ASL A;:ASL A

  JSR sound_play_note

.abort_write
  RTS

.control_byte
  ; Test to see if it's an "effect"
  AND #&F0:CMP #&F0:BEQ exec_effect

  ; Timing control
  LDA sound_temp:AND #&7F

  STA sound_notelen, X
  JMP sound_write_regs

.exec_effect
  ; Determine which effect to action
  SEC:LDA #&FF:SBC sound_temp

  ; Use a case statement
  ASL A:TAY
  LDA effect_offsets+1, Y:PHA
  LDA effect_offsets, Y:PHA
  RTS

.effect_offsets
  EQUW effect_1-1
  EQUW effect_2-1
  EQUW effect_3-1
  EQUW effect_4-1
  EQUW effect_5-1
}

; FF
; Stop current playing melody
.effect_1
{
  LDA #&00:STA sound_music

  RTS
}

; FE
; Loop this channel back to the start
.effect_2
{
  LDA #&00:STA sound_cnt, X:STA sound_page, X

  JMP sound_write_regs
}

; FD
; Set up pause/sustain for this channel (counter is next byte)
.effect_3
{
  LDY sound_cnt, X
  LDA (sound_ptr), Y
  STA sound_pause_counter, X
  INY
  BNE samepage
  INC sound_page, X
.samepage
  STY sound_cnt, X
  STY sound_pause_point, X

  JMP sound_write_regs
}

; FC
; Action a pause/sustain for this channel
.effect_4
{
  DEC sound_pause_counter, X
  BEQ done

  LDA sound_pause_point, X
  STA sound_cnt, X

.done
  JMP sound_write_regs
}

; FB
; Set note length/note timeout for this channel (value is next byte)
.effect_5
{
  LDY sound_cnt, X
  LDA (sound_ptr), Y
  STA sound_notelen, X:STA sound_note_timeout, X
  INY
  BNE samepage
  INC sound_page, X
.samepage
  STY sound_cnt, X

  JMP sound_write_regs
}

.sound_play_note
{
  ; Set pitch LSB
  STA soundparams+4

  ; Set all MSB to zero
  LDA #&00
  STA soundparams+1
  STA soundparams+3
  STA soundparams+5
  STA soundparams+7

  ; Use envelope 1 for amplitude
  LDA #&01
  STA soundparams+2
  ;LDA #&F1:STA soundparams+2
  ;LDA #&FF:STA soundparams+3
  ; Set duration of 1
  LDA #&01
  STA soundparams+6

  ; Set pointer to sound params in XY
  LDX #soundparams MOD 256
  LDY #soundparams DIV 256

  ; Action OS sound function
  LDA #&07:JSR OSWORD

  ; Go to next sound channel
  INC soundparams

.done
  RTS
}

INCLUDE "internal.asm"
INCLUDE "inkey.asm"
INCLUDE "input.asm"

; Current melody channel data (3 x pointers to each channel)
.sound_chandat
  ;EQUW &0000, &0000, melody_02_c2
  EQUW &0000, melody_02_c1, melody_02_c2

; Sound parameter block
.soundparams
  EQUB &00 ; Channel LSB
  EQUB &00 ; Channel MSB
  EQUB &00 ; Amplitude LSB
  EQUB &00 ; Amplitude MSB
  EQUB &00 ; Pitch LSB
  EQUB &00 ; Pitch MSB
  EQUB &00 ; Duration LSB
  EQUB &00 ; Duration MSB

.envelope1
  ; "Marimba"
  EQUB 1   ; Envelope number
  EQUB 2   ; Length of each step (hundredths of a second) and auto repeat (top bit)
  EQUB 0   ; Change of pitch per step in section 1
  EQUB 0   ; Change of pitch per step in section 2
  EQUB 0   ; Change of pitch per step in section 3
  EQUB 0   ; Number of steps in section 1
  EQUB 0   ; Number of steps in section 2
  EQUB 0   ; Number of steps in section 3
  EQUB 60  ; Change of amplitude per step during attack phase
  EQUB -4  ; Change of amplitude per step during decay phase
  EQUB -4  ; Change of amplitude per step during sustain phase
  EQUB -4  ; Change of amplitude per step during release phase
  EQUB 60  ; Target level at end of attack phase
  EQUB 30  ; Target level at end of decay phase

.envelope2
  ; "Snare drum"
  EQUB 2   ; Envelope number
  EQUB 1   ; Length of each step (hundredths of a second) and auto repeat (top bit)
  EQUB 0   ; Change of pitch per step in section 1
  EQUB 0   ; Change of pitch per step in section 2
  EQUB 0   ; Change of pitch per step in section 3
  EQUB 0   ; Number of steps in section 1
  EQUB 0   ; Number of steps in section 2
  EQUB 0   ; Number of steps in section 3
  EQUB 126 ; Change of amplitude per step during attack phase
  EQUB -1  ; Change of amplitude per step during decay phase
  EQUB 0   ; Change of amplitude per step during sustain phase
  EQUB -9  ; Change of amplitude per step during release phase
  EQUB 126 ; Target level at end of attack phase
  EQUB 62  ; Target level at end of decay phase

; Title
.melody_02_c1
INCBIN "M02C1.bin"
.melody_02_c2
INCBIN "M02C2.bin"

.end

SAVE "MELODY", start, end