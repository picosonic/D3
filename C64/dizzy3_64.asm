INCLUDE "consts.asm"
INCLUDE "sprites.asm"
INCLUDE "hardware.asm"

ORG &00

.c64start

; Variables
.v0005 ; pointer to current character of string
.v0006

.v0035 ; pointer to string memory (5A77 / 5A4D / 5A5D / 581C / 5AF0)
.v0036

.v00A7 ; pointer (148D / 14EB / 1502 / 1397 / 14F2 / 14FE)
.v00A8

.v00A9 ; pointer (149F / 130F) - melody pointer
.v00AA

.v00B0 ; pointer (8EB7 / 81B0 / 8678 / 8177 / 8FD8) - ROOMDATA
.v00B1

.v00B2 ; pointer (5B48 / 81B0 / 5B20 / 8177 / 8FD8 / 5B48) - ROOMDATA + ?OTHER?
.v00B3

.v00B4 ; pointer (BA83 / A779 / BA81) - FRAMEDATA
.v00B5

.v00FB ; pointer (73BE / 726E / 60E4 / 7787 / 72ED) - SCREEN RAM
.v00FC

.v00FD ; pointer (5E77 / 5E4D / 5C1C / 5EF0 / 5E5D)
.v00FE

.v00FF

.v033A ; X position
.v033B ; Y position
; Vars in datasette buffer
.v033C ; attrib
.v033D
.v033E
.v033F
.v0340 ; frame
.v0342
.v0344
.v0345 ; cache for X reg
.v0346
.v0347
.v0349
.v034A
.v034B
.v034E
dizzyx = &0352
.v0354
.v0355
.v0356
.v0357
dizzyy = &035C
.v035E
.v035F
.v0360
.v0361
.v0366 ; []
.v0368
.v0369
.v036A
.v036B
.v0370 ; []
.v037A ; [] related to dizzyy
.v0384 ; [] related to dizzyx
.v0398
.v0399
.v039A
cursorx = &039B ; char cursor X
cursory = &039C ; char cursor Y
.v03B7
.v03B8 ; roomno related ?
lives = &03B9
.v03BA
.v03BB
.v03BC
.v03BD
.v03BE
.v03BF ; char attrib
player_input = &03C0
.v03C1
.v03C2
.v03C3
.v03C4
.v03C5
.v03C6
.v03C7
.v03C8
.v03C9
.v03D5 ; set to &FF and &00
olddizzyx = &03D6
olddizzyy = &03D7
.v03D8
.v03D9 ; ID of object being interacted with ?
.v03DA
.v03DB
.v03DC
.v03DD ; max object id to draw
.v03DF
.v03E0
.v03E1
.v03E2
.v03E3
roomno = &03E5

ORG &0B00

; Current music playing
.melody
  EQUB TUNE_CONT

.musicplayer
{
  ; Check if any music is playing
  LDA melody
  BNE l0B0F

  ; Melody is 0
  STA &116D
  JSR l0F78
.l0B0C
  JMP continueplaying

  ; Something is playing
.l0B0F
  ; Is it > last tune id (i.e. is it invalid)
  CMP #TUNE_4+1
  BCS l0B50

  ; Calculate melody id * 6, place in Y
  SBC #&00 ; Carry is clear so make melody id 0-based
  ASL A     ; * 2
  STA mult+1 ; store * 2 value
  ASL A
.mult
  ADC #&00 ; gets replaced
  TAY

  ; Copy 6 interlaced bytes for new melody to current melody
  LDX #&00
.loop
  LDA melodyconfigs,Y:STA v11BC,X ; lo
  INY

  LDA melodyconfigs,Y:STA v11BF,X ; hi
  INY

  INX
  CPX #&03
  BNE loop

  LDX #&02
.l0B34
  LDA #&00
  STA &1188,X
  STA &118B,X
  STA v1170,X ; Set melody channel data pos to start

  JSR l0FC3

  DEX
  BPL l0B34

  JSR l1147

  LDA #&01:STA &116D
  JMP continueplaying

  ; Invalid or continue playing
.l0B50
  LDA &116D
  BEQ l0B0C

  INC &11C9
  INC &11CA
  INC &11CB

  LDX #&02:STX &116C

.^l0B63
  LDX &116C
  LDA &1158,X:STA &11CC
  LDA &116F
  BNE l0B84

  DEC &1188,X
  BMI l0B98

  LDA &119D,X
  BEQ done

  INC &1169,X
  JSR l0F83
  JMP l0EEC

.l0B84
  LDA &11A0,X
  BEQ done

  DEC &11A0,X
  DEC &1169,X

  JSR l0F83
  JMP l0EEC

.done
  JMP l0CDD
}

.l0B98
{
  LDA #&00
  LDY &118B,X
  CPY #&02
  BEQ l0BA7

  STA &118E,X
  STA &118B,X
.l0BA7
  STA &11C2
  STA &1194,X
  STA &119D,X

  LDA #&03:STA &11C6,X
  LDA &117F,X:STA &A7
  LDA &1182,X:STA &A8
.l0BBF
  LDY &11C2
  INC &11C2
  LDA (&A7),Y
  INY
  CMP #&FF
  BNE l0BD7

  JSR l0FC3

  LDA #&00:STA &11C2
  JMP l0BBF

.l0BD7
  CMP #&FE
  BNE l0BE3

  LDA #TUNE_NULL:STA melody
  JMP musicplayer

.l0BE3
  CMP #&FD
  BNE l0BF4

  LDA (&A7),Y
  INY
  STA &D418
  LDA (&A7),Y
  INY
  CMP #&FF
  BEQ l0BBF

.l0BF4
  ; Is it < 240
  CMP #&F0
  BCC l0C00

  AND #&0F
  STA &116E
  LDA (&A7),Y
  INY
.l0C00
  ; Is it < 192
  CMP #&C0
  BCC l0C0F

  AND #&1F
  ASL A
  ASL A
  ASL A
  STA &11C3,X
  LDA (&A7),Y
  INY
.l0C0F
  ; Is it < 128
  CMP #&80
  BCC l0C1B

  AND #&3F
  STA &1185,X
  LDA (&A7),Y
  INY
.l0C1B
  ; Is it < 96
  CMP #&60
  BCC l0C4D

  CMP #&7B
  BNE l0C40

  LDA #&00:STA &118E,X
  LDA #&01:STA &118B,X

  LDA (&A7),Y
  INY
  CLC
  ADC &1191,X
  STA &1194,X
  LDA (&A7),Y
  INY
  STA &1197,X
  JMP l0C4A

.l0C40
  CMP #&7A
  BNE l0C4D

  LDA (&A7),Y
  INY
  STA &11B1,X
.l0C4A
  LDA (&A7),Y
  INY
.l0C4D
  STY &11C2
  CLC
  ADC &1191,X
  STA &1169,X

  PHA
  LDY &11C3,X
  LDA #&FF:STA &11C9,X
  LDA &1250,Y:STA &0C7A
  PLA

  BEQ l0C76

  LDA &118E,X
  BNE l0C76

  LDA &1253,Y
  BEQ l0C76

  STA &118E,X

.l0C76
  JSR l0F83

  LDA #&07
  LDY &11CC

  PHA
  AND #&F0
  STA &1179,X
  STA &D402,Y
  PLA

  AND #&0F
  STA &117C,X
  STA &D403,Y

  LDA &1166,X
  BEQ l0CB4

  LDA &11C3,X
  TAX
  LDA &124E,X:STA &D405,Y
  LDA &124F,X:STA &D406,Y
  LDA #&00:STA &D404,Y
  LDA &124D,X
  AND #&F0
  ORA #&05
  STA &D404,Y
.l0CB4
  LDX &116C
  LDA &117F,X
  CLC
  ADC &11C2
  STA &117F,X
  BCC l0CC6

  INC &1182,X
.l0CC6
  LDA &1185,X:STA &1188,X
  LDA &11B1,X:STA &11B4,X
  LDY &115B,X
  INY
  TYA
  STA &11A6,X

  JMP l0EEC
}

.l0CDD
{
  LDA &1169,X
  BEQ l0CEF

  LDY &11C3,X
  LDA &1254,Y
  AND #&08
  BEQ l0CF2

  JMP l0D57

.l0CEF
  JMP l0EEC

.l0CF2
  LDA &1254,Y
  AND #&04
  BEQ l0CFC

  JMP l0D73

.l0CFC
  LDY &11C3,X
  LDA &1254,Y
  LDY &11CC
  AND #&01
  BEQ done

  LDY &11C3,X
  LDA &1251,Y
  AND #&0F
  ASL A
  ASL A
  TAY
  LDA &11ED,Y:STA &0D36
  LDA &11EE,Y:STA &0D37
  LDA &11EF,Y:STA &0D41
  LDA &11F0,Y:STA &0D42

  ; Is it >= 31
  LDA &11C9,X
  CMP #&1F
  BCS done

  PHA
  TAY
  LDA &1225,Y
  LDY &11CC
  STA &D404,Y
  PLA

  TAY
  LDA &1215,Y
  LDY &11CC
  CLC
  ADC #&0D
  STA &D401,Y
  LDA #&00:STA &D400,Y
  JMP l0EEC

.done
  JMP l0DA1
}

.l0D57
{
  LDY &11C3,X

  ; Is it >=1
  LDA &11C9,X
  CMP #&01
  BCS l0D8F

  LDA #&48
  LDY &11CC
  STA &D401,Y
  LDA #&00:STA &D400,Y
  LDA #&81
  JMP l0D98

.^l0D73
  LDY &11C3,X

  ; Is it >= 1
  LDA &11C9,X
  CMP #&01
  BCS l0D8F

  LDA #&48
  LDY &11CC
  STA &D401,Y
  LDA #&00:STA &D400,Y
  LDA #&11
  JMP l0D98

.l0D8F
  JSR l0F83
  LDY &11C3,X
  LDA &124D,Y
.l0D98
  LDY &11CC
  STA &D404,Y
  JMP l0EEC
}

.l0DA1
{
  LDA &118B,X
  BNE l0DAE

  LDY &11C3,X
  LDA &1251,Y
  BNE l0DB1

.l0DAE
  JMP l0E63

.l0DB1
  PHA
  AND #&0F
  STA &11AA
  PLA

  LSR A
  LSR A
  LSR A
  LSR A
  STA &11A9

  LDY &1169,X
  LDA &10E7,Y
  SEC
  SBC &10E6,Y
  STA &11B9

  LDA &1086,Y
  SBC &1085,Y
  STA &11BA
.l0DD5
  DEC &11AA
  BMI l0DE3

  LSR &11BA
  ROR &11B9
  JMP l0DD5

.l0DE3
  LDA &11AB,X
  BPL l0DF2

  DEC &11AE,X
  BNE l0E00

  INC &11AB,X
  BPL l0E00

.l0DF2
  INC &11AE,X
  LDA &11AE,X
  CMP &11A9
  BCC l0E00

  DEC &11AB,X
.l0E00
  LDA &11B4,X
  BEQ l0E0B

  DEC &11B4,X
  JMP l0EEC

.l0E0B
  LDA &1173,X:STA &11B7
  LDA &1176,X:STA &11B8
  LDA &11A9
  LSR A
  TAY
.l0E1C
  DEY
  BMI l0E35

  LDA &11B7
  SEC
  SBC &11B9
  STA &11B7
  LDA &11B8
  SBC &11BA
  STA &11B8

  JMP l0E1C

.l0E35
  LDY &11AE,X
.l0E38
  DEY
  BMI l0E51

  LDA &11B7
  CLC
  ADC &11B9
  STA &11B7
  LDA &11B8
  ADC &11BA
  STA &11B8

  JMP l0E38

.l0E51
  LDY &11CC
  LDA &11B7:STA &D400,Y
  LDA &11B8:STA &D401,Y

  JMP l0EEC
}

.l0E63
{
  LDA &118E,X
  BEQ l0E9E

  STA &11BB
  JSR l0F9E
.l0E6E
  LDY &11A6,X
  LDA &11CD,Y
  CMP #&FF
  BNE l0E81

  LDA &115B,X:STA &11A6,X

  JMP l0E6E

.l0E81
  CLC
  ADC &1169,X
  LDY &11CC
  TAX
  LDA &10E6,X:STA &D400,Y
  LDA &1085,X:STA &D401,Y
  LDX &116C
  INC &11A6,X

  JMP l0EEC

.l0E9E
  LDA &1194,X
  BEQ l0EEC

  STA &0FFF
  LDA &1197,X

  PHA
  AND #&0F
  STA &0EC1
  STA &104F
  PLA

  LSR A
  LSR A
  LSR A
  LSR A
  CLC
  ADC &1188,X
  CMP &1185,X
  BCS l0EEC

  ADC #&00
  CMP &1185,X
  BCC l0EEC

  LDY &1169,X
  JSR l0FFE
  LDX &116C
  LDY &11CC
  LDA &1173,X

  ; Polymorphic code
.v0ED6
  CLC
.v0ED7
  ADC &119A
  STA &1173,X
  STA &D400,Y
  LDA &1176,X
.v0EE3
  ADC &119B
  STA &1176,X
  STA &D401,Y

.^l0EEC
  LDA &1185,X
  BEQ l0F0A

  LSR A
  CMP &1188,X
  BNE l0F0A

  LDY &11C3,X
  LDA &124D,Y
  AND #&0F
  CLC
  ROL A
  ROL A
  ROL A
  ROL A
  LDY &11CC
  STA &D404,Y
.l0F0A
  LDY &11C3,X
  LDA &1252,Y
  BEQ l0F5F

  LDA &11A3,X
  BNE l0F37

  LDA &1179,X
  CLC
  ADC &1252,Y

  PHA
  STA &1179,X
  LDA &117C,X
  ADC #&00
  STA &117C,X
  PHA

  ; Is it < 15
  CMP #&0F
  BCC l0F54

  LDA #&01:STA &11A3,X
  JMP l0F54

.l0F37
  LDA &1179,X
  SEC
  SBC &1252,Y

  PHA
  STA &1179,X
  LDA &117C,X
  SBC #&00
  STA &117C,X
  PHA

  ; Is it >= 8
  CMP #&08
  BCS l0F54

  LDA #&00:STA &11A3,X
.l0F54
  LDY &11CC
  PLA
  STA &D403,Y
  PLA

  STA &D402,Y
.l0F5F
  DEC &116C
  BMI l0F67

  JMP l0B63

.l0F67
  DEC &116F
  BPL continueplaying

  LDA &116E:STA &116F
}

; Fall through

.continueplaying
{
  LDA #TUNE_CONT:STA melody

  RTS
}

; Reset audio ??
.l0F78
{
  LDY #&18
  LDA #&00

.loop
  STA &D400,Y
  DEY
  BPL loop

  RTS
}

.l0F83
{
  LDY &1169,X
  LDA &10E6,Y:STA &1173,X

  PHA
  LDA &1085,Y:STA &1176,X
  LDY &11CC
  STA &D401,Y
  PLA

  STA &D400,Y

  RTS
}

.l0F9E
{
  LDY &115B,X:INY

  LDX #&00
.loop
  ROR &11BB
  BCC l0FB0

  LDA &115E,X:STA &11CD,Y
  INY
.l0FB0
  INX
  CPX #&08
  BNE loop

  LDX &116C
  LDA #&FF:STA &11CD,Y
  LDA #&00:STA &1194,X

  RTS
}

; X reg is the sound channel (0/1/2)
.l0FC3
{
  LDA v11BC,X:STA &A9 ; lo
  LDA v11BF,X:STA &AA ; hi

.loop
  LDY v1170,X ; Get channel offset
  INC v1170,X ; Advance channel offset

  LDA (&A9),Y ; Read from music data pointer
  BPL l0FEB

  CMP #&FF ; Is this the channel EOF
  BNE keepgoing

  ; Loop back to start of data for this channel
  LDA #&00:STA v1170,X
  BEQ loop

.keepgoing
  CLC
  ADC #&40
  STA &1191,X
  JMP loop

.l0FEB
  ASL A ; * 2
  TAY
  LDA &12DD,Y
  STA &117F,X
  STA &A7

  LDA &12DE,Y
  STA &1182,X
  STA &A8

  RTS
}

.l0FFE
{
  LDX #&00
  CPY &0FFF
  BCS l1028

  LDA #&18 ; CLC
  STA &0ED6

  LDA #&6D ; ADC
  STA &0ED7
  STA &0EE3

  SEC
  LDA &10E6,X
  SBC &10E6,Y
  STA &119A

  LDA &1085,X
  SBC &1085,Y
  STA &119B

  JMP l1048

.l1028
  LDA #&38 ; SEC
  STA &0ED6

  LDA #&ED ; SBC
  STA &0ED7
  STA &0EE3

  SEC
  LDA &10E6,Y
  SBC &10E6,X
  STA &119A

  LDA &1085,Y
  SBC &1085,X
  STA &119B

.l1048
  LDY &116E
  LDA #&00
  CLC
.l104E
  ADC #&00
  DEY
  BPL l104E

  STA &119C
  CLC

  LDX #&10
  LDA #&00
.loop
  ROL &119A
  ROL &119B
  ROL A
  BCS l1069

  CMP &119C
  BCC l106D

.l1069
  SBC &119C
  SEC
.l106D
  DEX
  BNE loop

  ROL &119A
  ROL &119B
  ASL A
  CMP &119C
  BCC done

  INC &119A
  BNE done

  INC &119B

.done
  RTS
}

.v1085 ; []
.v1086 ; []

.v10E6 ; []
.v10E7 ; []

ORG &1147

.l1147
{
  JSR l0F78

  LDA #&0F:STA &D418

  LDA #&00
  STA &116F
  STA &116D

  RTS
}

.v1158 ; []
.v115B ; []
.v115E ; []
.v1166 ; []
.v1169 ; []
.v116C
.v116D
.v116E
.v116F

ORG &1170
.v1170 ; []
  EQUB &14 ; Channel 0 melody data pos
  EQUB &11 ; Channel 1 melody data pos
  EQUB &11 ; Channel 3 melody data pos

.v1173 ; []
.v1176 ; []
.v1179 ; []
.v117C ; []
.v117F ; []
.v1182 ; []
.v1185 ; []
.v1188 ; []
.v118B ; []
.v118E ; []
.v1191 ; []
.v1194 ; []
.v1197 ; []
.v119A
.v119B
.v119C
.v119D ; []
.v11A0 ; []
.v11A3 ; []
.v11A6 ; []
.v11A9
.v11AA
.v11AB ; []
.v11AE ; []
.v11B1 ; []
.v11B4 ; []
.v11B7
.v11B8
.v11B9
.v11BA
.v11BB

ORG &11BC
  ; Current melody
.v11BC ; []
  EQUB &0F
  EQUB &3D
  EQUB &65
.v11BF ; []
  EQUB &13
  EQUB &13
  EQUB &13

.v11C2
.v11C3 ; []
.v11C6 ; []
.v11C9 ; []
.v11CA
.v11CB
.v11CC
.v11CD ; []
.v11ED ; []
.v11EE ; []
.v11EF ; []
.v11F0 ; []
.v1215 ; []
.v1225 ; []

ORG &1235
.melodyconfigs ; []
  ; Melody 1 - Title screen
  EQUB &0F
  EQUB &13
  EQUB &3D
  EQUB &13
  EQUB &65
  EQUB &13

  ; Melody 2 - In-game
  EQUB &9F
  EQUB &14
  EQUB &C3
  EQUB &14
  EQUB &DA
  EQUB &14

  ; Melody 3 - Coin collect
  EQUB &FF
  EQUB &15
  EQUB &02
  EQUB &16
  EQUB &05
  EQUB &16

  ; Melody 4 - Lose a life / Heart demo
  EQUB &AE
  EQUB &16
  EQUB &B1
  EQUB &16
  EQUB &B4
  EQUB &16

.v124D ; []
.v124E ; []
.v124F ; []
.v1250 ; []
.v1251 ; []
.v1252 ; []
.v1253 ; []
.v1254 ; []
.v12DD ; []
.v12DE ; []
.v180E ; []
.v1828 ; []
.v1877 ; []
.v1897 ; []

ORG &189F
; Lookup table for screen offsets
.screentable_lo
  EQUB &00, &40, &80, &C0, &00, &40, &80, &C0
  EQUB &00, &40, &80, &C0, &00, &40, &80, &C0
  EQUB &00, &40, &80, &C0, &00, &40, &80, &C0
  EQUB &00

.screentable_hi
  EQUB &60, &61, &62, &63, &65, &66, &67, &68
  EQUB &6A, &6B, &6C, &6D, &6F, &70, &71, &72
  EQUB &74, &75, &76, &77, &79, &7A, &7B, &7C
  EQUB &7E

.v18D9 ; []
.v18DE ; object table offset / &FF / ????
coins_tens = &18E5
coins = &18E6
.v18E7
.v18E8 ; []
.v18EC ; []
.v18F0
.v18F4 ; []
.v18F8 ; []

ORG &1903
.deathmessages ; death message string table offsets []
  EQUB str_armorogkilledmess
  EQUB str_killedbyportcullis
  EQUB str_killedbyliftmess
  EQUB str_killedbyliftmess
  EQUB str_killedbyliftmess
  EQUB str_killedbyliftmess
  EQUB str_killedbyhawk
  EQUB str_ratgotyoumess
  EQUB str_killedbydaggersmess
  EQUB str_killedbydaggersmess
  EQUB str_killedbydaggersmess

; Entry point ??

ORG &190E

.l190E
  JSR install_ISR

  ; Zero-out &033A to &03FF
  LDX #&C6
  LDA #&00
.zerovar_loop
  STA &033A-1,X
  DEX
  BNE zerovar_loop

  JSR l3B6D
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_RAM:STA CPU_CONFIG
  LDA #TUNE_10:STA melody ; There is no melody 10 ??
.l1927
  LDA #&00
  STA GFX_BORDER_COLOUR
  STA lives

  LDX #&00
.l1931
  JSR l313F

  INX
  ; Is it < 8
  CPX #&08
  BCC l1931

  LDA #TUNE_1:STA melody ; Title screen melody
  LDA #&00:STA &033F

  JSR l3B6D
  JSR l3023

  LDA #&58:STA &03DC
  LDA #TITLEROOM:STA roomno

  JSR l2E79
  JSR l3090
  JSR drawcoincount

  LDA #58:STA &033A ; X position
  LDA #57:STA &033B ; Y position
  LDA #PAL_GREEN:STA &033C ; attrib
  LDA #&00:STA &03DC

  LDA #SPR_DIZZYLOGO ; frame
  JSR frame

  JSR printroomname

  LDA #str_startmess:JSR prtmessage

  JSR l3023

  ; Clear &5800 to &58E8
  LDX #&00
  TXA
.l1983
  STA &5800,X
  STA &58C8,X
  STA &5990,X
  STA &5A58,X
  STA &5B20,X

  INX
  ; Is it < 200
  CPX #&C8
  BCC l1983

  ; Reset coins collected count
  LDA #&00
  STA coins_tens
  STA coins
  STA &18E7

  ; Reset lives
  LDA #&02:STA lives

  LDX #&00
.l19A9
  LDA &18EC,X:STA &18F4,X

  INX
  ; Is it < 4
  CPX #&04
  BCC l19A9

  LDA #GAMESTARTROOM
  STA &03B8
  STA roomno

  LDA #&01:STA SPR_0_COLOUR ; White

  JSR drawcoincount

  LDA #&00
  STA SPR_Y_EXP
  STA SPR_X_EXP
  STA SPR_MULTICOLOUR
  STA &CFF8
  STA SPR_PRIORITY
  STA muted ; Enable sound

  ; Reset moving data (objects)
  LDX #noofmoving
.movingloop
  DEX
  LDA orig_rooms,X:STA objs_rooms,X ; room
  LDA orig_xlocs,X:STA objs_xlocs,X ; X position
  LDA orig_ylocs,X:STA objs_ylocs,X ; Y position
  LDA orig_attrs,X:STA objs_attrs,X ; attrib
  LDA orig_frames,X:STA objs_frames, X ; frame

  CPX #&00
  BNE movingloop

  JSR l29E4

  LDA #28
  STA olddizzyx
  STA dizzyx ; Dizzy starting X position

  LDA #100
  STA olddizzyy
  STA dizzyy ; Dizzy starting Y position

  LDA #&FF:STA &03DF

  LDA #&00:STA &03E0

  JSR l2F22
  JSR l346B

  LDA #TUNE_2:STA melody ; In-game melody
.l1A25
  NOP
  JSR mergekeypress

  CPY #KEY_Q
  BNE checkpause

  ; Quit to title screen ?
  JMP l1927

.checkpause
  CPY #KEY_P
  BNE checkmute

  ; Wait until no keys pressed
.pauseloop
  JSR mergekeypress

  CPY #KEY_NONE
  BNE pauseloop

.waitforkeypress
  JSR mergekeypress

  CPY #KEY_NONE
  BEQ waitforkeypress

  JMP l1A6C

.checkmute
  CPY #KEY_M
  BNE l1A6C

  ; M has been pressed, so toggle sound

  ; Check current state of mute toggle
  LDA muted
  BEQ mute

  ; Enable sound
  LDA #SOUND_ON:STA muted
  LDA #TUNE_2:STA melody ; In-game melody

  JMP waitfor_m_release

.mute
  ; Disable sound
  LDA #TUNE_NULL:STA melody
  LDA #SOUND_OFF:STA muted

.waitfor_m_release
  JSR mergekeypress
  CPY #KEY_M
  BEQ waitfor_m_release

.l1A6C
  JSR l3B00
  JSR getplayerinput

  LDA #&00:STA &03C1
  LDA &03BC:JSR delay
  INC &03C4

  ; Check brandy bottle
  LDA objs_rooms+obj_brandy
  CMP #OFFMAP
  BNE l1A96

  LDA &03C4
  AND #&20
  BNE l1A96

  LDA player_input
  EOR #JOY_RIGHT+JOY_LEFT
  STA player_input

.l1A96
  LDA &03BE
  BEQ l1A9E

  DEC &03BE
.l1A9E
  ; Is it >= 25 (therefore invalid)
  LDA roomno
  CMP #&19
  BCS l1AD2

  LDA player_input
  AND #JOY_RIGHT+JOY_LEFT
  BEQ l1AB4

  LDA player_input
  EOR #JOY_RIGHT+JOY_LEFT
  STA player_input
.l1AB4
  JSR l3257

  ; Is it < 250
  CMP #&FA
  BCC l1AD2

  JSR l326A

  AND #JOY_UP
  ORA player_input
  STA player_input

  JSR l326A

  ASL A
  AND #JOY_RIGHT+JOY_LEFT
  ORA player_input
  STA player_input
.l1AD2
  NOP
  NOP
  LDA #&06:STA &0342
.l1AD9
  LDA &03C9
  BEQ l1AE1
  JMP l1B95

.l1AE1
  LDA #&16:STA &033B
  LDA #&01:STA &033A
.l1AEB
  INC &033A

  ; Is it >= 6
  LDA &033A
  CMP #&06
  BCS l1B04

  JSR l3154

  BEQ l1AEB

  LDA &033F
  AND #&40
  BEQ l1AEB

  JMP l1B0C

.l1B04
  LDA #&03:STA &03C8

  INC dizzyy ; apply gravity whilst walking left and right
.l1B0C
  LDA &03C8
  CMP #&03
  BNE l1B68

  LDA #&16:STA &033B
  LDA #&01:STA &033A
.l1B1D
  INC &033A

  ; Is it >= 6
  LDA &033A
  CMP #&06
  BCS l1B58

  JSR l3154

  LDA &033E
  BEQ l1B1D

  LDA &033F
  AND #&40
  BEQ l1B1D

  LDA player_input
  AND #JOY_RIGHT+JOY_LEFT+JOY_UP
  BNE l1B48

  LDA #&00
  STA &03C8
  STA &03C7

  JMP l1B68

.l1B48
  LDA #&01:STA &03C8
  LDA &03C2:STA &03C7
  LDA #&00

  JMP l1B68

.l1B58
  DEC &0342
  LDA &0342
  BEQ l1B63

  JMP l1AD9

.l1B63
  LDA #JOY_NONE:STA player_input
.l1B68
  ; Is it >= 2
  LDA &03C8
  CMP #&02
  BCS l1B95

  LDA player_input
  AND #JOY_LEFT
  BNE l1B80

  LDA player_input
  AND #JOY_RIGHT
  BNE l1B90

  JMP l1B95

.l1B80
  LDA #&02
.l1B82
  STA &03C7
  STA &03C2

  LDA #&01:STA &03C8

  JMP l1B95

.l1B90
  LDA #&01
  JMP l1B82

.l1B95
  LDA &03C8
  CMP #&03
  BNE l1B9F

.l1B9C
  JMP l1C85

.l1B9F
  CMP #&02
  BEQ l1BCD

  LDA player_input
  AND #JOY_UP
  BNE l1BAD

  JMP l1B9C

.l1BAD
  LDA player_input
  AND #JOY_RIGHT+JOY_LEFT+JOY_DOWN+JOY_UP
  CMP #JOY_UP
  BNE l1BBE

  LDA #&00
  STA &03C7
  STA &03C2
.l1BBE
  LDA #&02:STA &03C8
  LDA #&00:STA &03C9
  LDA #&11:STA &03C3
.l1BCD
  INC &03C9

  ; Is it >= 9
  LDA &03C9
  CMP #&09
  BCS l1C15

  JSR l1C62
.l1BDA
  LDA #&00:STA &033B
  LDA #&01:STA &033A
.l1BE4
  INC &033A

  ; Is it >= 6
  LDA &033A
  CMP #&06
  BCS l1BFD

  JSR l3154
  BEQ l1BE4
  BCC l1BE4

  LDA #&02:STA &03C1
  JMP l1C85

.l1BFD
  DEC dizzyy ; go up due to jumping
  DEC &0342
  LDA &0342
  BNE l1BDA

  LDA &03C3
  ; Is it < 10
  CMP #&0A
  BCC l1C85

  DEC &03C3

  JMP l1C85

.l1C15
  JSR l1C62
.l1C18
  LDA #&16:STA &033B
  LDA #&01:STA &033A

  LDA &03C9
  CMP &03C3
  BCC l1C85

.l1C2A
  INC &033A

  ; Is it >= 6
  LDA &033A
  CMP #&06
  BCS l1C3E

  JSR l3154
  BEQ l1C2A
  BCC l1C2A

  JMP l1C51

.l1C3E
  INC dizzyy ; apply gravity whilst jumping/rolling
  DEC &0342
  LDA &0342
  BNE l1C18

  LDA #&00:STA &03C3

  JMP l1C85

.l1C51
  ; Is it >= 17
  LDA &03C9
  CMP #&11
  BCS l1C5D

  LDA #&01:STA &03C1
.l1C5D
  LDA #&00

  JMP l1C85

.l1C62
{
  ; Is it < 7
  LDA &03C9
  CMP #&07
  BCC l1C72

  ; Is it >= 11
  CMP #&0B
  BCS l1C72

  LDA #&02
  JMP l1C81

.l1C72
  ; Is it < 2
  CMP #&02
  BCC l1C7F

  ; Is it >= 16
  CMP #&10
  BCS l1C7F

  LDA #&04
  JMP l1C81

.l1C7F
  LDA #&06
.l1C81
  STA &0342 ; Set jump height

  RTS
}

.l1C85
  ; Is it >= 2
  LDA &03C8
  CMP #&02
  BCS l1CA8

  CMP #&00
  BEQ l1C96

  DEC &03C8

  JMP l1CA8

.l1C96
  STA &03C8
  STA &03C7
  STA &03C3
  STA &03C9
  STA &03C1

  JMP l1CB9

.l1CA8
  LDA &03C7
  BNE l1CB0

  JMP l1CB9

.l1CB0
  CMP #&01
  BEQ l1CCB

  LDA #&00
  JMP l1CCD

.l1CB9
  LDA &03C1
  CMP #&01
  BNE l1CC8

  LDA #&00:STA &03C1
  JMP l1BDA

.l1CC8
  JMP l1D41

.l1CCB
  LDA #&07
.l1CCD
  STA &033A
  LDA #&0C:STA &033B
  JSR l3154
  BCC l1CFC

  LDA &03C1
  CMP #&02
  BNE l1CE9

  LDA #&00:STA &03C1
  JMP l1CF7

.l1CE9
  LDA &03C3
  ; Is it < 10
  CMP #&0A
  BCC l1CB9

  LDA &03C9
  ; Is it < 9
  CMP #&09
  BCC l1CB9

.l1CF7
  LDA &033E
  BNE l1CB9

.l1CFC
  LDA #&0C:STA &033B
  JSR l3154
  BCS l1CB9

  LDA #&0C:STA &033B
  JSR l3154

  BCC l1D12
  BNE l1CB9
.l1D12
  LDA #&0D:STA &033B
  JSR l3154

  BCC l1D1E
  BNE l1CB9
.l1D1E
  LDA &03C9
  BEQ l1D2E

  ; Is it >= 9
  CMP #&09
  BCS l1D2E

  LDA &033F
  AND #&40
  BNE l1CB9

.l1D2E
  LDA &03C7
  CMP #&01
  BNE l1D3B

  INC dizzyx ; Move Dizzy right
  JMP l1D41

.l1D3B
  DEC dizzyx ; Move Dizzy left
  JMP l1D41

.l1D41
  LDA &03C8
  CMP #&02
  BNE l1D7C

  LDA &03C9
  ; Is it < 9
  CMP #&09
  BCC l1D7C

  AND #&07
  BNE l1D7C

  LDA #&16:STA &033B
  LDA #&00:STA &033A
.l1D5D
  INC &033A

  ; Is it >= 6
  LDA &033A
  CMP #&06
  BCS l1D7C

  JSR l3154
  BCC l1D5D
  BEQ l1D5D

  LDA #&00
  STA &03C8
  STA &03C7
  STA &03C9
  STA &03C3
.l1D7C
  LDA #&15:STA &033B
.l1D81
  LDA #&01:STA &033A
.l1D86
  INC &033A

  ; Is it >= 6
  LDA &033A
  CMP #&06
  BCS l1D9D

  JSR l3154

  BCC l1D86
  BEQ l1D86

  DEC dizzyy ; go up due to stairs
  JMP l1D41

.l1D9D
  DEC &033B

  ; IS it >= 18
  LDA &033B
  CMP #&12
  BCS l1D81

  ; Check Dizzy X position < 57 (not gone off screen to right)
  LDA dizzyx
  CMP #57
  BCC l1DB9

  LDA #2:STA dizzyx ; Set Dizzy position to far left
  INC roomno ; Go right
  JMP l1DFC

.l1DB9
  ; Check Dizzy X position >= 2 (not gone off screen to left)
  CMP #2
  BCS l1DC8

  LDA #56:STA dizzyx ; Set Dizzy position to far right
  DEC roomno ; Go left
  JMP l1DFC

.l1DC8
  ; Check Dizzy Y position < 128
  LDA dizzyy
  CMP #128
  BCC l1E1D

  ; Check Dizzy Y position >= 192
  CMP #192
  BCS l1DE7

  LDA #0:STA dizzyy
  LDA roomno:SEC:SBC #16:STA roomno ; Go down

  JSR l2A01
  JMP l1DFC

.l1DE7
  ; Check Dizzy Y position < 192
  LDA dizzyy
  CMP #192
  BCC l1E1D

  LDA #114:STA dizzyy
  LDA roomno:CLC:ADC #16:STA roomno ; Go up

.l1DFC
  LDA roomno
  CMP #EASTWINGROOM
  BEQ l1E12

  STA &03B8
  LDA dizzyx:STA olddizzyx
  LDA dizzyy:STA olddizzyy
.l1E12
  LDA #&00:STA &03E0
  LDA roomno
  JSR l2F22
.l1E1D
  LDA dizzyy:CLC:ADC #&5A:STA &D001

  LDA dizzyx
  ASL A
  ASL A
  CLC
  ADC #&38
  STA &D000

  BCC l1E3B

  LDA SPR_MSB_X
  ORA #&01
  JMP l1E40

.l1E3B
  LDA SPR_MSB_X
  AND #&FE
.l1E40
  STA SPR_MSB_X
  LDA &03C8
  BNE l1E55

  LDA &03C7
  BNE l1E7E

  LDA &03C4
  AND #&01
  JMP l1E9E

.l1E55
  CMP #&02
  BNE l1E7E

  LDA &03C7
  BNE l1E63

  LDA #&02
  JMP l1E6E

.l1E63
  CMP #&01
  BNE l1E6C

  LDA #&1A
  JMP l1E6E

.l1E6C
  LDA #&22
.l1E6E
  STA &FF

  LDA &03C9
  SEC
  SBC #&01
  AND #&07
  CLC
  ADC &FF
  JMP l1E9E

.l1E7E
  LDA &03C2
  BEQ l1E9E

  JSR l2AB7
  LDA &03C2
  CMP #&01
  BNE l1E92

  LDA #&0A
  JMP l1E94

.l1E92
  LDA #&12
.l1E94
  STA &FF
  LDA &03C4
  AND #&07
  CLC
  ADC &FF
.l1E9E
  JSR checkfordownunder

  STA &5FF8
  LDA #&FF:STA SPR_ENABLE ; Show sprites
  LDA &03C7
  CMP #&02
  BEQ l1ECC

  LDX #&43 ; egg, room 36, 80x160
  JSR collidewithdizzy
  BCC l1ECC

  LDA #str_getbackintheremess:JSR prtmessage

  LDA #&00
  STA &03C7
  STA &03C8

  LDA #JOY_LEFT+JOY_UP:STA player_input
  JMP l1B68

.l1ECC
  LDX #&41
  JSR collidewithdizzy
  BCC l1EE8

  ; Make shopkeeper appear
  LDA #MARKETSQUAREROOM
  STA objs_rooms+obj_shopkeeper
  STA objs_rooms+obj_shopkeeper+1

  LDA #OFFMAP:STA &C6DF

  LDA #str_shopkeeperappearsmess:JSR prtmessage
  JMP l1F33

.l1EE8
  LDA roomno
  CMP #MINESROOM
  BNE l1F33

  ; Check Dizzy X position < 52 (far right)
  LDA dizzyx
  CMP #52
  BCC l1F33

  ; Check where troll is
  LDA #MINESROOM
  CMP objs_rooms+obj_troll
  BEQ l1F33

  ; Put troll in mine
  STA objs_rooms+obj_troll

  LDA #90:STA objs_xlocs+obj_troll
  LDA #120:STA objs_ylocs+obj_troll
  LDA #ATTR_NOTSOLID+PAL_GREEN:STA objs_attrs+obj_troll
  LDA #OFFMAP:STA &C6E1

  LDX #obj_troll
  JSR l29D3

  LDA #str_goawaymess:JSR prtmessage

  LDA #&00
  STA &03C7
  STA &03C8

  LDA #JOY_LEFT+JOY_UP:STA player_input
  LDA #CASTLEDUNGEONROOM:STA &C6D5
  JMP l1B68

.l1F33
  LDA #&FF
  STA &03D9
  STA &18DE

  LDA &03C7
  BNE l1F48

  LDA &03C8
  BNE l1F48

  JMP l1F50

.l1F48
  LDA player_input
  AND #&EF ; ????
  STA player_input
.l1F50
  LDA player_input
  AND #JOY_FIRE
  BNE l1F5A

  JMP l24A0

.l1F5A
  LDX #&00
.l1F5C
  LDA dizzyx
  CLC
  ADC #30
  STA &033A ; X position
  CLC
  ADC #8
  STA &033C
  LDA dizzyy
  CLC
  ADC #26
  STA &033B ; Y position
  CLC
  ADC #34
  STA &033D
.l1F7A
  LDA objs_rooms,X
  CMP roomno
  BNE l1FA9

  LDA objs_attrs,X
  AND #ATTR_REVERSE
  BNE l1FA9

  LDA objs_xlocs,X
  CMP &033A
  BCC l1FA9

  CMP &033C
  BCS l1FA9

  LDA objs_ylocs,X
  CMP &033B
  BCC l1FA9

  CMP &033D
  BCS l1FA9

  STX &18DE
  JMP l1FB3

.l1FA9
  INX
  ; Is it a collectable object
  CPX #maxcollectable+1
  BCC l1F7A

  LDX #&FF
  STX &18DE
.l1FB3
  LDX #obj_denzil
  JSR collidewithdizzy
  BCC l1FD1

  ; Check rope
  LDY #str_stereoess
  LDA objs_rooms+obj_rope
  CMP #&65
  BNE l1FCA

  ; Make rope appear
  LDA #BANQUETHALLROOM:STA objs_rooms+obj_rope

  LDY #str_denziltalking
.l1FCA
  TYA
  JSR prtmessage

  JMP l24A0

.l1FD1
  LDX #&55
  JSR collidewithdizzy
  BCC l1FE0

  LDA #str_lookatpicturemess:JSR prtmessage
  JMP l24A0

.l1FE0
  LDX #obj_switch
  JSR collidewithdizzy
  BCC l1FFB

  ; Check if portcullis switch has been activated
  LDA objs_attrs+obj_switch
  CMP #PAL_CYAN
  BNE l1FFB

  ; Activate portcullis switch
  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_switch
  LDA #str_throwswitchmess:JSR prtmessage

  JMP l24A0

.l1FFB
  LDX #obj_dozy
  JSR collidewithdizzy
  BCC l202B

  ; Check sleeping potion
  LDA objs_rooms+obj_sleepingpotion
  CMP #&65
  BNE l2013

  ; Make sleeping potion appear
  LDA #OUTTOSEAROOM:STA objs_rooms+obj_sleepingpotion

  LDY #str_dozytalking
  JMP l2024

.l2013
  LDX #obj_dozy
  JSR l32EB

  ; Position Dozy
  LDA #60:STA objs_xlocs+obj_dozy
  LDA #134:STA objs_ylocs+obj_dozy
  LDY #str_kickdozyagainmess
.l2024
  TYA
  JSR prtmessage

  JMP l24A0

.l202B
  LDA roomno
  CMP #CASTLESTAIRCASEROOM
  BNE l2048

  ; Check for doorknocker
  LDA objs_rooms+obj_doorknocker
  CMP #collected
  BEQ l2048

  LDX #&44
  JSR collidewithdizzy
  BCC l2048

  LDA #str_knockandentermess:JSR prtmessage
  JMP l24A0

.l2048
  LDX #&63
  JSR collidewithdizzy
  BCC l2066

  ; Check crowbar
  LDY #str_goonmysonmess
  LDA objs_rooms+obj_crowbar
  CMP #&65
  BNE l205F

  ; Make crowbar appear
  LDA #LIFTTOELDERSROOM:STA objs_rooms+obj_crowbar
  LDY #str_dougtalking
.l205F
  TYA
  JSR prtmessage

  JMP l24A0

.l2066
  LDX #obj_dylan
  JSR collidewithdizzy
  BCC l2084

  ; Check Dylan orientation
  LDY #str_trancemess
  LDA objs_attrs+obj_dylan
  CMP #PAL_WHITE
  BNE l207D

  ; Make Dylan face the other way
  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_dylan
  LDY #str_dylantalking
.l207D
  TYA
  JSR prtmessage

  JMP l24A0

.l2084
  LDX #obj_switch2
  JSR collidewithdizzy
  BCC l20CE

  ; Check switch in Daisy's prison
  LDA #ATTR_REVERSE+PAL_WHITE
  CMP objs_attrs+obj_switch2
  BEQ l20CE

  ; Activate switch in Daisy's prison
  STA objs_attrs+obj_switch2

  LDX #obj_switch2
  JSR l29D3

.l209A
  LDX #obj_liftbottom
  JSR l32EB

  ; Move bottom of lift downwards
  INC objs_ylocs+obj_liftbottom
  JSR l29D3

  INX ; switch from liftbottom to daisy
  JSR l32EB

  ; Also move Daisy downwards (she's on the lift)
  INC objs_ylocs+obj_daisy
  LDA objs_attrs+obj_daisy:EOR #ATTR_REVERSE:STA objs_attrs+obj_daisy
  JSR l29D3

  ; Move top of lift downwards
  LDX #obj_lifttop
  INC objs_ylocs+obj_lifttop
  JSR l29D3

  LDA #&0A:JSR delay

  ; Check where the lift has got to, keep moving until it gets to the bottom
  LDA objs_ylocs+obj_liftbottom
  ; Is it < 139
  CMP #139
  BCC l209A

  JMP l24A0

.l20CE
  LDX #obj_goldenegg2
  JSR collidewithdizzy
  BCC l20E2

  LDX #obj_goldenegg2
  JSR l32EB

  ; Remove golden egg
  LDA #OFFMAP:STA objs_rooms+obj_goldenegg2

  JMP l24A0

.l20E2
  JMP l2A2E

.l20E5
  LDX &18DE
  CPX #&00
  BNE l20F9

  ; Change bag room to 4 - to indicate it's been collected
  LDA #collected:STA objs_rooms+obj_bag
.l20F1
  LDA #&FF:STA &18DE
  JMP coincheck

.l20F9
  CPX #&02
  BNE l2113

  ; Check manure orientation
  LDA objs_attrs+obj_manure
  CMP #ATTR_REVERSE
  BCS l210E

  ; Add reverse flag
  ORA #ATTR_REVERSE
  STA objs_attrs+obj_manure

  LDA #str_pickupmanuremess:JSR prtmessage

.l210E
  LDX #&03
  JMP l1F5C

.l2113
  CPX #&0A
  BNE coincheck

  ; Loop around the objects
  LDX #obj_bean
.objloop
  LDA objs_rooms,X
  CMP #collected
  BNE l213A

  LDA roomno:STA objs_rooms,X ; place object in current room

  LDA dizzyx
  CLC
  ADC #33
  AND #%11111110
  STA objs_xlocs,X ; Update X position of object based on Dizzy X position

  LDA dizzyy:CLC:ADC #45:STA objs_ylocs,X
.l213A
  INX
  ; Is it < 63
  CPX #63
  BCC objloop

  LDA #str_holdingholemess:JSR prtmessage

  LDA #OFFMAP:STA objs_rooms+obj_blackhole ; Remove blackhole
  JMP l20F1

.coincheck
  ; Check to see if this object is a coin
  LDX &18DE
  CPX #firstcoin
  BCC notacoin

  CPX #lastcoin+1
  BCS notacoin

  ; This object is a coin
  JSR collect_coin
  JMP l24A0

.notacoin
  ; Is it a non-collectable
  CPX #maxcollectable+1
  BCS l21A0

  LDA #collected:STA objs_rooms,X

  CPX #lastcoin+1
  BCC l2177

  LDA &C696,X
  CMP #&65
  BNE l2177

  LDA roomno:STA &C696,X
.l2177
  JSR l374F

  ; Check for larger inventory
  LDA objs_rooms+obj_bag
  LDX #&02
  CMP #collected
  BNE l2185

  LDX #&04
.l2185
  LDA &18D9,X
  CMP #&FF
  BEQ l21A0

  CMP #&00
  BEQ l21A0

  LDX &18D9
  STX &03D9
  LDA #OFFMAP:STA objs_rooms,X

  LDA #str_carryingtoomuchmess:JSR prtmessage

.l21A0
  LDA #&00:STA SPR_ENABLE ; Hide sprites

  JSR drawinventory

  LDA &18D9
  BEQ l21B4

  LDA &03D9
  CMP #&FF
  BEQ l21C4

.l21B4
  LDA #&F0:JSR delay
  LDA #&F0:JSR delay

  JSR resetgamestate
  JMP l242D

.l21C4
  LDA #str_selectitemmess:JSR prtmessage

.l21C9
  LDX #&00
.l21CB
  LDA &18D9,X
  BEQ l21D4

  INX
  JMP l21CB

.l21D4
  STX &03D9
.l21D7
  LDA #&05
  JSR l3A71

  LDA #&3C:JSR delay
.l21E1
  JSR getplayerinput
  LDA player_input
  AND #JOY_FIRE+JOY_RIGHT+JOY_LEFT
  BEQ l21E1

  AND #JOY_FIRE
  BEQ l2202

  LDX &03D9
  LDA &18D9,X
  BNE l21F9

  LDA #&FF
.l21F9
  STA &03D9
  JSR resetgamestate
  JMP l222E

.l2202
  LDA #&03
  JSR l3A71
  LDA player_input
  AND #JOY_LEFT
  BEQ l221B

  DEC &03D9

  ; Is it >= 250
  LDX &03D9
  CPX #&FA
  BCS l21C9

  JMP l21D7

.l221B
  LDX &03D9
  INC &03D9
  LDA &18D9,X
  BNE l21D7

  LDA #&00:STA &03D9
  JMP l21D7

.l222E
  LDX #obj_shopkeeper
  JSR collidewithdizzy
  BCC l225C

  LDA &03D9
  CMP #obj_cow
  BEQ l2244

  LDA #str_givingjunkmess:JSR prtmessage

  JMP l242D

.l2244
  ; Make bean appear
  LDA #MARKETSQUAREROOM:STA objs_rooms+obj_bean
  JSR l29C1

  ; Hide shopkeeper
  LDA #OFFMAP
  STA objs_rooms+obj_shopkeeper
  STA objs_rooms+obj_shopkeeper+1

  LDA #str_thanksforthecowmess:JSR prtmessage

  JMP l242D

.l225C
  LDA &03D9
  CMP #obj_apple
  BNE checkjugofwater

  LDX #obj_troll
  JSR collidewithdizzy
  BCC l2272

  JSR l29C1

  LDA #str_trollgotapplemess:JSR prtmessage

.l2272
  JMP l242D

.checkjugofwater
  CMP #obj_jugofwater
  BNE checkrope

  LDX #&44
  JSR collidewithdizzy
  BCC l2272

  JSR l29C1

  LDA #str_throwwateronfiremess:JSR prtmessage

  LDA #CASTLESTAIRCASEROOM:STA &C6E2
  LDA #&24:STA &C768

  JMP l242D

.checkrope
  CMP #obj_rope
  BNE l22B0

  LDX #obj_croc
  JSR collidewithdizzy
  BCC l2272

  JSR l29C1
  ; Update crocodile animation frame
  LDA #SPR_CROCCLOSED:STA objs_frames+obj_croc

  LDA #str_croctiedmess:JSR prtmessage

  JMP l242D

.l22B0
  ; Is it < 23
  CMP #&17
  BCC checkdoorknocker

  ; Is it >= 26
  CMP #&1A
  BCS checkdoorknocker

  LDX #&4F
  JSR collidewithdizzy
  BCC l2272

  ; Raise the water by 5 pixels
  LDA objs_ylocs+obj_water
  SEC
  SBC #5
  STA objs_ylocs+obj_water
  STA objs_ylocs+obj_water+1
  STA objs_ylocs+obj_water+2

  ; Raise the pontoon by 5 pixels
  LDA objs_ylocs+obj_pontoon
  SEC
  SBC #5
  STA objs_ylocs+obj_pontoon

  JSR l29C1

  LDA #str_rockinwatermess:JSR prtmessage

  JMP l242D

.checkdoorknocker
  CMP #obj_doorknocker
  BNE checkbone

  LDX roomno
  CPX #CASTLESTAIRCASEROOM
  BNE checkbone

  LDX #&44
  JSR collidewithdizzy
  BCC l2304

  JSR l29C1

  ; Remove plank and (egg?)
  LDA #OFFMAP
  STA objs_rooms+obj_plank
  STA &C6E2

  LDA #str_usedoorknockermess:JSR prtmessage

.l2304
  JMP l242D

.checkbone
  CMP #obj_bone
  BNE checkcrowbar

  LDX #&52
  JSR collidewithdizzy
  BCC l2304

  LDA #str_fedarmorog:JSR prtmessage

  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_bone
  LDA #OFFMAP:STA &C6F0
  JMP l242D

.checkcrowbar
  CMP #obj_crowbar
  BNE checkbean

  LDX #obj_wood
  JSR collidewithdizzy
  BCC l2304

  JSR l29C1
  LDA #OFFMAP:STA objs_rooms+obj_wood

  LDA #str_usecrowbarmess:JSR prtmessage

  JMP l242D

.checkbean
  CMP #obj_bean
  BNE checkbucket

  LDX #obj_manure
  JSR collidewithdizzy
  BCC l2304

  JSR l29C1

  LDA #str_plantbeanmess:JSR prtmessage

  JMP l242D

.l2355
  LDA #&00
  STA &03C7
  STA &03C8

  LDA #JOY_LEFT+JOY_UP:STA player_input
  JMP l1B68

.checkbucket
  CMP #obj_bucket
  BNE l23A7

  ; Check colour of bucket
  LDA objs_attrs+obj_bucket
  CMP #PAL_BLUE
  BNE l238E

  ; Check bean
  LDA objs_rooms+obj_bean
  CMP #OFFMAP
  BNE l23C5

  LDX #obj_manure
  JSR collidewithdizzy
  BCC l23C5

  JSR l29C1

  ; ?? put beanstalk in allotment ??
  LDA #ALLOTMENTROOM:STA &C721

  LDA #str_throwwateronbeanmess:JSR prtmessage

  JMP l2355

.l238E
  LDX #&5D
  JSR collidewithdizzy
  BCC l23C5

  ; Set colour of bucket to blue
  LDA #PAL_BLUE:STA objs_attrs+obj_bucket
  LDA #&FF:STA &03D9

  LDA #str_fillbucketmess:JSR prtmessage

  JMP l242D

.l23A7
  ; Is it < 12
  CMP #&0C
  BCC checkgoldenegg

  ; Is it >= 16
  CMP #&10
  BCS checkgoldenegg

  CLC
  ADC #&4C
  TAX
  JSR collidewithdizzy
  BCC l23C5

  LDA #PAL_WHITE:STA objs_attrs,X
  JSR l29C1

  LDA #str_keyinmachine:JSR prtmessage

.l23C5
  JMP l242D

.checkgoldenegg
  CMP #obj_goldenegg
  BNE checkpickaxe

  LDX #&47
  JSR collidewithdizzy
  BCC l23C5

  LDA #str_puteggbackmess:JSR prtmessage

  ; Flip golden egg
  LDA #ATTR_REVERSE+PAL_YELLOW:STA objs_attrs+obj_goldenegg
  JMP l242D

.checkpickaxe
  CMP #obj_pickaxe
  BNE checkrug

  LDX #&49
  JSR collidewithdizzy
  BCC l23C5

  JSR l29C1

  LDA #OFFMAP:STA &C6E6

  LDA #str_usepickaxemess:JSR prtmessage

  JMP l242D

.checkrug
  CMP #obj_rug
  BNE checksleepingpotion

  LDA #DAISYSPRISONROOM
  CMP roomno
  BNE l23C5

  STA &C708
  STA &C709

  JSR l29C1

  LDA #str_userugmess:JSR prtmessage

  JMP l242D

.checksleepingpotion
  CMP #obj_sleepingpotion
  BNE l242D

  LDA #WIDEEYEDDRAGONROOM
  CMP roomno
  BNE l242D

  JSR l29C1

  LDA #str_dragonasleepmess:JSR prtmessage

  JMP l242D

.l242D
  LDX #&73:STX &03DB
.l2432
  JSR collidewithdizzy
  BCC l243F

  LDX #&FF:STX &03D9
  JMP l2449

.l243F
  INC &03DB
  LDX &03DB
  ; Is it < 123
  CPX #&7B
  BCC l2432

.l2449
  LDX &03D9
  CPX #&13
  BNE l245B

  JSR l29C1

  LDA #str_dropwhiskeymess:JSR prtmessage

  JMP l24A0

.l245B
  CPX #&FF
  BEQ l24A0

  LDA #maxcollectable+1:STA &03DD
  LDA #&00:STA &03D5

  ; Wait until raster line >= 250
.l2469
  LDA GFX_RASTER_LINE
  ; Is it < 250
  CMP #250
  BCC l2469

  JSR drawobjects

  LDX &03D9
  LDA roomno:STA objs_rooms,X

  LDA dizzyx:CLC:ADC #33:AND #&FE:STA objs_xlocs,X
  LDA dizzyy:CLC:ADC #45:STA objs_ylocs,X

  LDA #maxcollectable+1:STA &03DD
  LDA #&FF:STA &03D5

  JSR drawobjects
  JSR l3090
.l24A0
  LDX #&00:STX &03B7
.l24A5
  LDA &18F8,X
  TAX
  JSR collidewithdizzy
  BCC l24B7

  LDX &03B7 ; offset
  LDA deathmessages,X
  JMP l2572

.l24B7
  INC &03B7
  LDX &03B7
  ; Is it < 11
  CPX #&0B
  BCC l24A5

  ; Check if crocodile's mouth is open
  LDA objs_frames+obj_croc
  CMP #SPR_CROCOPEN
  BNE l24D4

  LDX #obj_croc
  JSR collidewithdizzy
  BCC l24D4

  LDA #str_croceatenmess
  JMP l2572

.l24D4
  LDA roomno
  CMP #DRAGONSLAIRROOM
  BEQ l24E2

  CMP #WIDEEYEDDRAGONROOM
  BEQ l24EC

  JMP l2527

.l24E2
  LDA objs_attrs+obj_goldenegg
  AND #ATTR_REVERSE
  BEQ l24F3

  JMP l24FF

.l24EC
  ; Check sleeping potion
  LDA objs_rooms+obj_sleepingpotion
  CMP #OFFMAP
  BEQ l24FF

.l24F3
  LDX #obj_dragonhead
  JSR collidewithdizzy
  BCC l24FF

  LDA #str_dragonkilledmess
  JMP l2572

.l24FF
  LDA dizzyy
  ; Is it < 88
  CMP #&58
  BCC l2527

  LDA &03BA
  BEQ l2527

  LDA dizzyx
  CLC
  ADC #&23
  ; Is it < 49
  CMP #&31
  BCC l2527

  CMP &03BA
  BCC l2527

  SEC
  SBC #&04
  CMP &03BA
  BCS l2527

  LDA #str_dragonflameskilledmess
  JMP l2572

.l2527
  LDA #&02:STA &033A
.l252C
  LDA #&06:STA &033B

  JSR l3154
  LDA &033F
  AND #&30
  BNE l2554

  LDA #&0D:STA &033B

  JSR l3154
  LDA &033F
  AND #&30
  BNE l2554

  INC &033A
  LDA &033A
  ; Is it < 6
  CMP #&06
  BCC l252C

.l2554
  LDA &033F
  AND #&20
  BEQ l2560

  LDA #str_killedbyflame
  JMP l2572

.l2560
  LDA &033F
  AND #&10
  BEQ l25C7

  LDA #str_killedbyvolcano
  LDY roomno
  CPY #ACTIVEVOLCANOROOM
  BEQ l2572

  LDA #str_killedbywater
.l2572
  STA &03B7
  CMP #&35
  BNE l258A

  LDA roomno
  CMP #DAISYSPRISONROOM
  BNE l258A

  ; Check for rug
  LDA objs_rooms+obj_rug
  CMP #OFFMAP
  BNE l258A

  JMP l25C7

.l258A
  LDA #TUNE_4:STA melody ; Lose a life / heart demo melody
  JSR l34E2

  ; You lose a life ...
  LDA #str_deadwindow:JSR prtmessage

  ; Reason for losing life message
  LDA &03B7
  JSR prtmessage

  LDA #&07:STA &03B7
.l25A2
  LDA #&FA:JSR delay

  DEC &03B7
  BNE l25A2

  LDA lives
  BNE l25B4

  JMP l1927 ; No lives left

.l25B4
  DEC lives ; lose a life

  JSR l2F22
  JSR l346B

  ; Check if muted
  LDA muted
  BNE l25C7

  LDA #TUNE_2:STA melody ; In-game melody
.l25C7
  LDA roomno
  CMP #CASTLEDUNGEONROOM
  BNE l2629

  ; Check for rat
  LDA objs_rooms+obj_rat
  CMP #OFFMAP
  BEQ l2629

  ; Check if bread is in this room
  LDA roomno
  CMP objs_rooms+obj_bread
  BNE l2601

  ; Check Y position of bread >= 100 (not near rat)
  LDA objs_ylocs+obj_bread
  CMP #100
  BCS l2601

  ; See if rat's X position is less than the bread - i.e. it ate it
  LDA objs_xlocs+obj_bread
  CLC
  ADC #4
  CMP objs_xlocs+obj_rat
  BCC l2601

  LDA #OFFMAP:STA objs_rooms+obj_bread ; Remove bread

  ; Flip rat to go back to it's nest
  LDA objs_attrs+obj_rat:ORA #ATTR_REVERSE:STA objs_attrs+obj_rat ; Set top bit

  LDA #str_thanksforloafmess:JSR prtmessage

.l2601
  LDX #obj_rat

  ; Check rat direction
  LDA objs_attrs+obj_rat
  AND #ATTR_REVERSE
  BEQ l263E

  ; Move rat right
  JSR l32EB

  INC objs_xlocs+obj_rat
  JSR l3306

  ; Check for bread being in room
  LDA objs_rooms+obj_bread
  CMP #OFFMAP
  BNE l262C

  ; Check rat X position < 96
  LDA objs_xlocs+obj_rat
  CMP #96
  BCC l2650

  JSR l32EB

  ; Remove rat
  LDA #OFFMAP:STA objs_rooms+obj_rat
.l2629
  JMP l2650

.l262C
  ; Check rat X position < 79
  LDA objs_xlocs+obj_rat
  CMP #79
  BCC l2650

.l2633
  ; Flip rat direction
  LDA objs_attrs+obj_rat:EOR #ATTR_REVERSE:STA objs_attrs+obj_rat ; flip top bit

  JMP l2650

.l263E
  ; Move rat left
  LDX #obj_rat
  JSR l32EB

  DEC objs_xlocs+obj_rat
  JSR l3306

  ; Check rat X position < 47
  LDA objs_xlocs+obj_rat
  CMP #47
  BCC l2633

.l2650
  LDA roomno
  CMP #GATORROOM
  BNE l267A

  ; Check rope
  LDA objs_rooms+obj_rope
  CMP #OFFMAP
  BEQ l267A

  LDA &03C4
  LSR A
  LSR A
  AND #&07
  ; Is it < 6
  CMP #&06
  BCC l266B

  LDA #&01
.l266B
  AND #&01
  EOR #&01
  CLC
  ADC #SPR_CROCCLOSED
  STA objs_frames+obj_croc

  LDX #obj_croc
  JSR l29D3

.l267A
  LDA roomno
  CMP #MOATROOM
  BNE l26BE

  ; Check if portcullis switch is active
  LDA objs_attrs+obj_switch
  CMP #PAL_CYAN
  BEQ l26BE

  ; Check portcullis orientation
  LDA objs_attrs+obj_portcullis
  AND #ATTR_REVERSE
  BNE l26AE

  ; Move portcullis up
  LDX #obj_portcullis
  JSR l32EB

  DEC objs_ylocs+obj_portcullis

  ; Is Y position >= 97
  LDA objs_ylocs+obj_portcullis
  CMP #97
  BCS l26A6

.l269E
  ; Flip portcullis orientation
  LDA objs_attrs+obj_portcullis:EOR #ATTR_REVERSE:STA objs_attrs+obj_portcullis
.l26A6
  LDX #obj_portcullis
  JSR l29D3

  JMP l26BE

.l26AE
  ; Check portcullis height >= 136
  LDA objs_ylocs+obj_portcullis
  CMP #136
  BCS l269E

  ; Move portcullis down
  CLC:ADC #4:STA objs_ylocs+obj_portcullis
  JMP l26A6

.l26BE
  LDA roomno
  CMP #OUTTOSEAROOM
  BNE l26E8

  ; Check Dozy X position >= 70
  LDA objs_xlocs+obj_dozy
  CMP #70
  BCS l26E8

  LDA &03C4
  AND #&03
  BNE l26E8

  ; Update Dozy Y position
  LDX #obj_dozy
  JSR l32EB

  LDA &03C4
  AND #&04
  CLC
  ADC #134
  STA objs_ylocs+obj_dozy

  LDX #obj_dozy
  JSR l29D3

.l26E8
  LDX #&00
  LDA &03BE
  BEQ l26F2

  JMP l2767

.l26F2
  LDA &18E8,X
  CMP roomno
  BNE l2762

  ; Check if machine[x] is active
  LDA objs_attrs+obj_machines,X
  CMP #PAL_WHITE
  BNE l2762

  STX &03B7
  TXA
  ASL A
  CLC
  ADC #&73
  TAX
  LDA objs_attrs+obj_bean,X
  AND #ATTR_REVERSE
  BNE l273F

  INC objs_ylocs,X
  JSR l29D3

  INX
  JSR l32EB

  INC objs_ylocs,X
  JSR l29D3

  LDY &03B7
  LDA objs_ylocs,X:STA &18F4,Y
  CMP &18F0,Y
  BCC l2767

.l272F
  LDA objs_attrs,X:EOR #ATTR_REVERSE:STA objs_attrs,X ; flip top bit
  LDA #&10:STA &03BE
  JMP l2767

.l273F
  DEC objs_ylocs,X
  JSR l29D3

  INX
  JSR l32EB

  DEC objs_ylocs,X
  JSR l29D3

  LDY &03B7
  LDA objs_ylocs,X:STA &18F4,Y
  CMP &18EC,Y
  BEQ l272F
  BCC l272F

  JMP l2767

.l2762
  INX

  ; Is it < 4
  CPX #&04
  BCC l26F2

.l2767
  LDA roomno
  CMP #GUARDHOUSEROOM
  BEQ l2771

  JMP l2809

.l2771
  LDX #obj_hawk
  JSR l3306

  ; Check hawk Y position == 56
  LDA objs_ylocs+obj_hawk
  CMP #56
  BNE l279B

  ; Check hawk X position > 61
  LDA objs_xlocs+obj_hawk
  CMP #61
  BCS l279E

  ; Check hawk X position < 46
  CMP #46
  BCC l279E

  ; See if Dizzy is directly below hawk
  LDA dizzyx
  CLC
  ADC #28
  CMP objs_xlocs+obj_hawk
  BEQ l279B

  ; Update hawk X position
  CLC
  ADC #1
  CMP objs_xlocs+obj_hawk
  BNE l279E

.l279B
  JMP l27DF

.l279E
  ; Check hawk X position < 35
  LDA objs_xlocs+obj_hawk
  CMP #35
  BCC l27A9

  ; Check hawk X position < 80
  CMP #80
  BCC l27B1

.l27A9
  ; Flip hawk direction
  LDA objs_attrs+obj_hawk:EOR #ATTR_REVERSE:STA objs_attrs+obj_hawk
.l27B1
  ; Check hawk direction
  LDA objs_attrs+obj_hawk
  AND #ATTR_REVERSE
  BNE l27C1

  ; Move hawk right
  INC objs_xlocs+obj_hawk
  INC objs_xlocs+obj_hawk

  JMP l27C7

.l27C1
  ; Move hawk left
  DEC objs_xlocs+obj_hawk
  DEC objs_xlocs+obj_hawk
.l27C7
  LDA &03C4
  LSR A
  AND #&03
  CMP #&03
  BNE l27D3

  LDA #&01
.l27D3
  CLC
  ADC #SPR_HAWK0
  ; Update hawk animation frame
  STA objs_frames+obj_hawk
  JSR l3306
  JMP l2809

.l27DF
  ; Hawk is diving, so move downwards
  LDA objs_ylocs+obj_hawk
  CLC
  ADC #8
  STA objs_ylocs+obj_hawk

  ; Keep hawk moving towards Dizzy
  LDA dizzyx
  CLC
  ADC #28
  CMP objs_xlocs+obj_hawk
  BCC l27FE

  LDA objs_attrs+obj_hawk:AND #&7F:STA objs_attrs+obj_hawk
  JMP l27B1

.l27FE
  LDA objs_attrs+obj_hawk:ORA #ATTR_REVERSE:STA objs_attrs+obj_hawk ; Set top bit
  JMP l27B1

.l2809
  LDA roomno
  CMP #ARMOROGROOM
  BNE l283A

  LDA &03C4
  AND #&01
  BEQ l283A

  ; Check bone
  LDA objs_rooms+obj_bone
  CMP #OFFMAP
  BEQ l283A

  ; Check Dizzy Y position >= 104 (on lower ground)
  LDX #obj_grunt
  LDA dizzyy
  CMP #104
  BCS l283D

  LDA &C6F0
  CMP #OFFMAP
  BEQ l283D

  ; Check grunt (Armorog) X position >= 55
  LDA objs_xlocs+obj_grunt
  CMP #55
  BCS l2847

  LDA #&00:STA &03BD
.l283A
  JMP l28B0

.l283D
  ; Is it >= 40
  LDA &03BD
  CMP #&28
  BCS l2847

  INC &03BD
.l2847
  LDA #&00:STA &03DC
  JSR l3306

  LDA &03C4
  LSR A
  AND #&01
  CLC
  ADC #SPR_GRUNT0
  ; Update grunt (Armorog) animation frame
  STA objs_frames+obj_grunt

  ; Is it < 32
  LDA &03BD
  CMP #&20
  BCC l28A8

  ; Check which way grunt is facing
  LDA objs_attrs+obj_grunt
  AND #ATTR_REVERSE
  BNE l2872

  ; Move grunt right
  INC objs_xlocs+obj_grunt
  INC objs_xlocs+obj_grunt

  JMP l2878

.l2872
  ; Move grunt left
  DEC objs_xlocs+obj_grunt
  DEC objs_xlocs+obj_grunt

.l2878
  ; Check grunt X position < 55
  LDA objs_xlocs+obj_grunt
  CMP #55
  BCC l2883

  ; Check grunt X position < 78
  CMP #78
  BCC l28A8

.l2883
  ; Switch grunt direction
  LDA objs_attrs+obj_grunt:EOR #ATTR_REVERSE:STA objs_attrs+obj_grunt

  ; Check if grunt X position is 78
  LDA objs_xlocs+obj_grunt
  CMP #78
  BNE l28A8

  ; Check bone orientation
  LDA objs_attrs+obj_bone
  AND #ATTR_REVERSE
  BEQ l28A8

  LDA #OFFMAP:STA objs_rooms+obj_bone ; Remove bone
  LDA #&92:STA objs_attrs+obj_grunt

  LDX #obj_grunt
  JSR l32EB

.l28A8
  LDA #&00:STA &03DC

  JSR l3306
.l28B0
  LDA roomno
  CMP #DRAGONSLAIRROOM
  BEQ l28C3

  CMP #WIDEEYEDDRAGONROOM
  BEQ l28D2

  LDA #&00:STA &03BA
  JMP l295E

.l28C3
  ; Check goldenegg orientation
  LDA objs_attrs+obj_goldenegg
  CMP #ATTR_REVERSE
  BCC l28E1

  LDA &03BB
  BNE l28E1

  JMP l295E

.l28D2
  ; Check sleeping potion
  LDA objs_rooms+obj_sleepingpotion
  CMP #OFFMAP
  BNE l28E1

  LDA &03BB
  BNE l28E1

  JMP l2993

.l28E1
  ; Check state of dragon's head
  LDA objs_frames+obj_dragonhead
  CMP #SPR_DRAGONHEADCLOSED
  BEQ l28EB

  JMP l295E

.l28EB
  LDA &03C4
  AND #&01
  BEQ l28F5

  JMP l295E

.l28F5
  LDX #obj_dragonhead
.l28F7
  JSR l32EB

  DEX
  ; loop while >= 108
  CPX #&6C
  BCS l28F7

  LDX #&72
.l2901
  STX &FF
  LDA #&72
  SEC
  SBC &FF
  CMP &03BB
  BEQ l290F
  BCS l2925
.l290F
  LDA &C89C
  AND #&20
  BNE l291F

  ; Move object up
  DEC objs_ylocs,X
  DEC objs_ylocs,X

  JMP l2925

.l291F
  ; Move object down
  INC objs_ylocs,X
  INC objs_ylocs,X
.l2925
  LDA #&00:STA &03DC

  JSR l3306
  DEX
  ; Loop while >=108
  CPX #&6C
  BCS l2901

  LDA &C89C
  AND #&20
  BNE l2949

  INC &03BB
  ; Is it < 7
  LDA &03BB
  CMP #&07
  BCC l295E

  DEC &03BB
  JMP l2956

.l2949
  DEC &03BB
  LDA &03BB
  CMP #&FF
  BNE l295E

  INC &03BB
.l2956
  LDA &C89C:EOR #&20:STA &C89C
.l295E
  LDA roomno
  CMP #DRAGONSLAIRROOM
  BNE l296F

  ; Check second golden egg
  LDA objs_rooms+obj_goldenegg2
  CMP #OFFMAP
  BNE l2993

  JMP l297F

.l296F
  CMP #WIDEEYEDDRAGONROOM
  BNE l2993

  LDA &03BB
  BNE l2993

  JSR l326A
  CMP #&01
  BNE l2993

.l297F
  LDA &03BA
  BNE l2993

  LDA #&42:STA &03BA
  ; Set dragon's head to mouth open
  LDA #SPR_DRAGONHEADOPEN:STA objs_frames+obj_dragonhead

  LDX #obj_dragonhead
  JSR l3306
.l2993
  LDA &03BA
  BEQ l29BA

  DEC &03BA
  DEC &03BA

  ; Is it >= 42
  LDA &03BA
  CMP #&2A
  BCS l29B7

  LDA #&00:STA &03BA
  ; Set dragon's head to mouth closed
  LDA #SPR_DRAGONHEADCLOSED:STA objs_frames+obj_dragonhead

  LDX #obj_dragonhead
  JSR l3306
  JMP l29BA

.l29B7
  JSR l3A9F
.l29BA
  NOP
  JSR l38B1
  JMP l1A25

.l29C1
{
  STX &034E
  LDX &03D9

  ; Set objects[X] as hidden
  LDA #OFFMAP
  STA objs_rooms,X
  STA &03D9

  LDX &034E

  RTS
}

.l29D3
{
  LDA #&58:STA &03DC
  JSR l3306

  LDA #&00:STA &03DC
  JSR l3306

  RTS
}

.l29E4
{
  ; Move sleeping potion
  LDA #128:STA objs_ylocs+obj_sleepingpotion
  LDA #82:STA objs_xlocs+obj_sleepingpotion

  LDA #OFFMAP:STA &C6A5 ; happy dust?

  LDA #ATTR_GRID+PAL_WHITE
  STA objs_attrs+obj_rat
  STA objs_attrs+obj_hawk

  LDA #ATTR_GRID+PAL_RED:STA objs_attrs+obj_grunt

  RTS
}

.l2A01
{
  LDA roomno
  CMP #STRANGENEWROOM
  BEQ l2A11

  CMP #UNDERAUSROOM
  BNE done

  LDA #TOPWELLROOM:STA roomno

.l2A11
  LDA #114:STA dizzyy

  LDA #&01
  STA &03C7
  STA &03C2

  LDA #&02:STA &03C8
  LDA #&01:STA &03C9
  LDA #&11:STA &03C3

.done
  RTS
}

.l2A2E
{
  LDX #obj_daisy
  JSR collidewithdizzy
  BCS l2A38

  JMP l20E5

.l2A38
  LDA roomno
  CMP #DAISYSPRISONROOM
  BNE l2A68

  LDA #str_gottodaisymess:JSR prtmessage

  ; Put Daisy in her hut
  LDA #DAISYSHUTROOM:STA objs_rooms+obj_daisy
  LDA #50:STA objs_xlocs+obj_daisy
  LDA #77:STA objs_ylocs+obj_daisy

  LDA #&00:STA SPR_ENABLE ; Hide sprites
  JSR heartdemo

  LDA #str_daisyrunsmess:JSR prtmessage

  LDA #TUNE_2:STA melody ; In-game melody
  JMP l24A0

.l2A68
  LDA coins_tens
  CMP #&03
  BNE l2A77

  LDA #str_gotallcoins:JSR prtmessage

  JMP l1927

.l2A77
  LDA #str_notgotallcoins:JSR prtmessage

  JMP l24A0
}

.checkfordownunder
{
  ; Check if were down-under
  LDY roomno
  CPY #CHURCHROOM+1
  BCC downunder

  RTS

.downunder
  LDY #&00:STY &FC

  LDX #&06
.loop
  CLC
  ROL A
  ROL &FC
  DEX
  BNE loop

  STA &FB

  LDA &FC:CLC:ADC #&40:STA &FC

  LDY #&00
  LDX #&3E
.fliploop
  LDA (&FB),Y

  STX &FF ; Cache X
  TAX
  LDA flip_lut,X
  LDX &FF ; Restore X

  STA &4A80,X
  DEX
  INY
  CPY #&3F
  BCC fliploop

  LDA #&2A

  RTS
}

.l2AB7
{
  LDA muted
  BNE l2ABD

.l2ABC
  RTS

.l2ABD
  LDA &03C4
  AND #&01
  BEQ l2ABC

  ; Is it >= 2
  LDA &03C8
  CMP #&02
  BCS l2ABC

  ; SID audio code ?

  SEI ; Disable interrupts
  LDA #&00:STA &D404
  LDA #&09:STA &D418
  LDA &03C4:AND #&02:ASL A:CLC:ADC #&06:STA &D401
  LDA #&00:STA &D406
  LDA #&10:STA &D405
  LDA #&81:STA &D404
  CLI ; Enable interrupts

.v2AF2 ; []
  RTS
}

  ; No idea what this is, used by l2D95
.v2AF3 ; []
  EQUB &00, &00, &b8, &00, &00, &00, &81, &00, &80

; Some further unknown bytes here

ORG &2B13

; Flames
.flameindex ; flame counter (up to 10)
  EQUB 0

.flame_x
  EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.flame_y
  EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.flame_attr
  EQUB 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.install_ISR
{
  SEI

  ; Set up pointer to ISR routine
  LDA #lo(isr_routine):STA ISR
  LDA #hi(isr_routine):STA ISR+1

  ; Enable sound, but don't play melody yet
  LDA #SOUND_ON+TUNE_NULL
  STA muted
  STA melody

  CLI

  RTS
}

.v2B47
  EQUB 142
.muted
  EQUB 0

.isr_routine
{
  INC v2B47

  LDA v2B47
  AND #&07
  CMP #&07
  BEQ done

  JSR musicplayer

.done
  JMP KERNAL_ISR
}

; Draw frame/sprite
;
; frame = A reg
; frmx = &033A
; frmy = &033B
; attr = &033C
.frame
{
  STA &FB
  STA &0340
  STX &0345

  LDA &033A
  ; Ensure X position is < 93
  CMP #93
  BCC inrange

  RTS

.inrange
  ; Get pointer to frame data
  JSR getframepointer
  BCC foundframe

  RTS

.foundframe
  STA &B5

  ; Divide Y position by 8
  LDA &033B
  LSR A
  LSR A
  LSR A
  TAX

  ; Check for frame being a water sprite

  ; Is frame < 91
  LDA &0340
  CMP #SPR_WATER
  BCC notwater

  ; Is frame >= 96
  CMP #SPR_TROLL
  BCS notwater

  ; Water processing
  LDA &03DA
  BEQ l2B8F

  CMP &033A
  BCC l2B95

.l2B8F
  LDA &033A:STA &03DA ; X position
.l2B95
  STX &03E0
  LDA &033F:ORA #&10:STA &033F
  LDA &033B:AND #&F8:STA &033B ; Y position
  JMP l2BD5

.notwater
  CMP #SPR_FLAME
  BNE l2BD5

  ; Flame processing
  LDY &03DC
  BEQ l2BD5

  ; Is it >= 10
  LDY flameindex
  CPY #10
  BCS l2BD5

  LDA &033A:STA flame_x,Y ; X position
  LDA &033B:STA flame_y,Y ; Y position
  LDA &033C:ORA #&10:STA flame_attr,Y ; attr
  DEC &03BC
  INC flameindex

.l2BD5
  ; Calculate screen RAM position
  LDA screentable_lo,X:STA &FB
  LDA screentable_hi,X:STA &FC

  LDA &033B ; Y position
  AND #&07
  CLC
  ADC &FB
  BCC l2BEB

  INC &FC
.l2BEB
  SEC
  SBC #&60
  BCS l2BF2

  DEC &FC
.l2BF2
  STA &FB

  LDA &033A ; X position
  AND #&FE
  ASL A
  CLC
  ASL A
  BCC l2C00

  INC &FC
.l2C00
  CLC
  ADC &FB
  BCC l2C07

  INC &FC
.l2C07
  STA &FB

  LDA &033B ; Y position
  LSR A:LSR A:LSR A ; Divide by 8
  TAX
  LDA &1828,X:SEC:SBC &03DC:STA &FE
  LDA &180E,X
  SEC
  SBC #&0C
  BCS l2C23

  DEC &FE
.l2C23
  STA &FD

  LDA &033A ; X position
  LSR A ; Divide by 2
  CLC
  ADC &FD
  BCC l2C30

  INC &FE
.l2C30
  STA &FD
  STA &35
  LDA &03DC
  BNE l2C41

  LDA &FE
  SEC
  SBC #&04

  JMP l2C46

.l2C41
  LDA &FE
  CLC
  ADC #&54
.l2C46
  STA &36
  LDY #&00
  LDA (&B4),Y:STA &033D
  LSR &033D
  INY
  LDA (&B4),Y:STA &033E

  ; Is it < 48
  LDA &0340
  CMP #'0'
  BCC notfont

  ; Is it >= 91
  CMP #'Z'+1
  BCS notfont

  ; Processing for font sprites
  LDA #&01:STA &033D
  LDA #&08:STA &033E

.notfont
  LDA &B4
  CLC
  ADC #&02
  BCC l2C76

  INC &B5
.l2C76
  STA &B4
  JSR l2DCF

  LDA &03E2
  BNE l2C83

  STA &03DF
.l2C83
  LDA #&00:STA &034A
  LDA &033D:STA &034B

  ; Is it >= 34
  LDA &033A ; X position
  AND #&FE
  CMP #34
  BCS l2CA2

  STA &FF
  LDA #&22
  SEC
  SBC &FF
  LSR A
  STA &034A
.l2CA2
  LDA &033A:AND #&FE:STA &FF

  LDA #&5E
  SEC
  SBC &FF
  LSR A
  CMP &034B
  BCS l2CB7

  STA &034B
.l2CB7
  LDA #&00:STA &0349

.l2CBC
  LDA &033B ; Y position
  CMP &03E3
  BCS l2CC7

  JMP l2D29

.l2CC7
  LDY #&00
.l2CC9
  LDA (&B4),Y:STA &2AF3,Y
  INY
  CPY &033D
  BCC l2CC9

  LDA &033C ; attr
  AND #&80
  BEQ l2CDE

  JSR l2E2E
.l2CDE
  LDA &033A ; X position
  AND #&01
  BEQ l2CE8

  JSR l2D95
.l2CE8
  LDX &034A
.l2CEB
  LDA &1877,X
  TAY
  LDA &2AF3,X
  AND &03DF

  ; Polymorphic code
.v2CF5
  NOP
.v2CF6
  NOP

  STA (&FB),Y
  LDA &0349
  BNE l2D23

  TXA
  TAY
  LDA &033F
  AND #&08
  BNE l2D1A

  LDA &03E2
  BEQ l2D0E

  STA (&FD),Y
.l2D0E
  LDA (&35),Y:AND #&30:ORA &033F:STA (&35),Y
  JMP l2D23

.l2D1A
  LDA (&35),Y:AND #&F0:ORA &033F:STA (&35),Y
.l2D23
  INX
  CPX &034B
  BCC l2CEB

.l2D29
  DEC &033E
  BNE l2D46

.l2D2E
  LDX &0345
  LDA #&FF:STA &03DF
  LDA #&00:STA &03DC
  LDA #&30:STA &03E3
  LDA #&B8:STA &03E1
  RTS

.l2D46
  INC &033B ; Y position
  LDA &033B
  CMP &03E1
  BCS l2D2E

  LDA &B4
  CLC
  ADC &033D
  BCC l2D5B

  INC &B5
.l2D5B
  STA &B4
  LDA &033B ; Y position
  AND #&07
  BEQ l2D73

  INC &0349
  INC &FB
  BEQ l2D6E

  JMP l2CBC

.l2D6E
  INC &FC
  JMP l2CBC

.l2D73
  INC &FC
  STA &0349
  LDA &FB
  CLC
  ADC #&39
  BCC l2D81

  INC &FC
.l2D81
  STA &FB
  LDA &FD
  CLC
  ADC #&28
  BCC l2D8E

  INC &FE
  INC &36
.l2D8E
  STA &FD
  STA &35

  JMP l2CBC
}

.l2D95
{
  LDX &033D
  LDA #&00:STA &2AF3,X
.l2D9D
  LDA &2AF2,X
  ASL A
  ASL A
  ASL A
  ASL A
  ORA &2AF3,X
  STA &2AF3,X

  LDA &2AF2,X
  LSR A
  LSR A
  LSR A
  LSR A
  STA &2AF2,X

  DEX
  BNE l2D9D

  LDA &033D
  CMP &034B
  BCC done

  ; Is it >= 47
  LDA &033A
  LSR A
  CLC
  ADC &033D
  CMP #&2F
  BCS done

  INC &034B

.done
  RTS
}

.l2DCF
{
  LDA &033C
  AND #&07
  TAX
  LDA &1897,X:STA &03E2
  BEQ l2DEC

  LDA &033A
  AND #&01
  BEQ l2DEC

  LDA &033C:ORA #&10:STA &033C
.l2DEC
  LDA &033C
  AND #&40
  BEQ l2DF9

  ORA &033F
  STA &033F
.l2DF9
  LDA &033C
  AND #&20
  BEQ l2E08

  LDA &033F:ORA #&80:STA &033F
.l2E08
  LDA &033C
  AND #&18
  LSR A
  LSR A
  LSR A
  BNE l2E1A

  LDA #&EA:STA &2CF6 ; NOP

  JMP l2E2A

.l2E1A
  LDX #&FB ; ?? ISC ?? - undocumented opcode
  STX &2CF6

  CMP #&01
  BNE l2E28

  LDA #&51 ; EOR

  JMP l2E2A

.l2E28
  LDA #&11 ; ORA
.l2E2A
  STA &2CF5

  RTS
}

.l2E2E
{
  LDX &033D:DEX:STX &0346

  LDX #&00:STX &0347
.l2E3A
  LDX &0347
  CPX &0346
  BEQ l2E6E

  BCS done

  LDA &2AF3,X
  TAY
  LDA flip_lut,Y:STA &FF
  LDX &0346
  LDA &2AF3,X
  TAY
  LDA flip_lut,Y
  LDX &0347
  STA &2AF3,X
  LDX &0346
  LDA &FF:STA &2AF3,X
  DEC &0346
  INC &0347

  JMP l2E3A

.l2E6E
  LDA &2AF3,X
  TAY
  LDA flip_lut,Y
  STA &2AF3,X

.done
  RTS
}

.l2E79
{
  STA &0340
  ; Is it < 101
  CMP #&65
  BCC l2E81

  RTS

.l2E81
  LDA #&80:STA &FC
  LDA &0340
  CLC
  ADC &0340
  BCC l2E90

  INC &FC
.l2E90
  STA &FB

  ; Set up pointers (B0 and B2) to room data
  LDA #&CC
  STA &B0
  STA &B2

  LDA #&80
  STA &B1
  STA &B3

  LDY #&01
  LDA (&FB),Y
  CLC
  ADC &B1
  STA &B1

  DEY
  LDA (&FB),Y
  CLC
  ADC &B0
  BCC l2EB1

  INC &B1
.l2EB1
  STA &B0

  LDY #&03
  LDA (&FB),Y
  CLC
  ADC &B3
  STA &B3

  DEY

  LDA (&FB),Y
  CLC
  ADC &B2
  BCC l2EC6

  INC &B3
.l2EC6
  STA &B2
.l2EC8
  LDA &B0
  CMP &B2
  BNE l2ED5

  LDA &B1
  CMP &B3
  BNE l2ED5
  RTS

.l2ED5
  LDY #&01
  LDA #&03:STA &0342
  LDA (&B0),Y
  AND #&80
  BNE l2EEE

  LDY #&03
  INC &0342
  LDA (&B0),Y:EOR #&40:STA &03BF
.l2EEE
  LDA &03BF:STA &033C ; attrib
  LDA #&00:STA &033F

  LDY #&02
  LDA (&B0),Y:STA &033B ; Y position

  DEY
  LDA (&B0),Y
  AND #&7F
  STA &033A ; X position

  DEY
  LDA #&58:STA &03DC
  LDA (&B0),Y ; frame
  JSR frame

  LDA &B0
  CLC
  ADC &0342
  BCC l2F1D

  INC &B1
.l2F1D
  STA &B0

  JMP l2EC8
}

.l2F22
{
  JSR printroomname
  JSR l3814

  ; Check bone
  LDA objs_rooms+obj_bone
  CMP #OFFMAP
  BEQ resetgamestate

  ; Position grunt
  LDA #54:STA objs_xlocs+obj_grunt
  LDA #ATTR_GRID+PAL_RED:STA objs_attrs+obj_grunt
}

; Fall through

.resetgamestate
{
  LDA #&00
  STA &03BB
  STA SPR_ENABLE ; Hide sprites
  STA &03E0
  STA &03DA

  LDA &03C4:AND #&F8:STA &03C4

  LDA #56:STA objs_ylocs+obj_hawk
  LDA #&0F:STA &03BC
  LDA #&00:STA flameindex

  LDX #&00
.l2F60
  STA flame_x,X
  STA flame_y,X
  STA flame_attr,X

  INX
  ; Is it < 10
  CPX #&0A
  BCC l2F60

  LDA roomno
  CMP #DRAGONSLAIRROOM
  BNE l2F7A

  LDA #&0C
  JMP l2F80

.l2F7A
  CMP #&36
  BNE l2FAA

  LDA #&0A
.l2F80
  STA &FF

  LDX #&6C
.l2F84
  LDA roomno:STA objs_rooms,X

  LDA &FF:STA objs_attrs,X
  LDA orig_ylocs,X:STA objs_ylocs,X ; Reset Y position

  INX
  ; Is it < 115
  CPX #&73
  BCC l2F84

  LDA #&0B:STA &03BC
  LDA objs_attrs+obj_dragonhead:AND #&07:STA objs_attrs+obj_dragonhead
  JMP l2FAF

.l2FAA
  ; Set dragon's head to mouth closed
  LDA #SPR_DRAGONHEADCLOSED:STA objs_frames+obj_dragonhead
.l2FAF
  LDA SPR_COLLISION2
  LDA SPR_COLLISION2
  LDA #&FF:STA &03DF
  JSR l3023

  LDA roomno
  JSR l2E79

  LDA roomno
  CMP #CASTLEDUNGEONROOM
  BNE l2FD9

  ; Check jug of water
  LDA objs_rooms+obj_jugofwater
  CMP #OFFMAP
  BEQ l2FE9

  LDA #&02

  JSR l2E79
  JMP l2FE9

.l2FD9
  CMP #&3A
  BNE l2FE9

  ; Check bucket
  LDA objs_rooms+obj_bucket
  CMP #OFFMAP
  BNE l2FE9

  LDA #&01
  JSR l2E79
.l2FE9
  ; See if Dizzy is in the moat room
  LDA roomno
  CMP #MOATROOM
  BNE l300A

  ; Set portcullis height
  LDA #96:STA objs_ylocs+obj_portcullis
.l2FF5
  LDX #obj_portcullis
  JSR l3306

  ; Check portcullis height > 136
  LDA objs_ylocs+obj_portcullis
  CMP #136
  BCS l300A

  ; Move portcullis down
  CLC
  ADC #4
  STA objs_ylocs+obj_portcullis

  JMP l2FF5

.l300A
  LDA #&FF:STA &03D5
  LDA #noofmoving:STA &03DD

  JSR drawobjects
  JSR l30CD
  JSR l3090

  LDA #&FF:STA SPR_ENABLE ; Show sprites

  RTS
}

.l3023
{
  LDA #&06:STA &033A
.l3028
  LDX &033A
  LDA screentable_hi,X:STA &FC
  LDA screentable_lo,X
  CLC
  ADC #&28
  BCC l303A

  INC &FC
.l303A
  STA &FB
  LDA &1828,X:STA &FE
  LDA &180E,X
  CLC
  ADC #&05
  BCC l304B

  INC &FE
.l304B
  STA &FD
  STA &B0
  STA &B2

  LDA &FE:SEC:SBC #&04:STA &B1

  SEC
  SBC #&54
  STA &B3

  LDY #&F0
  LDA #&00
.l3061
  DEY
  STA (&FB),Y
  CPY #&00
  BNE l3061

  LDY #&1E
.l306A
  DEY
  STA (&B0),Y
  STA (&FD),Y

  LDA #&10:STA (&B2),Y
  LDA #&00
  CPY #&00
  BNE l306A

  INC &033A

  LDA &033A
  ; Is it < 23
  CMP #&17
  BCC l3028

  LDA #&00
  TAX
.l3086
  STA &5800,X
  STA &5900,X

  INX
  BNE l3086

  RTS
}

.l3090
{
  LDX #&06
.l3092
  LDA &1828,X:STA &FC

  SEC
  SBC #&04
  STA &36

  SEC
  SBC #&54
  STA &FE

  LDA &180E,X
  STA &FB
  STA &FD
  STA &35

  LDY #&22
.l30AC
  LDA (&35),Y
  AND #&07
  BEQ l30BE

  STX &0346
  TAX
  LDA &1897,X
  LDX &0346
  BNE l30C0

.l30BE
  LDA (&FD),Y
.l30C0
  STA (&FB),Y

  DEY
  CPY #&04
  BNE l30AC

  INX
  ; Is it < 23
  CPX #&17
  BCC l3092

  RTS
}

.l30CD
{
  LDX #&00
  LDA #&58:STA &03DC
.loop
  LDA &18E8,X
  CMP roomno
  BNE l310F

  ; Check if machine[x] is activated
  LDA objs_attrs+obj_machines,X
  CMP #PAL_WHITE
  BNE l310F

  STX &03DB
  TXA
  ASL A
  CLC
  ADC #&73
  TAX
  ; Reset Y position of this object and next
  LDA orig_ylocs,X:STA objs_ylocs,X
  LDA orig_ylocs+1,X:STA objs_ylocs+1,X
.l30F8
  JSR l3306

  LDA objs_ylocs+1,X
  LDY &03DB
  CMP &18F4,Y
  BCS l3117

  INC objs_ylocs,X
  INC objs_ylocs+1,X

  JMP l30F8

.l310F
  INX
  CPX #&04
  ; Is it < 4
  BCC loop

  JMP l311B

.l3117
  INX
  JSR l3306

.l311B
  LDA roomno
  CMP #DAISYSPRISONROOM
  BNE done

  ; Check if switch in Daisy's prison is activated
  LDA objs_attrs+obj_switch2
  CMP #PAL_CYAN
  BEQ done

  LDX #obj_lifttop
  LDA orig_ylocs,X:STA objs_ylocs,X
.l3131
  JSR l3306

  INC objs_ylocs,X
  LDA objs_ylocs,X
  ; Is it < 103
  CMP #103
  BCC l3131

.done
  RTS
}

.l313F
{
  STX &034E

  LDA #&00
  STA dizzyx,X
  STA dizzyy,X
  STA &0370,X
  STA &0366,X

  JSR l31EE

  RTS
}

.l3154
{
  LDA dizzyx
  CLC
  ADC &033A
  STA &033C

  DEC &033C

  LDA dizzyy
  CLC
  ADC &033B
  CLC
  ADC #&28
  STA &033D

  DEC &033D
  LDA &033D
  LSR A
  LSR A
  LSR A
  TAX
  LDA screentable_lo,X:STA &FB
  LDA screentable_hi,X:STA &FC
  LDA &180E,X:STA &FD
  LDA &1828,X:SEC:SBC #&04:STA &FE

  LDA &033D
  AND #&07
  CLC
  ADC &FB
  CLC
  ADC #&20
  STA &FB

  LDA &033C
  LSR A
  CLC
  ADC #&04
  TAY
  LDA (&FD),Y
  STA &033F

  LDA &033C
  AND #&01
  BEQ l31B5

  LDA #&0F

  JMP l31B7

.l31B5
  LDA #&F0
.l31B7
  STA &033E

  LDA &033C
  LSR A
  TAX
  LDA &1877,X
  TAY
  LDA (&FB),Y
  AND &033E
  STA &033E

  LDA &033F
  AND #&40
  CMP #&01
  LDA &033E

  RTS
}

; 18 cycles of setup
; Then multiply the following by A reg
; 3315 cycles of innerloop
; 11 cycles of loop
;
; A reg of &00 = 3,344 cycles / &FF = 848,148 cycles
.delay
{
  STA &0340 ; (4) Delay amount
  STX &0345 ; (4) Preserve X

.loop
  LDX #&FF ; (2) Game speed

.innerloop
  NOP ; (2)
  NOP ; (2)
  NOP ; (2)
  NOP ; (2)

  DEX ; (2)
  BNE innerloop ; (3 or 2 when not taken)

  DEC &0340 ; (6)
  BNE loop ; (3 or 2 when not taken)

  LDX &0345 ; (4) Restore X

  RTS ; (6)
}

.l31EE
{
  STX &0345
  STY &0347
  LDY #&00
  LDA #&01:STA &0342
  LDX &034E
.l31FE
  CPX #&00
  BEQ l320B

  INY
  INY
  ASL &0342
  DEX
  JMP l31FE

.l320B
  LDX &034E

  ; Is it < 28
  LDA dizzyx,X
  CMP #&1C
  BCC l321C

  ; Is it >= 145
  CMP #&91
  BCS l321C

  JMP l321E

.l321C
  LDA #&00
.l321E
  CLC
  ROL A
  STA &D000,Y
  BCC l3231

  LDA SPR_MSB_X:ORA &0342:STA SPR_MSB_X
  JMP l323C

.l3231
  LDA &0342:EOR #&FF:AND SPR_MSB_X:STA SPR_MSB_X
.l323C
  INY

  ; Is it < 74
  LDA dizzyy,X
  CMP #&4A
  BCC l324B

  ; Is it >= 230
  CMP #&E6
  BCS l324B

  JMP l324D

.l324B
  LDA #&00
.l324D
  STA &D000,Y
  LDX &0345
  LDY &0347

  RTS
}

.l3257
{
  STX &0345 ; Cache X

  INC &03C5
  LDX &03C5
  LDA &E290,X:STA &03C6

  LDX &0345 ; Restore X

  RTS
}

.l326A
{
  STX &0346 ; Cache X

  INC &03C5
  LDX &03C5
  LDA &EA60,X
  AND #&03
  CLC
  ADC #&01
  STA &03C6

  LDX &0346 ; Restore X

  RTS
}

.l3282
{
  STX &0345
  STA &0340
  LDX &034E
  LDA &0340 ; Not required ?
  AND #&03
  BEQ l32AD

  AND #&01
  BEQ l32A3

  LDA dizzyy,X:SEC:SBC &037A,X:STA dizzyy,X

  JMP l32AD

.l32A3
  LDA dizzyy,X:CLC:ADC &037A,X:STA dizzyy,X
.l32AD
  LDA &0340
  AND #&0C
  BEQ l32CF

  AND #&04
  BEQ l32C5

  LDA dizzyx,X:SEC:SBC &0384,X:STA dizzyx,X

  JMP l32CF

.l32C5
  LDA dizzyx,X
  CLC
  ADC &0384,X
  STA dizzyx,X

.l32CF
  ; Is it < 230
  LDA dizzyx,X
  CMP #&E6
  BCC l32E0

  ; Is it >= 243
  CMP #&F3
  BCS l32E0

.l32DA
  JSR l313F
  JMP l32E7

.l32E0
  ; Is it < 8
  LDA dizzyy,X
  CMP #&08
  BCC l32DA

.l32E7
  LDX &0345

  RTS
}

.l32EB
{
  LDA objs_xlocs,X:STA &033A ; X position
  LDA objs_ylocs,X:STA &033B ; Y position

  LDA #&00
  STA &033C ; attrib
  STA &033F

  LDA objs_frames, X ; frame
  JSR frame

  RTS
}

.l3306
{
  LDA objs_xlocs,X:STA &033A ; X position
  LDA objs_ylocs,X:STA &033B ; Y position

  LDA objs_attrs,X:STA &033C ; attrib
  LDA #&00:STA &033F

  LDA objs_frames,X ; frame
  JSR frame

  LDA #&58:STA &03DC

  RTS
}

; Draw objects for the room we are in
.drawobjects
{
  LDX &03DD
.loop
  CPX #&00
  BNE keepgoing

  ; End of objects, reset
  LDA #noofmoving:STA &03DD
  LDA #&FF:STA &03D5
  RTS

.keepgoing
  DEX
  LDA objs_rooms,X
  BEQ loop ; skip this object if in room 0

  CMP roomno
  BNE loop ; skip this object if not in the room we are in

  LDA objs_xlocs,X:STA &033A ; X position
  LDA objs_ylocs,X:STA &033B ; Y position
  LDA objs_attrs,X:STA &033C ; attrib

  ; Check if this is a non-collectable
  LDY #&00
  CPX #maxcollectable+1
  BCS l3373

  ; This is a collectable object
  AND #&07
  AND &03D5
  ORA #&08
  TAY

  ; Change plot style if this object has moved from it's initial position
  JSR l3384
  LDA &033C:AND #&A7:ORA &FF:STA &033C ; attrib

.l3373
  STY &033F
  LDA #&58:STA &03DC
  LDA objs_frames,X ; frame

  JSR frame

  JMP loop
}

.l3384
{
  ; Set PLOT_OR - object having been moved
  LDA #PLOT_OR:STA &FF

  LDA &03D5
  BEQ done

  ; See if this object is in the room it started in...
  LDA objs_rooms,X
  CMP orig_rooms,X
  BNE done

  ; ...and in the same X position...
  LDA objs_xlocs,X
  CMP orig_xlocs,X
  BNE done

  ; ...and in the same Y position
  LDA objs_ylocs,X
  CMP orig_ylocs,X
  BNE done

  ; It has been moved, so switch to PLOT_AND
  LDA #PLOT_AND:STA &FF

.done
  RTS
}

.getplayerinput
{
  LDA CIA1_PRA ; Read Joystick 2 state
  EOR #&FF ; Make bitfield active high
  AND #%00011111 ; Mask to just Joystick 2
  STA player_input

  JSR mergekeypress

  LDA &03D8
  AND #&10 ; Joystick button pressed ?
  AND player_input
  BEQ l33CA

  LDA player_input:AND #&0F:STA player_input ; Clear FIRE button state
  RTS

.l33CA
  LDA player_input:STA &03D8

  RTS
}

.l33D1
{
  STA &033A

  LDA dizzyx:ASL A:CLC:ADC #&1C:STA dizzyx

  LDA dizzyy:CLC:ADC #&5A:STA dizzyy

  LDX #&02
.loop
  STX &034E
  JSR l313F

  LDA #&01:STA SPR_0_COLOUR,X ; White

  LDA #&33:STA &5FF8,X
  LDA #&04:STA &0384,X
  LDA #&02:STA &037A,X

  INX
  ; Is it < 6
  CPX #&06
  BCC loop

  LDA dizzyx
  SEC
  SBC &033A
  STA &0354
  STA &0355

  LDA dizzyx
  CLC
  ADC &033A
  STA &0356
  STA &0357

  LSR &033A

  LDA dizzyy
  SEC
  SBC &033A
  STA &035E
  STA &0360

  LDA dizzyy
  CLC
  ADC &033A
  STA &035F
  STA &0361

  RTS
}

.l3440
{
  LDX #&05:STX &0346
.loop
  LDX #&02
.innerloop
  STX &034E

  LDA dizzyx,X
  BEQ l345B

  LDA &0366,X

  JSR l3282
  JSR l31EE

  LDX &034E
.l345B
  INX
  ; Is it < 6
  CPX #&06
  BCC innerloop

  LDA #&08:JSR delay

  DEC &0346
  BNE loop

  RTS
}

.l346B
{
  LDA olddizzyx:STA dizzyx
  LDA olddizzyy:STA dizzyy

  LDA #&3C
  JSR l33D1

  LDA #&37:STA &5FF8
  LDX #&00:STX &034E
  JSR l31EE

  LDA #&0A:STA &0368
  LDA #&09:STA &0369
  LDA #&06:STA &036A
  LDA #&05:STA &036B

  LDY #&03
.l349F
  JSR l3440

  DEC &5FF8
  DEY
  BNE l349F

  LDA #&00
  STA &03C8
  STA &03C7
  STA &03C9
  STA &03C2
  STA &5FF8
  STA &03C1

  LDX #&01
.loop
  STX &034E
  JSR l313F

  INX
  ; Is it < 8
  CPX #&08
  BCC loop

  LDA olddizzyx:STA dizzyx
  LDA olddizzyy:STA dizzyy
  LDA SPR_COLLISION
  LDA SPR_COLLISION2
  LDA SPR_COLLISION
  LDA SPR_COLLISION2

  RTS
}

.l34E2
{
  NOP

  LDA #&00
  JSR l33D1

  LDA #&34:STA &5FF8
  LDX #&00:STX &034E
  JSR l31EE

  LDA #TUNE_4:STA melody ; Lose a life / hearts demo melody
  LDA #&05:STA &0368
  LDA #&06:STA &0369
  LDA #&09:STA &036A
  LDA #&0A:STA &036B

  LDY #&0A
.l3510
  JSR l3440

  LDA &5FF8
  ; Is it < 55
  CMP #&37
  BCC l3522

  LDA #&45:STA &5FF8
  JMP l3525

.l3522
  INC &5FF8
.l3525
  DEY
  BNE l3510

  LDX #&00
.l352A
  STX &034E
  JSR l313F

  INX
  ; Is it < 8
  CPX #&08
  BCC l352A

  LDA #&64:JSR delay

  LDA &03B8:STA roomno

  RTS
}

.mergekeypress
{
  ; Check last pressed key
  LDY KEY_PRESSED
  LDX &028D

  ; Load bitfield
  LDA player_input

  CPY #KEY_Z
  BNE checkx

  ; Simulate joystick left
  ORA #JOY_LEFT
  JMP l3558

.checkx
  CPY #KEY_X
  BNE l3558

  ; Simulate joystick right
  ORA #JOY_RIGHT

.l3558
  CPX #&00
  BEQ checkreturn

  ; Simulate joystick up
  ORA #JOY_UP

.checkreturn
  CPY #KEY_RETURN
  BNE done

  ; Simulate joystick fire
  ORA #JOY_FIRE

.done
  STA player_input

  RTS
}

; Get byte at (&05) and advance pointer
.nextchar
{
  SEI
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_RAM+LORAM_A000_RAM:STA CPU_CONFIG
  LDY #&00
  LDA (&05),Y
  INC &05
  BNE samepage

  INC &06

.samepage
  LDY #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_RAM:STY CPU_CONFIG
  CLI

  RTS
}

.prtmessage
{
  ; Cache string id
  STA &03DB

  ; Fetch pointer to string[id]
  ASL A
  TAX

  SEI
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_RAM+LORAM_A000_RAM:STA CPU_CONFIG
  LDA messages,X:STA &05
  LDA messages+1,X:STA &06
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_RAM:STA CPU_CONFIG
  CLI

  ; Read character and advance pointer
.advance
  JSR nextchar

.startmessage
  ; Is it within range (i.e. <= drawbox)
  CMP #drawbox+1
  BCC inrange

  RTS

.inrange
  CMP #drawbox
  BNE notabox

  JSR drawmsgbox
  JMP advance

.notabox
  CMP #mpen
  BCC notapen

  ; Determine which pen (colour) to use
  SEC
  SBC #mpen
  STA &03BF

  JMP advance

.notapen
  CMP #mxy
  BCC notxy

  ; Get X position for cursor
  SEC
  SBC #mxy-32
  STA cursorx

  ; Get Y position for cursor
  JSR nextchar
  STA cursory

  JMP advance

.notxy
  CMP #mend
  BNE notatend

.waitforfire
  JSR getplayerinput

  LDA player_input ; not needed - it's already in A reg
  AND #JOY_FIRE
  BNE waitforfire

.waitfornofire
  JSR getplayerinput

  AND #JOY_FIRE
  BEQ waitfornofire

  ; Check for further dialog box
  JSR nextchar

  CMP #mend
  BNE startmessage

  ; Check which message it was
  LDA &03DB
  BEQ nottitle

  ; Title screen - so reset everything
  JSR resetgamestate

.nottitle
  RTS

.notatend
  ; If it's before alphabet/messagebox frame, convert it to a space
  CMP #SPR_SPEECHOPEN
  BCC clearchar

  ; If it's after "Z", convert to a space
  CMP #SPR_Z+1
  BCC printable

.clearchar
  LDA #SPR_SPACE ; frame

.printable
  LDX cursorx:STX &033A ; X position
  LDX cursory:STX &033B ; Y position
  LDX &03BF:STX &033C ; attrib

  LDX #&00
  STX &033F
  STX &03DC

  JSR frame

  INC cursorx
  INC cursorx

  JMP advance
}

.drawmsgbox
{
  JSR nextchar
  STA &0398

  JSR nextchar
  STA &0399

  LDA #&00:STA SPR_ENABLE ; Hide sprites
  LDA cursorx:CLC:ADC #&02:STA &039A

  LDA #SPR_FRAMETOP
  JSR l36E3

  LDA &0398
  ASL A
  CLC
  ADC &039A
  STA &039A

  LDA #SPR_FRAMETOP
  JSR l36E3

  JSR l3682

.loop
  JSR l36B6
  DEC &0399
  BNE loop

  JSR l3682

  LDA cursory:CLC:ADC #&08:STA cursory
  LDA cursorx:CLC:ADC #&02:STA &039A

  LDA #SPR_FRAMEBOTTOM
  JSR l36E3

  LDA &0398:ASL A:CLC:ADC &039A:STA &039A

  LDA #SPR_FRAMEBOTTOM
  JSR l36E3

  RTS
}

.l3682
{
  LDA cursory:CLC:ADC #&08:STA cursory

  LDA cursorx:STA &039A

  LDA #SPR_FRAMELEFT
  JSR l36E3

  LDA #SPR_FRAMECROSS
  JSR l36E3

  LDA &0398:STA &0344
.loop
  LDA #SPR_FRAMEHORIZ
  JSR l36E3

  DEC &0344
  BNE loop

  LDA #SPR_FRAMECROSS
  JSR l36E3

  LDA #SPR_FRAMERIGHT
  JSR l36E3

  RTS
}

.l36B6
{
  LDA cursory:CLC:ADC #&08:STA cursory
  LDA cursorx:CLC:ADC #&02:STA &039A

  LDA #SPR_FRAMEVERT
  JSR l36E3

  LDA &0398:STA &0344
.loop
  LDA #SPR_SPACE
  JSR l36E3

  DEC &0344
  BNE loop

  LDA #SPR_FRAMEVERT
  JSR l36E3

  RTS
}

.l36E3
{
  LDX &039A:STX &033A ; X position
  LDX cursory:STX &033B ; Y position
  LDX &03BF:STX &033C ; attrib

  LDX #&00
  STX &033F
  STX &03DC

  JSR frame

  ; Advance cursor
  INC &039A
  INC &039A

  RTS
}

.l3707
{
  LDX &18D9
  BNE l370D

  RTS

.l370D
  ASL A
  TAX

  SEI
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_RAM+LORAM_A000_RAM:STA CPU_CONFIG
  CPX #&08
  BNE l372A

  ; Check if bucket is blue
  LDA objs_attrs+obj_bucket
  CMP #PAL_BLUE
  BNE l372A

  LDA &D1C0:STA &05

  LDA &D1C1
  JMP l3732

.l372A
  LDA &D0CA,X:STA &05

  LDA &D0CB,X
.l3732
  STA &06
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_RAM:STA CPU_CONFIG
  CLI

  LDA &06
  BEQ done

.l373D
  JSR nextchar

  ; Is it < 38
  CMP #&26
  BCC done

  ; IS it >= 91
  CMP #&5B
  BCS done

  JSR l36E3

  JMP l373D

.done
  RTS
}

.l374F
{
  LDA #&FF

  LDX #&00
.loop
  STA &18D9,X
  INX
  ; Loop while it is < 5
  CPX #&05
  BCC loop

  LDX #&01
  LDY #&00
.l375F
  LDA objs_rooms,X
  CMP #&04
  BNE l376B

  TXA
  STA &18D9,Y
  INY
.l376B
  INX
  ; Is it < 63
  CPX #&3F
  BCC l375F

  LDA #&00:STA &18D9,Y

  RTS
}

.drawinventory
{
  JSR l374F
  LDX #str_inventory

  ; Check for larger inventory
  LDA objs_rooms+obj_bag
  CMP #collected
  BNE drawbag

  LDX #str_inventorywithbag
.drawbag
  TXA
  JSR prtmessage

  LDY #&58

  ; Check for larger inventory
  LDA objs_rooms+obj_bag
  CMP #collected
  BNE l3793

  LDY #&50
.l3793
  STY cursory
  LDA #&00:STA &0344
  LDA #&03:STA &03BF
.l37A0
  LDA #&2C:STA &039A
  LDX &0344
  LDA &18D9,X
  JSR l3707

  LDX &0344
  LDA &18D9,X
  BEQ l37C5

  INC &0344

  LDA cursory:CLC:ADC #&08:STA cursory
  JMP l37A0

.l37C5
  LDA &18D9
  BNE done

  LDA #str_nothingatallmess:JSR prtmessage

.done
  RTS
}

.printroomname
{
  ; Make sure it's in range
  LDA roomno
  CMP #ATTICROOM+1
  BCS done

  ; Calculate table offset
  ASL A:TAX

  ; Get pointer to room name
  SEI
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_RAM+LORAM_A000_RAM:STA CPU_CONFIG
  LDA roomnames,X:STA &05
  LDA roomnames+1,X:STA &06
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_RAM:STA CPU_CONFIG
  CLI

  ; Set starting X position
  LDX #44
.loop
  ; Get next character to print
  JSR nextchar

  ; Make sure it's not a string terminator
  CMP #&5F
  BNE keepgoing

.done
  RTS

.keepgoing
  STX &033A ; X position

  LDY #24
  STY &033B ; Y position
  STY &03E3

  LDY #PAL_CYAN:STY &033C ; attrib
  LDY #&00:STY &03DC
  JSR frame

  ; Advance cursor
  INX:INX

  ; Next character
  JMP loop
}

.l3814
{
  LDA #&00:STA &03DB

  LDX #46
.loop
  STX &033A ; X position

  LDA #8
  STA &033B ; Y position
  STA &03E3

  LDY #&00
  LDA &03DB
  CMP lives
  BCS l3832

  LDY #&06
.l3832
  STY &033C ; attrib

  LDA #&00:STA &03DC

  LDA #SPR_EGG ; frame
  JSR frame

  INC &03DB
  INX
  INX
  ; Is it < 50
  CPX #&32
  BCC loop

  RTS
}

.heartdemo
{
  JSR l3023

  LDA #&00:STA &03DB
  LDA #TUNE_4:STA melody ; Lose a life / hearts demo melody

.loop
  JSR l3257

  AND #&3F
  CLC
  ADC #&20
  STA &033A ; X position

  JSR l3257

  AND #&7F
  CLC
  ADC #&30
  STA &033B ; Y position

  LDA #&12:STA &033C ; attrib

  LDA #&00
  STA &033F
  STA &03DC

  JSR l326A

  CMP #&04
  BNE l3882

  LDA #&01
.l3882
  CLC
  ADC #SPR_HEARTNULL ; frame
  JSR frame

  LDA #&05:JSR delay

  INC &03DB
  BNE loop

  RTS
}

; Get pointer to sprite in &FB, result in &B4/&B5
.getframepointer
{
  ; Set initial high-byte
  LDA #hi(frametable):STA &FC

  ; Double low-byte
  LDA &FB
  CLC
  ADC &FB
  BCC nooverflow

  INC &FC ; Advance high-byte of pointer due to overflow
.nooverflow
  STA &FB ; Store result

  ; Fetch frame pointer low-byte
  LDY #&00
  LDA (&FB),Y:STA &B4

  ; Fetch frame pointer high-byte
  INY
  LDA (&FB),Y:CLC:ADC #hi(framedefs):STA &B5

  RTS
}

.l38B1
{
  LDA &03C4
  AND #&01
  BNE l38BB

  JMP l3931

.l38BB
  LDX &03E0
  BNE l38C3

  JMP l392A

.l38C3
  LDA &1828,X:SEC:SBC #&04:STA &B3

  LDA &180E,X:STA &B2

  LDA &03DA
  SEC
  SBC #&18
  LSR A
  TAY
  STY &03DB

  JMP l38E4

.l38DE
  LDA (&B2),Y
  AND #&10
  BEQ l3920

.l38E4
  TYA
  ASL A
  CLC
  ADC #&18
  STA &033A ; X position

  LDA &03E0
  ASL A
  ASL A
  ASL A
  STA &033B ; Y position

  LDA roomno
  CMP #ACTIVEVOLCANOROOM
  BNE l3901

  LDA #&0A
  JMP l3903

.l3901
  LDA #&0F
.l3903
  STA &033C ; attrib

  LDA #&00:STA &033F

  LDA &03C4
  LSR A
  AND #&03
  CLC
  ADC #SPR_WATER0 ; frame
  JSR frame

  INC &03DB
  INC &03DB
  INC &03DB
.l3920
  INC &03DB
  ; Is it < 35
  LDY &03DB
  CPY #&23
  BCC l38DE

.l392A
  LDA #&0A
  LDX #&02
  JMP l3935

.l3931
  LDX #&00
  LDA #&02
.l3935
  STA &03DB
  STX &034E
.l393B
  LDA flame_x,X:STA &033A ; X position
  LDA flame_y,X:STA &033B ; Y position

  LDA #&00
  STA &033C ; attrib
  STA &033F
  STA &03DC

  LDA #SPR_FLAME ; frame
  JSR frame

  INX
  CPX &03DB
  BCS l3962

  CPX flameindex
  BCC l393B

.l3962
  LDX &034E
.l3965
  LDA flame_attr,X
  EOR #&80
  STA flame_attr,X
  STA &033C ; attrib

  LDA flame_x,X:STA &033A ; X position
  LDA flame_y,X:STA &033B ; Y position
  LDA #&20:STA &033F
  LDA #&00:STA &03DC
  LDA #SPR_FLAME ; frame
  JSR frame

  INX
  CPX &03DB
  BCS done

  CPX flameindex
  BCC l3965

.done
  RTS
}

; Collecting a coin
.collect_coin
{
  ; Check to see if this object is a coin - just done before entering this function, but hey ?
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LDX &18DE
  CPX #firstcoin
  BCC done

  CPX #lastcoin+1
  BCS done
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Set this coin to "collected", by removing from room
  LDA #OFFMAP
  STA objs_rooms,X
  STA &18DE

  ; Update counter of coins collected so far
  LDA coins:CLC:ADC #1
  ; Is it < 10
  CMP #10
  BCC underten

  ; >= 10 so increment tens
  INC coins_tens

  ; Set units to zero
  LDA #0

.underten
  STA coins ; Update units

  LDA #TUNE_3:STA melody ; Coin collect melody
  JSR drawcoincount

  LDA #str_youfoundcoinmess:JSR prtmessage

  ; Check if muted
  LDA muted
  BNE done

  LDA #TUNE_2:STA melody ; In-game melody

.done
  RTS
}

.collidewithdizzy
{
  ; Check if object[x] is in current room
  LDA objs_rooms,X
  CMP roomno
  BEQ objinroom

.objelsewhere
  CLC ; no collision
  RTS

.objinroom
  ; Get pointer to frame data
  LDA objs_frames,X:STA &FB
  JSR getframepointer

  ; Set up hit-detection around Dizzy ??
  LDA dizzyx:CLC:ADC #&21:STA &033A
  CLC:ADC #&04:STA &033C ; +width ??

  LDA dizzyy:CLC:ADC #&2A:STA &033B
  CLC:ADC #&15:STA &033D ; +height ??

  ; Return if object.x >= dizzy.x (Dizzy to the left)
  LDA objs_xlocs,X
  CMP &033C
  BCS objelsewhere

  ; Return if object.x+object.width <= dizzy.x (Dizzy to the right)
  LDY #&00
  LDA (&B4),Y ; Get object width
  CLC
  ADC objs_xlocs,X ; Add object.x
  CMP &033A
  BCC objelsewhere
  BEQ objelsewhere

  ; Return if object.y >= dizzy.y (Dizzy above)
  LDA objs_ylocs,X ; Get object.y
  CMP &033D
  BCS objelsewhere

  ; Return if object.y+object.height <= dizzy.y (Dizzy below)
  INY
  CLC
  ADC (&B4),Y ; Add object height
  CMP &033B
  BCC objelsewhere
  BEQ objelsewhere

  SEC ; collision

  RTS
}

; Print coins collected counter to screen
.drawcoincount
{
  LDA #78:STA &033A ; X position
  LDA #&00:STA &03DC

  LDA #8
  STA &033B ; Y position
  STA &03E3

  LDA #PAL_YELLOW:STA &033C ; attrib

  ; Convert tens to ASCII
  LDA coins_tens
  CLC:ADC #'0' ; frame

  JSR frame

  LDA #80:STA &033A ; X position
  LDA #&00:STA &03DC

  LDA #8
  STA &033B ; Y position
  STA &03E3

  LDA #PAL_YELLOW:STA &033C ; attrib

  ; Convert units to ASCII
  LDA coins
  CLC:ADC #'0' ; frame

  JSR frame

  RTS
}

.l3A71
{
  TAX
  LDA &1897,X:STA &033C

  LDA #&0B

  ; Check for larger inventory (bag collected)
  LDX objs_rooms+obj_bag
  CPX #collected
  BNE l3A83

  LDA #&0A
.l3A83
  CLC
  ADC &03D9
  TAX
  LDA &180E,X:STA &FB
  LDA &1828,X:STA &FC

  LDY #&09
  LDA &033C
.loop
  STA (&FB),Y
  INY
  ; Is it < 31
  CPY #&1F
  BCC loop

  RTS
}

.l3A9F
{
  LDA &03BA:CLC:ADC #&08:STA &03DB

  LDX &03BA
.loop
  ; Is it < 50
  CPX #&32
  BCC l3AD5

  ; Is it >= 68
  CPX #&44
  BCS l3AD5

  STX &033A ; X position

  LDA &C81B:STA &033B ; Y position
  LDA #&06
  CPX &03DB
  BCC l3AC5

  LDA #&00
.l3AC5
  STA &033C ; attrib

  LDA #&00
  STA &033F
  STA &03DC

  LDA #SPR_DRAGONFIRE ; frame
  JSR frame

.l3AD5
  INX
  INX
  CPX &03DB
  BEQ loop

  BCC loop

  LDX #obj_dragonhead
  LDA #&00:STA &03DC
  JSR l3306

  RTS
}

; Cheat mode key-sequence
.eclipse
  EQUB KEY_E
  EQUB KEY_S
  EQUB KEY_P
  EQUB KEY_I
  EQUB KEY_L
  EQUB KEY_C
  EQUB KEY_E

; Room number adjustments based on key pressed
.roomchange
  EQUB 0
  EQUB 16   ; Go up (+16)
  EQUB 0-16 ; Go down (-16)
  EQUB 0
  EQUB 0-1  ; Go left (-1) "Z"
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 1    ; Go right (+1) "X"
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0

.l3B00
{
  LDX #&00

.nextchar
  ; check last key pressed
  LDA KEY_PRESSED
  CMP eclipse,X
  BEQ awaitchar

  RTS

.awaitchar
  ; Wait for last key pressed to change
  LDA KEY_PRESSED
  CMP eclipse,X
  BEQ awaitchar

  ; Move on to check next character of cheat code
  INX
  CPX #7
  BCC nextchar

  ; ### Cheat mode activate ###

.l3B16 ; &3B16

  LDA #&00:STA SPR_ENABLE ; Hide sprites
  LDA #2:STA lives ; Reset lives

  JSR l3814
.cheatloop
  LDA #&32:JSR delay

  JSR getplayerinput
  AND #&1F
  ; Is it >= 16
  CMP #&10
  BCS done

  AND #&0F
  TAX
  LDA roomchange,X
  BEQ cheatloop

  CLC:ADC roomno ; Calculate new room number

  ; Is it < 21
  CMP #MARKETSQUAREROOM-1
  BCC cheatloop

  ; Is it >= 168 - odd because highest used room number is 100 (attic)
  CMP #168
  BCS cheatloop

  STA roomno

  JSR l2F22 ; ?? Redraw room ??

  LDA #&00:STA SPR_ENABLE ; Hide sprites
  JMP cheatloop

.done
  LDA #&FF:STA SPR_ENABLE ; Show sprites
  RTS
}

; ?? Unreachable code ??
{
  ; $DD00 = %xxxxxx11 -> Bank0: $0000-$3FFF
  LDA #&C7:STA CIA2_PRA

  LDA #&1B:STA GFX_VICII_REG1 ; rst8|ecm|bmm|DEN|RSEL|YSCROLL - Bitmap
  LDA #&15:STA GFX_MEM_PTR
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_ROM:STA CPU_CONFIG

  RTS
}

.l3B6D
{
  ; $DD00 = %xxxxxx10 -> Bank1: $4000-$7FFF
  LDA #&C6:STA CIA2_PRA

  LDA #&3B:STA GFX_VICII_REG1 ; rst8|ecm|BMM|DEN|RSEL|YSCROLL - Character

  ; $D018 = %xxxx100x -> CharMem is at $2000 (#8192)
  ; $D018 = %0111xxxx -> ScreenMem is at $1c00 (#7168)
  LDA #&78:STA GFX_MEM_PTR

  LDA #&00:STA GFX_BORDER_COLOUR

  LDA #&FF:STA &03DF
  LDA #&B8:STA &03E1
  LDA #&30:STA &03E3
  LDA #&58:STA &03DC

  RTS
}

ORG &4000
INCLUDE "dizzy_sprites.asm"
; &5180 - end of sprite bitmaps

.v5800 ; []
.v5900 ; []
.s5A00 ; to ???? = solidity bitmap ????
.s5C00 ; to 5FE7 = 8x8 screen/border colour attribs
.v5FF8 ; []

ORG &6000
; &6000..&7F3F = screen RAM (320x200 hires bitmap mode, $d011=$3b, $d016=8)
INCBIN "screendump.bin"

ORG &7F40
.l7F40
{
  ; $DD00 = %xxxxxx10 -> Bank1: $4000-$7FFF
  LDA #&C6:STA CIA2_PRA

  LDA #&3B:STA GFX_VICII_REG1 ; rst8|ecm|BMM|DEN|RSEL|YSCROLL - Character

  ; $D018 = %xxxx100x -> CharMem is at $2000 (#8192)
  ; $D018 = %0111xxxx -> ScreenMem is at $1c00 (#7168)
  LDA #&78:STA GFX_MEM_PTR

  LDA #&00:STA GFX_BORDER_COLOUR

  RTS
}

ORG &8000
INCBIN "roomdata.bin"

  EQUB &00, &00, &00, &00, &00, &00, &00, &00, &00
  EQUB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
  EQUB &00, &00, &dd, &8e, &18, &d4, &ca, &8e, &02, &dc, &a9, &07, &8d, &00, &dd, &a9

; &A400
; Horizontal flip look up table
.flip_lut
  EQUB &00, &80, &40, &c0, &20, &a0, &60, &e0, &10, &90, &50, &d0, &30, &b0, &70, &f0
  EQUB &08, &88, &48, &c8, &28, &a8, &68, &e8, &18, &98, &58, &d8, &38, &b8, &78, &f8
  EQUB &04, &84, &44, &c4, &24, &a4, &64, &e4, &14, &94, &54, &d4, &34, &b4, &74, &f4
  EQUB &0c, &8c, &4c, &cc, &2c, &ac, &6c, &ec, &1c, &9c, &5c, &dc, &3c, &bc, &7c, &fc
  EQUB &02, &82, &42, &c2, &22, &a2, &62, &e2, &12, &92, &52, &d2, &32, &b2, &72, &f2
  EQUB &0a, &8a, &4a, &ca, &2a, &aa, &6a, &ea, &1a, &9a, &5a, &da, &3a, &ba, &7a, &fa
  EQUB &06, &86, &46, &c6, &26, &a6, &66, &e6, &16, &96, &56, &d6, &36, &b6, &76, &f6
  EQUB &0e, &8e, &4e, &ce, &2e, &ae, &6e, &ee, &1e, &9e, &5e, &de, &3e, &be, &7e, &fe
  EQUB &01, &81, &41, &c1, &21, &a1, &61, &e1, &11, &91, &51, &d1, &31, &b1, &71, &f1
  EQUB &09, &89, &49, &c9, &29, &a9, &69, &e9, &19, &99, &59, &d9, &39, &b9, &79, &f9
  EQUB &05, &85, &45, &c5, &25, &a5, &65, &e5, &15, &95, &55, &d5, &35, &b5, &75, &f5
  EQUB &0d, &8d, &4d, &cd, &2d, &ad, &6d, &ed, &1d, &9d, &5d, &dd, &3d, &bd, &7d, &fd
  EQUB &03, &83, &43, &c3, &23, &a3, &63, &e3, &13, &93, &53, &d3, &33, &b3, &73, &f3
  EQUB &0b, &8b, &4b, &cb, &2b, &ab, &6b, &eb, &1b, &9b, &5b, &db, &3b, &bb, &7b, &fb
  EQUB &07, &87, &47, &c7, &27, &a7, &67, &e7, &17, &97, &57, &d7, &37, &b7, &77, &f7
  EQUB &0f, &8f, &4f, &cf, &2f, &af, &6f, &ef, &1f, &9f, &5f, &df, &3f, &bf, &7f, &ff

ORG &A500
.frametable
INCBIN "frametable.bin"
.framedefs
INCBIN "framedefs.bin"

ORG &C400
INCLUDE "objects.asm"

ORG &D000
INCLUDE "strings.asm"

ORG &FFFF
.c64end

SAVE "c64_built", c64start, c64end
