INCLUDE "consts.asm"
INCLUDE "sprites.asm"
INCLUDE "hardware.asm"

ORG &00

.c64start

; Variables
stringptr = &05 ; pointer to current character of string

.v0035 ; pointer to string memory (5A77 / 5A4D / 5A5D / 581C / 5AF0)
.v0036

.v00A7 ; pointer (148D / 14EB / 1502 / 1397 / 14F2 / 14FE)
.v00A8

melody_ptr = &00A9

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

frmx = &033A ; X position
tmp1 = &033A
frmy = &033B ; Y position
frmattr = &033C ; attrib
tmp3 = &033C
.v033D
.v033E
hitbitflags = &033F ; hit-detection bitmap flags
.v0340 ; frame
.v0342 ; ?? inc and dec, set to 01/03/06 ?? maybe jump/gravity related ??
cursorindex = &0344
.v0345 ; cache for X reg
.v0346 ; cache for X reg, and index
.v0347 ; cache for Y reg, and index
.v0349
.v034A
.v034B
.v034E ; cache for X reg, ??
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
.v0366 ; [2]
.v0368
.v0369
.v036A
.v036B
.v0370 ; [10]
.v037A ; [10] related to dizzyy
.v0384 ; [20?] related to dizzyx
msgbox_width = &0398
msgbox_height = &0399
.v039A
cursorx = &039B ; char cursor X
cursory = &039C ; char cursor Y
index = &03B7
deathid = &03B7
olddizzyroom = &03B8 ; roomno to reincarnate into
lives = &03B9
dragonflamepos = &03BA ; 0=no flames. Active range is 66 down to 42
.v03BB
.v03BC
.v03BD ; armorog related
liftwait = &03BE ; timeout to delay lift movement when lift changes direction
cursorattr = &03BF ; char attrib
player_input = &03C0
.v03C1 ; set to 0/1/2, related to movement/animation
player_direction = &03C2 ; sprite animation direction
.v03C3 ; ?? sprite animation frame related ??
gamecounter = &03C4 ; pace of game actions
.v03C5 ; incremented index into ?? strings table ??
.v03C6 ; byte read using index from &03C5
.v03C7 ; ?? animation sequence related ??
.v03C8 ; ?? movement or animation related 0/1/2/3 ??
.v03C9 ; ?? sprite animation frame related ??
.v03D5 ; set to &FF and &00
olddizzyx = &03D6 ; position where Dizzy entered current room
olddizzyy = &03D7 ;   used for where to reincarnate to
.v03D8 ; input related
inventoryindex = &03D9
usedobj = &03D9 ; id of objected being interacted with from inventory
.v03DA ; related to X position of water frames, set to 0
.v03DB ; multi-purpose
attrib_offset = &03DC ; location of screen attribs to use, &00 = &5C00, &58 = &0400
.v03DD ; max object id to draw
.v03DF ; mostly set to &FF, but can take the value of &03E2 when non-zero
.v03E0 ; set to 0 when entering rooms, can be frmy/8
.v03E1 ; always &B8 (184), compared against frmy
.v03E2 ; related to c64 palette conversion and attributes
.v03E3 ; Y related when printing text, set to 8 (lives/coins), 24 (room name), and 48 ??
roomno = &03E5

; This just seems to always be full of &20 ??
otherattribs = &0400 ; Set of screen attributes

attr_offs_screen = hi(&5C00 - &5C00)
attr_offs_other = hi(&5C00 - otherattribs)

ORG &0B00

; Current music playing
.melody
{
  EQUB TUNE_CONT
}

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

  ; Copy 3 channel pointers for new melody to current melody
  {
    LDX #&00
.loop
    LDA melodyconfigs,Y:STA melodychanptr_lo,X ; lo
    INY

    LDA melodyconfigs,Y:STA melodychanptr_hi,X ; hi
    INY

    INX
    CPX #&03
    BNE loop
  }

  {
    LDX #&02
.loop
    LDA #&00
    STA &1188,X
    STA &118B,X
    STA melody_chan_pos,X ; Set melody channel data pos to start

    JSR l0FC3

    DEX
    BPL loop
  }

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
  STA SID_VOL_FLT

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
  CLC:ADC &1191,X
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
  CLC:ADC &1191,X
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
  CLC:ADC &11C2
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
  CLC:ADC #&0D ; +13
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
  SEC:SBC &10E6,Y
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
  SEC:SBC &11B9
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
  CLC:ADC &11B9
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
  CLC:ADC &1169,X
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
  CLC:ADC &1188,X
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
  CLC:ADC &1252,Y

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
  SEC:SBC &1252,Y

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

  ; Fall through
}

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
  {
  STA &D400,Y
  DEY
  BPL loop
  }

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
  {
  ROR &11BB
  BCC l0FB0

  LDA &115E,X:STA &11CD,Y
  INY
.l0FB0
  INX
  CPX #&08
  BNE loop
  }

  LDX &116C
  LDA #&FF:STA &11CD,Y
  LDA #&00:STA &1194,X

  RTS
}

; X reg is the sound channel (0/1/2)
.l0FC3
{
  LDA melodychanptr_lo,X:STA melody_ptr ; lo
  LDA melodychanptr_hi,X:STA melody_ptr+1 ; hi

.loop
  {
  LDY melody_chan_pos,X ; Get channel offset
  INC melody_chan_pos,X ; Advance channel offset

  LDA (melody_ptr),Y ; Read from music data pointer
  BPL l0FEB

  CMP #&FF ; Is this the channel EOF
  BNE keepgoing

  ; Loop back to start of data for this channel
  LDA #&00:STA melody_chan_pos,X
  BEQ loop
  }

.keepgoing
  CLC:ADC #&40 ; +64
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
  {
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
  }

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

.v1085 ; [1]
.v1086 ; [96]

.v10E6 ; [1]
.v10E7 ; [96]

ORG &1147

.l1147
{
  JSR l0F78

  LDA #&0F:STA SID_VOL_FLT ; Set volume 100%

  LDA #&00
  STA &116F
  STA &116D

  RTS
}

.v1158 ; [3]
.v115B ; [3]
.v115E ; [8]
.v1166 ; [3]
.v1169 ; [3]
.v116C
.v116D
.v116E
.v116F

ORG &1170
.melody_chan_pos ; [3]
{
  EQUB &14 ; Channel 1 melody data pos
  EQUB &11 ; Channel 2 melody data pos
  EQUB &11 ; Channel 3 melody data pos
}

.v1173 ; [3]
.v1176 ; [3]
.v1179 ; [3]
.v117C ; [3]

ORG &117F
; These are *variable* pointers in the range &1399..&1431 (melody data)
.v117F ; pointers lo [3]
{
  EQUB &99
  EQUB &E2
  EQUB &31
}

.v1182 ; pointers hi [3]
{
  EQUB &13
  EQUB &13
  EQUB &14
}

.v1185 ; [3]
.v1188 ; [3]
.v118B ; [3]
.v118E ; [3]
.v1191 ; [3]
.v1194 ; [3]
.v1197 ; [3]
.v119A
.v119B
.v119C
.v119D ; [3]
.v11A0 ; [3]
.v11A3 ; [3]
.v11A6 ; [3]
.v11A9
.v11AA
.v11AB ; [3]
.v11AE ; [3]
.v11B1 ; [3]
.v11B4 ; [3]
.v11B7
.v11B8
.v11B9
.v11BA
.v11BB

ORG &11BC
  ; Current melody
.melodychanptr_lo ; [3]
{
  EQUB &0F
  EQUB &3D
  EQUB &65
}
.melodychanptr_hi ; [3]
{
  EQUB &13
  EQUB &13
  EQUB &13
}

.v11C2
.v11C3 ; [3]
.v11C6 ; [3]
.v11C9 ; [1]
.v11CA
.v11CB
.v11CC
.v11CD ; [16]
.v11ED ; [1]
.v11EE ; [1]
.v11EF ; [1]
.v11F0 ; [37]
.v1215 ; [16]
.v1225 ; [16]

ORG &1235
.melodyconfigs ; [24]
{
  ; Melody 1 - Title screen
  EQUW m1c1
  EQUW m1c2
  EQUW m1c3

  ; Melody 2 - In-game
  EQUW m2c1
  EQUW m2c2
  EQUW m2c3

  ; Melody 3 - Coin collect
  EQUW m3c1
  EQUW m3c2
  EQUW m3c3

  ; Melody 4 - Lose a life / Heart demo
  EQUW m4c1
  EQUW m4c2
  EQUW m4c3
}

.v124D ; [1]
.v124E ; [1]
.v124F ; [1]
.v1250 ; [1]
.v1251 ; [1]
.v1252 ; [1]
.v1253 ; [1]
.v1254 ; [137]
.v12DD ; [1]
.v12DE ; [49]

ORG &130F
INCLUDE "melodydata.asm"

ORG &180E
; These static pointers are to data in the range &5c00..&5fc0 (screen/border colour attribs)
;   at 40 characters per row
.screenattrtable_lo ; [25] pointers lo
{
  FOR n, 0, CHAR_ROWS-1
    EQUB lo(screen_attribs+(n*CHAR_COLUMNS))
  NEXT
}

.u1827
  EQUB &5B ; ??? not sure what this is for ???

.screenattrtable_hi ; [25] pointers hi
{
  FOR n, 0, CHAR_ROWS-1
    EQUB hi(screen_attribs+(n*CHAR_COLUMNS))
  NEXT
}

.v1877 ; [32]

ORG &1897
.c64palette ; spectrum to c64 palette lookup [8]
{
  EQUB &00 ; black
  EQUB &60 ; blue
  EQUB &20 ; red
  EQUB &40 ; magenta
  EQUB &50 ; green
  EQUB &30 ; cyan
  EQUB &70 ; yellow
  EQUB &10 ; white
}

; Lookup table for screen offsets, for the start of each row
.screentable_lo
{
  FOR n, 0, CHAR_ROWS-1
    EQUB lo(screen_memory+(n*CHAR_COLUMNS*8))
  NEXT
}
.screentable_hi
{
  FOR n, 0, CHAR_ROWS-1
    EQUB hi(screen_memory+(n*CHAR_COLUMNS*8))
  NEXT
}

ORG &18D9
.inventorylist ; Objects carried list [5]
{
  EQUB obj_null, obj_null, obj_null, obj_null, obj_null
}

pickupobj = &18DE ; object table offset / obj_null / ????
coins_tens = &18E5
coins = &18E6
.v18E7 ; not used ?? only ever set to 0 when coin counters reset

ORG &18E8
.liftrooms ; rooms with lifts in machine/key order [4]
{
  EQUB DOZYSHUTROOM
  EQUB DRAGONSLAIRROOM
  EQUB LIFTTOELDERSROOM
  EQUB LIFTCONTROLROOM
}

.highestliftpos ; lifts upper Y position in machine/key order [4]
{
  EQUB 96  ; Keep out! Dozy's hut
  EQUB 88  ; The dragon's lair
  EQUB 96  ; Lift to the elders
  EQUB 136 ; The lift control hut
}

.lowestliftpos ; lifts lower Y position in machine/key order [4]
{
  EQUB 152 ; Keep out! Dozy's hut
  EQUB 174 ; The dragon's lair
  EQUB 172 ; Lift to the elders
  EQUB 176 ; The lift control hut
}

.v18F4 ; ?? copied from highestliftpos, related to lift Y position ?? [4]
{
  EQUB 0, 0, 0, 0
}

.deadlyobj ; objects that can kill Dizzy on contact [11]
{
  EQUB obj_grunt
  EQUB obj_portcullis

  EQUB obj_lifttop1
  EQUB obj_lifttop2
  EQUB obj_lifttop3
  EQUB obj_lifttop4

  EQUB obj_hawk
  EQUB obj_rat

  EQUB obj_dagger1
  EQUB obj_dagger2
  EQUB obj_dagger3
}
numdeadlyobj = * - deadlyobj

.deathmessages ; death message string table offsets for deadly obj (above) [11]
{
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
}

; Entry point ??

.l190E
  JSR install_ISR

  ; Zero-out &033A to &03FF
  LDX #&C6
  LDA #&00
.zerovar_loop
  {
  STA &033A-1,X
  DEX
  BNE zerovar_loop
  }

  JSR l3B6D
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_RAM:STA CPU_CONFIG
  LDA #TUNE_10:STA melody ; There is no melody 10 ??
.titlescreen
  LDA #&00
  STA GFX_BORDER_COLOUR ; 0 = Black
  STA lives

  ; loop from 0..7
  LDX #&00
.l1931
  {
  JSR l313F

  INX
  ; Is it < 8
  CPX #&08
  BCC l1931
  }

  LDA #TUNE_1:STA melody ; Title screen melody
  LDA #HIT_EMPTY:STA hitbitflags

  JSR l3B6D
  JSR cleargamescreen

  LDA #attr_offs_other:STA attrib_offset
  LDA #TITLEROOM:STA roomno

  JSR l2E79
  JSR convertpalette
  JSR drawcoincount

  LDA #58:STA frmx ; X position
  LDA #57:STA frmy ; Y position
  LDA #PAL_GREEN:STA frmattr ; attrib
  LDA #attr_offs_screen:STA attrib_offset

  LDA #SPR_DIZZYLOGO ; frame
  JSR frame

  JSR printroomname

  LDA #str_startmess:JSR prtmessage

  JSR cleargamescreen

  ; Clear &5800 to &5BE7 - spectrum palette screen attribs
  LDX #&00
  TXA
.clearattrloop
  {
  STA spec_screen_attribs+(&C8*0),X
  STA spec_screen_attribs+(&C8*1),X
  STA spec_screen_attribs+(&C8*2),X
  STA spec_screen_attribs+(&C8*3),X
  STA spec_screen_attribs+(&C8*4),X

  INX
  ; Is it < 200
  CPX #&C8
  BCC clearattrloop
  }

  ; Reset coins collected count
  LDA #&00
  STA coins_tens
  STA coins
  STA &18E7

  ; Reset lives
  LDA #&02:STA lives

  ; Duplicate highestliftpos array
  LDX #&00
.liftloop
  {
  LDA highestliftpos,X:STA v18F4,X

  INX:CPX #numlifts
  BCC liftloop
  }

  LDA #GAMESTARTROOM
  STA olddizzyroom
  STA roomno

  LDA #COLOUR_WHITE:STA SPR_0_COLOUR

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
  {
  DEX
  LDA orig_rooms,X:STA objs_rooms,X ; room
  LDA orig_xlocs,X:STA objs_xlocs,X ; X position
  LDA orig_ylocs,X:STA objs_ylocs,X ; Y position
  LDA orig_attrs,X:STA objs_attrs,X ; attrib
  LDA orig_frames,X:STA objs_frames, X ; frame

  CPX #&00
  BNE movingloop
  }

  JSR initobjs

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
  JMP titlescreen

.checkpause
  CPY #KEY_P
  BNE checkmute

  ; Wait until no keys pressed
.pauseloop
  {
  JSR mergekeypress

  CPY #KEY_NONE
  BNE pauseloop
  }

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
  JSR checkcheatmode
  JSR getplayerinput

  LDA #&00:STA &03C1
  LDA &03BC:JSR delay
  INC gamecounter

  ; Check brandy bottle
  LDA objs_rooms+obj_brandy
  CMP #OFFMAP
  BNE sober

  LDA gamecounter
  AND #&20
  BNE sober

  ; Mess up player input (mimic being drunk)
  LDA player_input
  EOR #JOY_RIGHT+JOY_LEFT
  STA player_input

.sober
  LDA liftwait
  BEQ l1A9E

  DEC liftwait
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
  LDA #22:STA frmy
  LDA #1:STA frmx
.l1AEB
  INC frmx

  ; Is it >= 6
  LDA frmx
  CMP #&06
  BCS l1B04

  JSR l3154 ; ?? hit detection (+22 Y, +1..5 X) ??

  BEQ l1AEB ; = 1

  LDA hitbitflags
  AND #HIT_SOLID
  BEQ l1AEB

  JMP l1B0C

.l1B04
  LDA #&03:STA &03C8

  INC dizzyy ; apply gravity whilst walking left and right
.l1B0C
  LDA &03C8
  CMP #&03
  BNE l1B68

  LDA #22:STA frmy
  LDA #1:STA frmx
.l1B1D
  INC frmx

  ; Is it >= 6
  LDA frmx
  CMP #&06
  BCS l1B58

  JSR l3154 ; ?? hit detection ??

  LDA &033E
  BEQ l1B1D

  LDA hitbitflags
  AND #HIT_SOLID
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
  LDA player_direction:STA &03C7
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
  LDA #ANIM_LEFT
.l1B82
  STA &03C7
  STA player_direction

  LDA #&01:STA &03C8

  JMP l1B95

.l1B90
  LDA #ANIM_RIGHT
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

  LDA #ANIM_IDLE
  STA &03C7
  STA player_direction

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
{
  LDA #0:STA frmy
  LDA #1:STA frmx
.loop
  {
  INC frmx

  ; Is it >= 6
  LDA frmx
  CMP #6
  BCS l1BFD

  JSR l3154 ; ?? hit detection (+1..5 X, Y) ??
  BEQ loop ; = 1
  BCC loop ; < 0
  }

  LDA #&02:STA &03C1
  JMP l1C85
}

.l1BFD
{
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
}

.l1C15
{
  JSR l1C62

  ; Fall through
}

.l1C18
{
  LDA #22:STA frmy
  LDA #1:STA frmx

  LDA &03C9
  CMP &03C3
  BCC l1C85

.loop
  {
  INC frmx

  ; Is it >= 6
  LDA frmx
  CMP #6
  BCS l1C3E

  JSR l3154 ; ?? hit detection (+1..5 X, +22 Y) ??
  BEQ loop ; = 1
  BCC loop ; < 1
  }

  JMP l1C51
}

.l1C3E
{
  INC dizzyy ; apply gravity whilst jumping/rolling
  DEC &0342
  LDA &0342
  BNE l1C18

  LDA #&00:STA &03C3

  JMP l1C85
}

.l1C51
{
  ; Is it >= 17
  LDA &03C9
  CMP #&11
  BCS l1C5D

  LDA #&01:STA &03C1
.l1C5D
  LDA #&00

  JMP l1C85
}

; 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 ...
;  6  6  4  4  4  4  4  2  2  2  2  4  4  4  4  4  6  6 ...
.l1C62
{
  ; Is it < 7
  LDA &03C9
  CMP #&07
  BCC l1C72

  ; Is it >= 11
  CMP #&0B
  BCS l1C72

  LDA #&02 ;;;;;;
  JMP l1C81

.l1C72
  ; Is it < 2
  CMP #&02
  BCC l1C7F

  ; Is it >= 16
  CMP #&10
  BCS l1C7F

  LDA #&04 ;;;;;;
  JMP l1C81

.l1C7F
  LDA #&06 ;;;;;;

.l1C81
  STA &0342 ; Set jump height

  RTS
}

.l1C85
{
  ; Is it >= 2
  LDA &03C8
  CMP #&02
  BCS l1CA8

  CMP #&00
  BEQ l1C96

  DEC &03C8

  JMP l1CA8
}

.l1C96
{
  STA &03C8
  STA &03C7
  STA &03C3
  STA &03C9
  STA &03C1

  JMP l1CB9
}

.l1CA8
{
  LDA &03C7
  BNE l1CB0

  JMP l1CB9
}

.l1CB0
{
  CMP #&01
  BEQ l1CCB

  LDA #&00
  JMP l1CCD
}

.l1CB9
{
  LDA &03C1
  CMP #&01
  BNE l1CC8

  LDA #&00:STA &03C1
  JMP l1BDA
}

.l1CC8
{
  JMP l1D41
}

.l1CCB
{
  LDA #&07
.^l1CCD
  STA frmx
  LDA #12:STA frmy
  JSR l3154 ; ?? hit detection (+0 or +7 X, +12 Y) ??
  BCC l1CFC ; < 1

  LDA &03C1
  CMP #&02
  BNE l1CE9

  LDA #&00:STA &03C1
  JMP l1CF7
}

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
  LDA #12:STA frmy
  JSR l3154 ; ?? hit detection (+?? X, +12 Y) ??
  BCS l1CB9 ; >= 1

  LDA #12:STA frmy
  JSR l3154 ; ?? hit detection (+?? X, +12 Y) ??
  BCC l1D12 ; < 1
  BNE l1CB9 ; != 1

.l1D12
  LDA #13:STA frmy
  JSR l3154 ; ?? hit detection (+?? X. +13 Y) ??
  BCC l1D1E ; < 1
  BNE l1CB9 ; != 1

.l1D1E
  LDA &03C9
  BEQ l1D2E

  ; Is it >= 9
  CMP #&09
  BCS l1D2E

  LDA hitbitflags
  AND #HIT_SOLID
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

{
  LDA #22:STA frmy
  LDA #0:STA frmx
.loop
  {
  INC frmx

  ; Is it >= 6
  LDA frmx
  CMP #6
  BCS l1D7C

  JSR l3154 ; ?? hit detection (+0..5 X, +22 Y) ??
  BCC loop ; < 1
  BEQ loop ; = 1
  }

  LDA #&00
  STA &03C8
  STA &03C7
  STA &03C9
  STA &03C3

  ; Fall through
}

.l1D7C
{
  LDA #21:STA frmy
.loop
  {
  LDA #1:STA frmx
.innerloop
  {
  INC frmx

  ; Is it >= 6
  LDA frmx
  CMP #6
  BCS l1D9D

  JSR l3154 ; ?? hit detection (+1..5 X, +21..18 Y) ??
  BCC innerloop ; < 1
  BEQ innerloop ; = 1
  }

  DEC dizzyy ; go up due to stairs
  JMP l1D41

.l1D9D
  DEC frmy

  ; Is it >= 18
  LDA frmy
  CMP #18
  BCS loop
  }

  ; Fall through
}

.checkright
{
  ; Check Dizzy X position < 57 (not gone off screen to right)
  LDA dizzyx
  CMP #57
  BCC checkleft

  ; Dizzy has gone off screen to the right
  LDA #2:STA dizzyx ; Set Dizzy position to far left
  INC roomno ; Go right

  JMP enternewroom
}

.checkleft
{
  ; Check Dizzy X position >= 2 (not gone off screen to left)
  CMP #2
  BCS checkvertical

  ; Dizzy has gone off screen to the left
  LDA #56:STA dizzyx ; Set Dizzy position to far right
  DEC roomno ; Go left

  JMP enternewroom
}

.checkvertical
{
  ; Check Dizzy Y position < 128
  LDA dizzyy
  CMP #128
  BCC setdizzyspritepos

  ; Check Dizzy Y position >= 192
  CMP #192
  BCS l1DE7

  LDA #0:STA dizzyy ; Set Dizzy position to top
  LDA roomno:SEC:SBC #16:STA roomno ; Go down

  ; Check for entering/leaving Australia
  JSR check_oz

  JMP enternewroom
}

.l1DE7
{
  ; Check Dizzy Y position < 192 - this will _never_ be the case
  LDA dizzyy
  CMP #192
  BCC setdizzyspritepos

  ; Dizzy is going up a screen
  LDA #114:STA dizzyy ; Set Dizzy position to bottom
  LDA roomno:CLC:ADC #16:STA roomno

  ; Fall through
}

.enternewroom
{
  ; Has Dizzy just entered the East Wing?
  ;   If so, dont't store where he came from (incase it was from above onto the daggers)
  LDA roomno
  CMP #EASTWINGROOM
  BEQ donecacheentry

  ; Store where Dizzy entered the room from - used after death
  STA olddizzyroom
  LDA dizzyx:STA olddizzyx
  LDA dizzyy:STA olddizzyy

.donecacheentry
  LDA #&00:STA &03E0

  LDA roomno
  JSR l2F22

.^setdizzyspritepos
  ; Set Dizzy hardware sprite Y position
  LDA dizzyy:CLC:ADC #90:STA SPR_0_Y

  ; Set Dizzy hardware sprite X position
  LDA dizzyx
  ASL A       ; * 4
  ASL A       ;
  CLC:ADC #56 ; + 56
  STA SPR_0_X

  ; Check for overflow
  BCC sprite_lhs

  ; Overflow happened (Dizzy at far rhs), so set bottom bit
  LDA SPR_MSB_X:ORA #&01

  JMP l1E40
}

.sprite_lhs
{
  ; No overflow (Dizzy not at far rhs), so clear bottom bit
  LDA SPR_MSB_X:AND #&FE

  ; Fall through
}

.l1E40
{
  STA SPR_MSB_X

  LDA &03C8
  BNE l1E55

  LDA &03C7
  BNE l1E7E

  ; ?? Set sprite for "idle" animation ??
  LDA gamecounter
  AND #&01
  JMP l1E9E
}

.l1E55
{
  CMP #&02
  BNE l1E7E

  LDA &03C7
  BNE l1E63

  LDA #ANIM_JUMP_UP ; Jump straight up animation
  JMP set_jump_animation
}

.l1E63
{
  CMP #&01
  BNE l1E6C

  LDA #ANIM_JUMP_RIGHT ; Jump right animation
  JMP set_jump_animation
}

.l1E6C
{
  LDA #ANIM_JUMP_LEFT ; Jump left animation
.^set_jump_animation
  STA &FF

  LDA &03C9
  SEC:SBC #&01
  AND #&07
  CLC:ADC &FF
  JMP l1E9E
}

.l1E7E
{
  ; Check animation direction
  LDA player_direction
  BEQ l1E9E ; No direction

  JSR l2AB7

  ; Check for right animation direction
  LDA player_direction
  CMP #ANIM_RIGHT
  BNE goingleft

  LDA #ANIM_WALK_RIGHT ; Walk right animation
  JMP set_walk_animation

.goingleft
  LDA #ANIM_WALK_LEFT ; Walk left animation

.set_walk_animation
  STA &FF

  ; Set current animation frame
  LDA gamecounter
  AND #&07
  CLC:ADC &FF ; add offset

  ; Fall through
}

.l1E9E
{
  JSR checkfordownunder

  STA sprite_pointer ; Update Dizzy hardware sprite
  LDA #&FF:STA SPR_ENABLE ; Show sprites
  LDA &03C7
  CMP #&02
  BEQ checkshopkeeper

  ; Check for collision with troll
  LDX #prox_troll ; CASTLEDUNGEONROOM, 80x160
  JSR collidewithdizzy
  BCC checkshopkeeper

  ; Collide with troll
  LDA #str_getbackintheremess:JSR prtmessage

  LDA #&00
  STA &03C7
  STA &03C8

  ; Set Dizzy tumbling left
  LDA #JOY_LEFT+JOY_UP:STA player_input
  JMP l1B68
}

.checkshopkeeper
{
  LDX #prox_shopkeeper ; MARKETSQUAREROOM, 64x152
  JSR collidewithdizzy
  BCC checkminetroll

  ; Make shopkeeper appear
  LDA #MARKETSQUAREROOM
  STA objs_rooms+obj_shopkeeper
  STA objs_rooms+obj_shopkeeper+1

  LDA #OFFMAP:STA objs_rooms+prox_shopkeeper

  LDA #str_shopkeeperappearsmess:JSR prtmessage
  JMP l1F33
}

.checkminetroll
{
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
  LDA #OFFMAP:STA objs_rooms+prox_troll ; remove proximity from dungeon

  LDX #obj_troll
  JSR redrawobj

  LDA #str_goawaymess:JSR prtmessage

  LDA #&00
  STA &03C7
  STA &03C8

  LDA #JOY_LEFT+JOY_UP:STA player_input ; Set Dizzy jumping away from the troll

  LDA #CASTLEDUNGEONROOM:STA objs_rooms+obj_lastcoin ; Put last coin in the dungeon (behind the troll)

  JMP l1B68
}

.l1F33
{
  LDA #obj_null
  STA usedobj   ; object being dropped
  STA pickupobj ; object being picked up

  LDA &03C7
  BNE l1F48

  LDA &03C8
  BNE l1F48

  JMP l1F50
}

.l1F48
{
  LDA player_input
  AND #&EF ; Mask out "FIRE" press
  STA player_input
}

.l1F50
{
  LDA player_input
  AND #JOY_FIRE ; Mask only "FIRE" press
  BNE checkpickup

  JMP checkdeadlyobj
}

.checkpickup
{
  LDX #obj_bag
.^l1F5C
  LDA dizzyx
  CLC:ADC #30
  STA frmx ; X position

  CLC:ADC #8
  STA frmattr

  LDA dizzyy
  CLC:ADC #26
  STA frmy ; Y position

  CLC:ADC #34
  STA &033D

.objloop
  {
  ; Is object in this room ?
  LDA objs_rooms,X
  CMP roomno
  BNE nextobj

  ; Is object flipped ?
  LDA objs_attrs,X
  AND #ATTR_REVERSE
  BNE nextobj

  ; Is object X position < (dizzyx + 30) ?
  LDA objs_xlocs,X
  CMP frmx
  BCC nextobj

  ; Is object X position >= (dizzyx + 30 + 8) ?
  CMP frmattr
  BCS nextobj

  ; Is object Y position < (dizzyy + 26) ?
  LDA objs_ylocs,X
  CMP frmy
  BCC nextobj

  ; Is object Y position >= (dizzyy + 26 + 34) ?
  CMP &033D
  BCS nextobj

  ; At this point the object overlaps dizzy
  STX pickupobj

  JMP checkdenzil

.nextobj
  INX
  ; Is it a collectable object
  CPX #maxcollectable+1
  BCC objloop
  }

  ; Dizzy not overlapping a collectable
  LDX #obj_null:STX pickupobj

  ; Fall through
}

.checkdenzil
{
  LDX #obj_denzil
  JSR collidewithdizzy
  BCC checkportrait

  ; Check if rope has been given to Dizzy
  LDY #str_stereoess
  LDA objs_rooms+obj_rope
  CMP #ATTICROOM+1
  BNE gotrope

  ; Make rope appear
  LDA #BANQUETHALLROOM:STA objs_rooms+obj_rope

  LDY #str_denziltalking

.gotrope
  TYA
  JSR prtmessage

  JMP checkdeadlyobj
}

.checkportrait
{
  LDX #prox_picture ; ENTRANCEHALLROOM, 64x104
  JSR collidewithdizzy
  BCC checkportcullis

  ; Look up at the picture of Dizzy 2
  LDA #str_lookatpicturemess:JSR prtmessage

  JMP checkdeadlyobj
}

.checkportcullis
{
  LDX #obj_switch
  JSR collidewithdizzy
  BCC checkdozy

  ; Check if portcullis switch has been activated
  LDA objs_attrs+obj_switch
  CMP #PAL_CYAN
  BNE checkdozy

  ; Activate portcullis switch
  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_switch
  LDA #str_throwswitchmess:JSR prtmessage

  JMP checkdeadlyobj
}

.checkdozy
{
  LDX #obj_dozy
  JSR collidewithdizzy
  BCC checkdoorknocker

  ; Check if sleeping potion has been given to Dizzy
  LDA objs_rooms+obj_sleepingpotion
  CMP #ATTICROOM+1
  BNE gotpotion

  ; Make sleeping potion appear
  LDA #OUTTOSEAROOM:STA objs_rooms+obj_sleepingpotion

  LDY #str_dozytalking
  JMP dozymessage

.gotpotion
  LDX #obj_dozy
  JSR ruboutframe

  ; Position Dozy
  LDA #60:STA objs_xlocs+obj_dozy
  LDA #134:STA objs_ylocs+obj_dozy
  LDY #str_kickdozyagainmess

.dozymessage
  TYA
  JSR prtmessage

  JMP checkdeadlyobj
}

.checkdoorknocker
{
  LDA roomno
  CMP #CASTLESTAIRCASEROOM
  BNE checkgranddizzy

  ; Check for doorknocker
  LDA objs_rooms+obj_doorknocker
  CMP #collected
  BEQ checkgranddizzy

  LDX #prox_knox ; CASTLEDUNGEONROOM, 40x160
  JSR collidewithdizzy
  BCC checkgranddizzy

  LDA #str_knockandentermess:JSR prtmessage

  JMP checkdeadlyobj
}

.checkgranddizzy
{
  LDX #obj_granddizzy
  JSR collidewithdizzy
  BCC checkdylan

  ; Check if crowbar has been given to Dizzy
  LDY #str_goonmysonmess
  LDA objs_rooms+obj_crowbar
  CMP #ATTICROOM+1
  BNE dougmessage

  ; Make crowbar appear
  LDA #LIFTTOELDERSROOM:STA objs_rooms+obj_crowbar
  LDY #str_dougtalking

.dougmessage
  TYA
  JSR prtmessage

  JMP checkdeadlyobj
}

.checkdylan
{
  LDX #obj_dylan
  JSR collidewithdizzy
  BCC checkprisonswitch

  ; Check Dylan orientation to see if we've already spoken
  LDY #str_trancemess
  LDA objs_attrs+obj_dylan
  CMP #PAL_WHITE
  BNE dylanmessage

  ; Make Dylan face the other way
  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_dylan
  LDY #str_dylantalking

.dylanmessage
  TYA
  JSR prtmessage

  JMP checkdeadlyobj
}

.checkprisonswitch
{
  LDX #obj_switch2
  JSR collidewithdizzy
  BCC checkgoldenegg2

  ; Check switch in Daisy's prison
  LDA #ATTR_REVERSE+PAL_WHITE
  CMP objs_attrs+obj_switch2
  BEQ checkgoldenegg2

  ; Activate switch in Daisy's prison
  STA objs_attrs+obj_switch2

  LDX #obj_switch2
  JSR redrawobj

.loop
  {
  LDX #obj_prisonliftbottom
  JSR ruboutframe

  ; Move bottom of lift downwards
  INC objs_ylocs+obj_prisonliftbottom
  JSR redrawobj

  INX ; switch from liftbottom to daisy
  JSR ruboutframe

  ; Also move Daisy downwards (she's on the lift)
  INC objs_ylocs+obj_daisy
  LDA objs_attrs+obj_daisy:EOR #ATTR_REVERSE:STA objs_attrs+obj_daisy
  JSR redrawobj

  ; Move top of lift downwards
  LDX #obj_prisonlifttop
  INC objs_ylocs+obj_prisonlifttop
  JSR redrawobj

  LDA #&0A:JSR delay

  ; Check where the lift has got to, keep moving until it gets to the bottom
  LDA objs_ylocs+obj_prisonliftbottom
  ; Is it < 139
  CMP #139
  BCC loop
  }

  JMP checkdeadlyobj
}

; Check second golden egg (from dragon's lair)
.checkgoldenegg2
{
  LDX #obj_goldenegg2
  JSR collidewithdizzy
  BCC dodaisyrou

  LDX #obj_goldenegg2
  JSR ruboutframe

  ; Remove golden egg
  LDA #OFFMAP:STA objs_rooms+obj_goldenegg2

  JMP checkdeadlyobj

.dodaisyrou
  JMP checkdaisy ; This could be a JSR ?!?
}

; Return here after checking Daisy
.checkbag
{
  LDX pickupobj
  CPX #obj_bag
  BNE checkmanure

  ; Change bag room to 4 - to indicate it's been collected
  LDA #collected:STA objs_rooms+obj_bag

.^l20F1
  LDA #obj_null:STA pickupobj
  JMP coincheck
}

.checkmanure
{
  CPX #obj_manure
  BNE checkblackhole

  ; Check manure orientation
  LDA objs_attrs+obj_manure
  CMP #ATTR_REVERSE
  BCS pickedup

  ; Add reverse flag
  ORA #ATTR_REVERSE
  STA objs_attrs+obj_manure

  LDA #str_pickupmanuremess:JSR prtmessage

.pickedup
  LDX #obj_manure+1 ; move on to next object

  JMP l1F5C
}

.checkblackhole
{
  CPX #obj_blackhole
  BNE coincheck

  ; This is the blackhole - so drop everything!

  ; Loop around the objects, skipping big bag
  LDX #mincollectable
.objloop
  {
  LDA objs_rooms,X
  CMP #collected
  BNE nextobj

  ; This is an object which has been collected
  LDA roomno:STA objs_rooms,X ; place object in current room

  ; Position this object where Dizzy is
  LDA dizzyx
  CLC:ADC #33:AND #&FE ; X+33 then round down to even number
  STA objs_xlocs,X ; Update X position of object based on Dizzy X position

  LDA dizzyy:CLC:ADC #45:STA objs_ylocs,X ; Y+45

.nextobj
  INX
  ; Is it within collectable object ids range
  CPX #maxcollectable+1
  BCC objloop
  }

  LDA #str_holdingholemess:JSR prtmessage

  LDA #OFFMAP:STA objs_rooms+obj_blackhole ; Remove blackhole

  JMP l20F1
}

.coincheck
{
  ; Check to see if this object is a coin
  LDX pickupobj
  CPX #firstcoin
  BCC notacoin

  CPX #lastcoin+1
  BCS notacoin

  ; This object is a coin
  JSR collect_coin

  JMP checkdeadlyobj
}

.notacoin
  ; Is it a non-collectable
  CPX #maxcollectable+1
  BCS l21A0

  LDA #collected:STA objs_rooms,X

  CPX #lastcoin+1
  BCC l2177

  LDA vC696,X ; load from static objects
  CMP #&65 ; ? sprites ?
  BNE l2177

  LDA roomno:STA vC696,X
.l2177
  JSR buildinventorylist

  ; Check for larger inventory
  LDA objs_rooms+obj_bag
  LDX #SMALLBAGSIZE ; Default to small bag unless larger one collected
  CMP #collected
  BNE l2185

  LDX #BIGBAGSIZE
.l2185
  LDA inventorylist,X ; X is either 2 or 4
  CMP #obj_null
  BEQ l21A0

  CMP #&00
  BEQ l21A0

  LDX inventorylist
  STX usedobj
  LDA #OFFMAP:STA objs_rooms,X

  LDA #str_carryingtoomuchmess:JSR prtmessage

.l21A0
  LDA #&00:STA SPR_ENABLE ; Hide sprites

  JSR drawinventory

  LDA inventorylist
  BEQ l21B4

  LDA usedobj
  CMP #obj_null
  BEQ inventoryprompt

.l21B4
  LDA #&F0:JSR delay
  LDA #&F0:JSR delay

  JSR resetgamestate

  JMP checkliftcollide

.inventoryprompt
  LDA #str_selectitemmess:JSR prtmessage

; Find empty inventory slot ??
.l21C9
{
  LDX #&00
.loop
  {
  LDA inventorylist,X
  BEQ setemptyslotindex

  INX
  JMP loop
  }

.setemptyslotindex
  STX inventoryindex

  ; Fall through
}

; Loop back here until FIRE pressed
.inventoryloop
{
  ; Set non-highlighted entry inventory colour
  LDA #PAL_CYAN
  JSR setinventorycolour

  ; Slow down inventory selection
  LDA #&3C:JSR delay

  ; Fall through
}

.waitforinventoryinput
{
  ; Loop around until left/right/fire
  JSR getplayerinput
  LDA player_input
  AND #JOY_FIRE+JOY_RIGHT+JOY_LEFT
  BEQ waitforinventoryinput

  ; Check for FIRE button
  AND #JOY_FIRE
  BEQ checkdirection

  ; See if anything is selected, ( or just "exit and don't drop")
  LDX inventoryindex
  LDA inventorylist,X
  BNE setselectedobj

  LDA #obj_null ; Nothing selected
.setselectedobj
  STA usedobj

  JSR resetgamestate

  ; Start checks against selected object
  JMP shopkeeperrou
}

; Called when something was pressed on inventory screen
; .. but it wasn't FIRE
.checkdirection
{
  ; Set highlighted inventory item colour
  LDA #PAL_MAGENTA
  JSR setinventorycolour

  ; Was it LEFT pressed?
  LDA player_input
  AND #JOY_LEFT
  BEQ inventoryright ; - no, so go right

  ; Fall through
}

.inventoryleft
{
  ; (go UP inventory list)
  DEC inventoryindex

  ; Is it >= 250 (i.e. now negative)
  LDX inventoryindex
  CPX #&FA
  BCS l21C9

  JMP inventoryloop
}

.inventoryright
{
  ; (go DOWN inventory list)
  LDX inventoryindex
  INC inventoryindex
  LDA inventorylist,X
  BNE inventoryloop

  ; Move selection highlight back to top of list
  LDA #&00:STA inventoryindex
  JMP inventoryloop
}

.shopkeeperrou
{
  ; Object drop/interaction, check first if it's with the shopkeeper?
  LDX #obj_shopkeeper
  JSR collidewithdizzy
  BCC checkapple

  ; Is Dizzy giving the cow to the shopkeeper?
  LDA usedobj
  CMP #obj_cow
  BEQ beanrou

  ; Dizzy gave the shopkeeper something other than the cow
  LDA #str_givingjunkmess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

; In return for the cow, Dizzy gets the bean!
.beanrou
{
  ; Make bean appear
  LDA #MARKETSQUAREROOM:STA objs_rooms+obj_bean

  ; Remove cow from game
  JSR hideobject

  ; Hide shopkeeper
  LDA #OFFMAP
  STA objs_rooms+obj_shopkeeper
  STA objs_rooms+obj_shopkeeper+1

  LDA #str_thanksforthecowmess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

.checkapple
{
  ; Is the apple being used?
  LDA usedobj
  CMP #obj_apple
  BNE checkjugofwater

  ; Is apple being used with troll?
  LDX #obj_troll
  JSR collidewithdizzy
  BCC do_checkliftcollide

  ; Remove apple from game
  JSR hideobject

  LDA #str_trollgotapplemess:JSR prtmessage

  ; Fall through
}

.do_checkliftcollide
{
  ; End object interaction checks
  JMP checkliftcollide
}

.checkjugofwater
{
  ; Is the jug of water being used?
  CMP #obj_jugofwater
  BNE checkrope

  ; Is the water being used by the dungeon fire?
  LDX #prox_jug ; CASTLEDUNGEONROOM, 40x160
  JSR collidewithdizzy
  BCC do_checkliftcollide

  ; Remove jug of water from game
  JSR hideobject

  LDA #str_throwwateronfiremess:JSR prtmessage

  ; Move the proximity to be used by door knocker next
  LDA #CASTLESTAIRCASEROOM:STA objs_rooms+prox_jug
  LDA #36:STA objs_xlocs+prox_jug

  ; End object interaction checks
  JMP checkliftcollide
}

.checkrope
{
  ; Is the rope being used?
  CMP #obj_rope
  BNE checkrocks

  ; Is the croc being tied up?
  LDX #obj_croc
  JSR collidewithdizzy
  BCC do_checkliftcollide

  ; Remove rope from game
  JSR hideobject

  ; Update crocodile animation frame
  LDA #SPR_CROCCLOSED:STA objs_frames+obj_croc

  LDA #str_croctiedmess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

.checkrocks
{
  ; Check if the object is one of the 3 rocks
  CMP #obj_rock1
  BCC checkdoorknocker2

  CMP #obj_rock3+1
  BCS checkdoorknocker2

  ; Check if we are next to the broken bridge
  LDX #prox_rock ; BROKENBRIDGEROOM, 74x104
  JSR collidewithdizzy
  BCC do_checkliftcollide

  ; Raise the water by 5 pixels
  LDA objs_ylocs+obj_bridgewater1
  SEC:SBC #5
  STA objs_ylocs+obj_bridgewater1
  STA objs_ylocs+obj_bridgewater2
  STA objs_ylocs+obj_bridgewater3

  ; Raise the pontoon by 5 pixels
  LDA objs_ylocs+obj_pontoon
  SEC:SBC #5
  STA objs_ylocs+obj_pontoon

  ; Remove rock from game
  JSR hideobject

  LDA #str_rockinwatermess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

.checkdoorknocker2
{
  ; Is the doorknocker being used?
  CMP #obj_doorknocker
  BNE checkbone

  ; It's the doorknocker, but is Dizzy in the right room?
  LDX roomno
  CPX #CASTLESTAIRCASEROOM
  BNE checkbone

  ; It's the doorknocker in the right room, but are we by the closed door?
  LDX #prox_knox ; CASTLESTAIRCASEROOM, 36x160 (shared with prox_jug)
  JSR collidewithdizzy
  BCC notprox

  ; Remove door knocker from game
  JSR hideobject

  ; Remove plank (door) and knock proximity
  LDA #OFFMAP
  STA objs_rooms+obj_plank
  STA objs_rooms+prox_knox

  LDA #str_usedoorknockermess:JSR prtmessage

  ; Fall through
}

.notprox
{
  ; End object interaction checks
  JMP checkliftcollide
}

.checkbone
{
  ; Is the bone being used?
  CMP #obj_bone
  BNE checkcrowbar

  ; It's the bone, but is Dizzy in Armorog's den?
  LDX #prox_armorogden ; ARMOROGROOM, 82x160
  JSR collidewithdizzy
  BCC notprox

  LDA #str_fedarmorog:JSR prtmessage

  ; Flag bone as being used by flipping X, and removing den proximity
  ;   .. so once bone placed in den, you can't remove and it put it back again
  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_bone
  LDA #OFFMAP:STA objs_rooms+prox_armorogden

  ; End object interaction checks
  JMP checkliftcollide
}

.checkcrowbar
{
  ; Is the crowbar being used?
  CMP #obj_crowbar
  BNE checkbean

  ; It's the crowbar, but is Dizzy at the top of the well?
  LDX #obj_wood
  JSR collidewithdizzy
  BCC notprox

  ; Remove crowbar from game
  JSR hideobject

  ; Remove well lid
  LDA #OFFMAP:STA objs_rooms+obj_wood

  LDA #str_usecrowbarmess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

.checkbean
{
  ; Is the bean being used?
  CMP #obj_bean
  BNE checkbucket

  ; It's the bean, but is Dizzy at the manure?
  LDX #obj_manure
  JSR collidewithdizzy
  BCC notprox

  ; Remove bean from game
  JSR hideobject

  LDA #str_plantbeanmess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

.l2355
{
  LDA #&00
  STA &03C7
  STA &03C8

  LDA #JOY_LEFT+JOY_UP:STA player_input
  JMP l1B68
}

.checkbucket
{
  ; Is the bucket being used?
  CMP #obj_bucket
  BNE checkkeys

  ; Check colour of bucket (full of water is blue)
  LDA objs_attrs+obj_bucket
  CMP #PAL_BLUE
  BNE checkfillingbucket

  ; Bucket is full, so check if bean has been used
  LDA objs_rooms+obj_bean
  CMP #OFFMAP
  BNE do_checkliftcollide2

  ; Bucket is full and bean has been placed, check we are at manure in allotment 
  LDX #obj_manure
  JSR collidewithdizzy
  BCC do_checkliftcollide2

  ; Remove bucket from game
  JSR hideobject

  ; Add an extra leaf as part of beanstalk
  LDA #ALLOTMENTROOM:STA objs_rooms+obj_leaf

  LDA #str_throwwateronbeanmess:JSR prtmessage

  JMP l2355
}

.checkfillingbucket
{
  ; Empty bucket is being used, check if we're at the puddle
  LDX #prox_mtbucket ; BASEOFVOLCANOROOM, 47x144
  JSR collidewithdizzy
  BCC do_checkliftcollide2

  ; Set colour of bucket to blue to fill with water
  LDA #PAL_BLUE:STA objs_attrs+obj_bucket

  ; Don't drop bucket
  LDA #obj_null:STA usedobj

  LDA #str_fillbucketmess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

.checkkeys
{
  ; Check if one of the 4 keys is being used?
  CMP #obj_key1
  BCC checkgoldenegg

  CMP #obj_key4+1
  BCS checkgoldenegg

  ; Determine if the right machine is being unocked?
  CLC:ADC #obj_machines-obj_keys:TAX
  JSR collidewithdizzy
  BCC do_checkliftcollide2

  ; Key is being used with corresponding machine, change machine white
  LDA #PAL_WHITE:STA objs_attrs,X

  ; Remove this key from game
  JSR hideobject

  LDA #str_keyinmachine:JSR prtmessage

  ; Fall through
}

; Here for reachability in branches
.do_checkliftcollide2
{
  ; End object interaction checks
  JMP checkliftcollide
}

.checkgoldenegg
{
  ; Is the golden egg being used?
  CMP #obj_goldenegg
  BNE checkpickaxe

  ; Is the golden egg being placed in the dragon's nest?
  LDX #prox_egg ; DRAGONSLAIRROOM, 54x160
  JSR collidewithdizzy
  BCC do_checkliftcollide2

  LDA #str_puteggbackmess:JSR prtmessage

  ; Flip golden egg, to flag its return
  LDA #ATTR_REVERSE+PAL_YELLOW:STA objs_attrs+obj_goldenegg

  ; End object interaction checks
  JMP checkliftcollide
}

.checkpickaxe
{
  ; Is the pickaxe being used?
  CMP #obj_pickaxe
  BNE checkrug

  ; Is Dizzy by the large stone?
  LDX #prox_pickaxe ; MINESROOM, 42x101
  JSR collidewithdizzy
  BCC do_checkliftcollide2

  ; Remove pickaxe from game
  JSR hideobject

  ; Remove large stone from game
  LDA #OFFMAP:STA objs_rooms+obj_largestone

  LDA #str_usepickaxemess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

.checkrug
{
  ; Is the rug being used?
  CMP #obj_rug
  BNE checksleepingpotion

  ; Is Dizzy in Daisy's prison?
  LDA #DAISYSPRISONROOM
  CMP roomno
  BNE do_checkliftcollide2

  ; Put "ground" sprites into prison to mimic rug
  STA objs_rooms+obj_prisonrug1
  STA objs_rooms+obj_prisonrug2

  ; Remove rug from game
  JSR hideobject

  LDA #str_userugmess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

.checksleepingpotion
{
  ; Is the sleeping potion being used?
  CMP #obj_sleepingpotion
  BNE checkliftcollide

  ; Is Dizzy in the room with the dragon (just past the crocodile)
  LDA #WIDEEYEDDRAGONROOM
  CMP roomno
  BNE checkliftcollide

  ; Remove sleeping potion from game
  JSR hideobject

  LDA #str_dragonasleepmess:JSR prtmessage

  ; End object interaction checks
  JMP checkliftcollide
}

; After checking object interaction, make sure we're not colliding with any lifts
.checkliftcollide
{
  LDX #obj_lifts:STX &03DB
.liftloop
  {
  JSR collidewithdizzy
  BCC nocollision

  ; Dizzy is on/near a lift, so don't drop object on it
  LDX #obj_null:STX usedobj
  JMP checkwhiskey

.nocollision
  INC &03DB
  LDX &03DB

  ; Is it within range of the lift objects
  CPX #endoflifts
  BCC liftloop
  }

  ; Fall through
}

.checkwhiskey
{
  ; Is Dizzy using (drinking) Whiskey/Brandy
  LDX usedobj
  CPX #obj_brandy
  BNE dropobject

  ; Dizzy is now drunk - remove whiskey from game
  JSR hideobject

  LDA #str_dropwhiskeymess:JSR prtmessage

  JMP checkdeadlyobj
}

.dropobject
{
  ; Is used object valid?
  CPX #obj_null
  BEQ checkdeadlyobj

  ; TODO ?? work out what this is ??
  LDA #maxcollectable+1:STA &03DD
  LDA #&00:STA &03D5

  ; Wait until raster line >= 250
.rasterwaitloop
  {
  LDA GFX_RASTER_LINE
  ; Is it < 250
  CMP #250
  BCC rasterwaitloop
  }

  JSR drawobjects

  ; Drop selected object into current room
  LDX usedobj
  LDA roomno:STA objs_rooms,X

  ; Place object near Dizzy
  LDA dizzyx:CLC:ADC #33:AND #&FE:STA objs_xlocs,X ; rounded down to even number
  LDA dizzyy:CLC:ADC #45:STA objs_ylocs,X

  ; TODO ?? work out what this is ??
  LDA #maxcollectable+1:STA &03DD
  LDA #&FF:STA &03D5

  JSR drawobjects
  JSR convertpalette

  ; Fall through
}

.checkdeadlyobj
{
  ; Check all the things that can kill Dizzy on contact
  LDX #&00:STX index

.loop
  {
  LDA deadlyobj,X
  TAX
  JSR collidewithdizzy
  BCC nocontact

  ; Contact has been made
  LDX index
  LDA deathmessages,X
  JMP storekillstr

.nocontact
  INC index:LDX index
  ; Is it < 11
  CPX #numdeadlyobj
  BCC loop
  }

  ; Fall through
}

.checkcroc
{
  ; Check if crocodile's mouth is open
  LDA objs_frames+obj_croc
  CMP #SPR_CROCOPEN
  BNE checkdragons

  ; The croc's mouth is open, so is Dizzy touching it?
  LDX #obj_croc
  JSR collidewithdizzy
  BCC checkdragons

  ; Dizzy was eaten by the crocodile
  LDA #str_croceatenmess
  JMP storekillstr
}

.checkdragons
{
  LDA roomno
  CMP #DRAGONSLAIRROOM
  BEQ checkdragoninmine

  CMP #WIDEEYEDDRAGONROOM
  BEQ checkopenairdragon

  ; Not with either dragon, so move on
  JMP checkforhazards
}

.checkdragoninmine
{
  ; Check if golden egg has been returned
  LDA objs_attrs+obj_goldenegg
  AND #ATTR_REVERSE
  BEQ checkdragonbite

  JMP checkdragonflames
}

.checkopenairdragon
{
  ; Check sleeping potion
  LDA objs_rooms+obj_sleepingpotion
  CMP #OFFMAP
  BEQ checkdragonflames

  ; Fall through
}

; Has Dizzy collided with the dragon's head?
.checkdragonbite
{
  LDX #obj_dragonhead
  JSR collidewithdizzy
  BCC checkdragonflames

  LDA #str_dragonkilledmess
  JMP storekillstr
}

; Has Dizzy collided with the dragon's flames?
.checkdragonflames
{
  ; Check for Dizzy being near the ground - inline with the flames
  LDA dizzyy
  ; Is it < 88
  CMP #88
  BCC checkforhazards

  ; Check for the flames being emitted by the dragon
  LDA dragonflamepos
  BEQ checkforhazards

  ; Check for Dizzy being past the tree (where the flames stop)
  LDA dizzyx
  CLC:ADC #35
  ; Is it < 49
  CMP #49
  BCC checkforhazards

  ; Dizzy is past the tree, so compare him to "flames left position"
  CMP dragonflamepos
  BCC checkforhazards

  ; Dizzy is past the "flames left position", so reduce by 4 and compare again
  SEC:SBC #&04
  CMP dragonflamepos
  BCS checkforhazards

  ; Dizzy has been hit by dragon's flame
  LDA #str_dragonflameskilledmess
  JMP storekillstr
}

; Check for collision with water, lava or torch flames
.checkforhazards
{
  LDA #2:STA frmx
.loop
  {
  LDA #6:STA frmy

  JSR l3154 ; ?? hit detection (+2..5 X, +6 Y) ??
  LDA hitbitflags
  AND #HIT_FIRE+HIT_WATER
  BNE checkforfire

  LDA #13:STA frmy

  JSR l3154 ; ?? hit detection (+2..5 X, +13 Y) ??
  LDA hitbitflags
  AND #HIT_FIRE+HIT_WATER
  BNE checkforfire

  INC frmx
  LDA frmx
  ; Is it < 6
  CMP #&06
  BCC loop
  }

  ; Fall through
}

.checkforfire
{
  LDA hitbitflags
  AND #HIT_FIRE
  BEQ checkforliquid

  LDA #str_killedbyflame
  JMP storekillstr
}

.checkforliquid
{
  LDA hitbitflags
  AND #HIT_WATER
  BEQ ratrou

  ; Collision with liquid, check if it was lava or water
  LDA #str_killedbyvolcano
  LDY roomno
  CPY #ACTIVEVOLCANOROOM
  BEQ storekillstr

  LDA #str_killedbywater

  ; Fall through
}

.storekillstr
{
  STA deathid ; Store "killed-by" message id

  ; Was it daggers that hurt Dizzy
  CMP #str_killedbydaggersmess
  BNE processdeath

  ; Check which room Dizzy hit daggers
  LDA roomno
  CMP #DAISYSPRISONROOM
  BNE processdeath

  ; Check if rug has been used to cover daggers in Daisy's prison room
  LDA objs_rooms+obj_rug
  CMP #OFFMAP
  BNE processdeath

  ; Dizzy is safe - for now
  JMP ratrou

.processdeath
  LDA #TUNE_4:STA melody ; Lose a life / heart demo melody
  JSR l34E2

  ; You lose a life ...
  LDA #str_deadwindow:JSR prtmessage

  ; Reason for losing life message
  LDA deathid
  JSR prtmessage

  ; Delay whilst death message is shown
  LDA #&07:STA &03B7
.loop
  {
  LDA #&FA:JSR delay

  DEC index
  BNE loop
  }

  LDA lives
  BNE livesleft

  JMP titlescreen ; No lives left

.livesleft
  DEC lives ; lose a life

  JSR l2F22
  JSR l346B

  ; Check if muted
  LDA muted
  BNE ratrou

  LDA #TUNE_2:STA melody ; In-game melody

  ; Fall through
}

.ratrou
{
  LDA roomno
  CMP #CASTLEDUNGEONROOM
  BNE gotogator

  ; Check for rat being on the prowl
  LDA objs_rooms+obj_rat
  CMP #OFFMAP
  BEQ gotogator

  ; Check if bread is in this room
  LDA roomno
  CMP objs_rooms+obj_bread
  BNE moveright

  ; Check Y position of bread >= 100 (not near rat - below it)
  LDA objs_ylocs+obj_bread
  CMP #100
  BCS moveright

  ; See if rat's X position is less than the bread - i.e. it ate it
  LDA objs_xlocs+obj_bread
  CLC:ADC #4
  CMP objs_xlocs+obj_rat
  BCC moveright

  LDA #OFFMAP:STA objs_rooms+obj_bread ; Remove bread

  ; Flip rat to go back to it's nest
  LDA objs_attrs+obj_rat:ORA #ATTR_REVERSE:STA objs_attrs+obj_rat ; Set top bit

  LDA #str_thanksforloafmess:JSR prtmessage

.moveright
  LDX #obj_rat

  ; Check rat direction
  LDA objs_attrs+obj_rat
  AND #ATTR_REVERSE
  BEQ moveleft

  ; Move rat right
  JSR ruboutframe

  INC objs_xlocs+obj_rat
  JSR drawobjframe

  ; Check for bread being in room
  LDA objs_rooms+obj_bread
  CMP #OFFMAP
  BNE dontcheckbread

  ; Check rat X position < 96
  LDA objs_xlocs+obj_rat
  CMP #96
  BCC gatorrou

  JSR ruboutframe

  ; Remove rat
  LDA #OFFMAP:STA objs_rooms+obj_rat

.gotogator
  JMP gatorrou

.dontcheckbread
  ; Check rat X position < 79 (under hole in ceiling), if it's >= 79 then flip rat left
  LDA objs_xlocs+obj_rat
  CMP #79
  BCC gatorrou

.fliprat
  ; Flip rat direction
  LDA objs_attrs+obj_rat:EOR #ATTR_REVERSE:STA objs_attrs+obj_rat ; flip top bit

  JMP gatorrou

.moveleft
  ; Move rat left
  LDX #obj_rat
  JSR ruboutframe

  DEC objs_xlocs+obj_rat
  JSR drawobjframe

  ; Check rat X position < 47 to flip rat right, otherwise continue
  LDA objs_xlocs+obj_rat
  CMP #47
  BCC fliprat

  ; Fall through
}

.gatorrou
{
  LDA roomno
  CMP #GATORROOM
  BNE portcullisrou

  ; Check if rope has been "used" - tied up croc
  LDA objs_rooms+obj_rope
  CMP #OFFMAP
  BEQ portcullisrou

  ; Gator is not tied, so animate
  LDA gamecounter
  LSR A:LSR A ; divide by 4
  AND #&07
  ; Is it < 6
  CMP #&06
  BCC animcroc

  LDA #&01 ; Mouth shut during longer period
.animcroc
  ; Change croc sprite
  AND #&01 ; restrict to 2 frames (0 and 1)
  EOR #&01
  CLC:ADC #SPR_CROCCLOSED
  STA objs_frames+obj_croc

  LDX #obj_croc
  JSR redrawobj

  ; Fall through
}

.portcullisrou
{
  LDA roomno
  CMP #MOATROOM
  BNE dozyrou

  ; Check if portcullis switch is active
  LDA objs_attrs+obj_switch
  CMP #PAL_CYAN
  BEQ dozyrou

  ; Check portcullis orientation
  LDA objs_attrs+obj_portcullis
  AND #ATTR_REVERSE
  BNE movedown

.moveup
  ; Move portcullis up
  LDX #obj_portcullis
  JSR ruboutframe

  ; Move portcullis up
  DEC objs_ylocs+obj_portcullis

  ; Has it got to the top?
  LDA objs_ylocs+obj_portcullis
  CMP #97
  BCS done

.flipdir
  ; Flip portcullis orientation
  LDA objs_attrs+obj_portcullis:EOR #ATTR_REVERSE:STA objs_attrs+obj_portcullis

.done
  LDX #obj_portcullis
  JSR redrawobj

  JMP dozyrou

.movedown
  ; Has it got to the bottom?
  LDA objs_ylocs+obj_portcullis
  CMP #136
  BCS flipdir

  ; Move portcullis down quickly, 4x speed
  CLC:ADC #4:STA objs_ylocs+obj_portcullis
  JMP done
}

.dozyrou
{
  LDA roomno
  CMP #OUTTOSEAROOM
  BNE liftsrou

  ; Check Dozy X position >= 70
  LDA objs_xlocs+obj_dozy
  CMP #70
  BCS liftsrou

  LDA gamecounter
  AND #&03
  BNE liftsrou

  ; Update Dozy Y position
  LDX #obj_dozy
  JSR ruboutframe

  LDA gamecounter
  AND #&04
  CLC:ADC #134
  STA objs_ylocs+obj_dozy

  LDX #obj_dozy
  JSR redrawobj

  ; Fall through
}

.liftsrou
{
  LDX #&00
  LDA liftwait
  BEQ checklift

  JMP hawkrou

.checklift
  {
  ; Check if this room has a lift
  LDA liftrooms,X
  CMP roomno
  BNE nextlift

  ; Check if machine[x] is active
  LDA objs_attrs+obj_machines,X
  CMP #PAL_WHITE
  BNE nextlift

  ; Found a lift so start processing
  STX index
  TXA
  ASL A
  CLC:ADC #obj_lifts
  TAX
  LDA objs_attrs+1,X ; Lift bottom
  AND #ATTR_REVERSE ; Check lift direction
  BNE goingup

.goingdown
  INC objs_ylocs,X ; Move top of lift downwards
  JSR redrawobj

  ; Remove bottom of lift
  INX:JSR ruboutframe

  INC objs_ylocs,X ; Move bottom of lift downwards an redraw
  JSR redrawobj

  ; See if the lift has reached the lowest position (incase flipping direction)
  LDY index
  LDA objs_ylocs,X:STA v18F4,Y
  CMP lowestliftpos,Y
  BCC hawkrou ; <

.flipliftdir
  LDA objs_attrs,X:EOR #ATTR_REVERSE:STA objs_attrs,X ; flip top bit (change direction)
  LDA #16:STA liftwait ; Delay list movement following direction flip
  JMP hawkrou

.goingup
  DEC objs_ylocs,X ; Move top of lift upwards
  JSR redrawobj

  ; Remove bottom of lift
  INX:JSR ruboutframe

  DEC objs_ylocs,X ; Move bottom of lift upwards and redraw
  JSR redrawobj

  ; See if the lift has reached the highest position (incase of flipping direction)
  LDY index
  LDA objs_ylocs,X:STA v18F4,Y
  CMP highestliftpos,Y
  BEQ flipliftdir ; =
  BCC flipliftdir ; <

  JMP hawkrou

.nextlift
  INX

  CPX #numlifts
  BCC checklift
  }
}

.hawkrou
{
  ; Check we are in the same room as the hawk
  LDA roomno
  CMP #GUARDHOUSEROOM
  BEQ inhawkroom

  ; Not in the right room, so move onwards to check armorog
  JMP armorogrou

.inhawkroom
  LDX #obj_hawk
  JSR drawobjframe

  ; Check hawk Y position == 56
  LDA objs_ylocs+obj_hawk
  CMP #56
  BNE hawkdiving

  ; Check hawk X position >= 61
  LDA objs_xlocs+obj_hawk
  CMP #61
  BCS hawkpatrolling

  ; Check hawk X position < 46
  CMP #46
  BCC hawkpatrolling

  ; See if Dizzy is directly below hawk
  LDA dizzyx
  CLC:ADC #28
  CMP objs_xlocs+obj_hawk
  BEQ hawkdiving

  ; Update hawk X position
  CLC:ADC #1
  CMP objs_xlocs+obj_hawk
  BNE hawkpatrolling

.hawkdiving
  JMP dohawkdive

.hawkpatrolling
  ; Check hawk X position < 35, at far left of range - so flip
  LDA objs_xlocs+obj_hawk
  CMP #35
  BCC fliphawk

  ; Check hawk X position < 80, within range - so skip the flip
  CMP #80
  BCC movehawk

.fliphawk
  ; Flip hawk direction
  LDA objs_attrs+obj_hawk:EOR #ATTR_REVERSE:STA objs_attrs+obj_hawk

.movehawk
  ; Check hawk direction
  LDA objs_attrs+obj_hawk
  AND #ATTR_REVERSE
  BNE movehawkleft

  ; Move hawk right
  INC objs_xlocs+obj_hawk
  INC objs_xlocs+obj_hawk

  JMP donemoving

.movehawkleft
  ; Move hawk left
  DEC objs_xlocs+obj_hawk
  DEC objs_xlocs+obj_hawk

.donemoving
  ; Flapping animation based on gamecounter value
  LDA gamecounter
  LSR A
  AND #&03
  CMP #&03
  BNE sethawkframe

  LDA #&01
.sethawkframe
  CLC:ADC #SPR_HAWK0

  ; Update hawk animation frame
  STA objs_frames+obj_hawk
  JSR drawobjframe
  JMP armorogrou ; ?? no need to do armorog as he won't be in the hawk room ??

.dohawkdive
  ; Hawk is diving, so move downwards
  LDA objs_ylocs+obj_hawk
  CLC:ADC #8
  STA objs_ylocs+obj_hawk

  ; Keep hawk moving towards Dizzy
  LDA dizzyx
  CLC:ADC #28
  CMP objs_xlocs+obj_hawk
  BCC diveleft

.diveright
  LDA objs_attrs+obj_hawk:AND #%01111111:STA objs_attrs+obj_hawk ; Clear reverse (look right)
  JMP movehawk

.diveleft
  LDA objs_attrs+obj_hawk:ORA #ATTR_REVERSE:STA objs_attrs+obj_hawk ; Set reverse (look left)
  JMP movehawk
}

.armorogrou
{
  ; Check we are in the same room as armorog
  LDA roomno
  CMP #ARMOROGROOM
  BNE go_dragonsrou

  ; Only check on odd gamecounter values - to halve movement speed
  LDA gamecounter
  AND #&01
  BEQ go_dragonsrou

  ; Check if bone has been eaten
  LDA objs_rooms+obj_bone
  CMP #OFFMAP
  BEQ go_dragonsrou

  ; Check Dizzy Y position >= 104 (on lower ground)
  LDX #obj_grunt
  LDA dizzyy
  CMP #104
  BCS l283D

  ; Check den proximity still active
  LDA objs_rooms+prox_armorogden
  CMP #OFFMAP
  BEQ l283D

  ; Check grunt (Armorog) X position >= 55
  LDA objs_xlocs+obj_grunt
  CMP #55
  BCS l2847

  LDA #&00:STA &03BD

  ; We're done with Armorog, move on to dragons
.go_dragonsrou
  JMP dragonsrou

.l283D
  ; Is it >= 40
  LDA &03BD
  CMP #&28
  BCS l2847

  INC &03BD
.l2847
  LDA #attr_offs_screen:STA attrib_offset
  JSR drawobjframe

  LDA gamecounter
  LSR A
  AND #&01
  CLC:ADC #SPR_GRUNT0
  ; Update grunt (Armorog) animation frame
  STA objs_frames+obj_grunt

  ; Is it < 32
  LDA &03BD
  CMP #&20
  BCC done

  ; Check which way grunt is facing
  LDA objs_attrs+obj_grunt
  AND #ATTR_REVERSE
  BNE gruntgoesleft

  ; Move grunt right
  INC objs_xlocs+obj_grunt
  INC objs_xlocs+obj_grunt

  JMP checkgruntpos

.gruntgoesleft
  ; Move grunt left
  DEC objs_xlocs+obj_grunt
  DEC objs_xlocs+obj_grunt

.checkgruntpos
  ; Check grunt X position < 55 - to switch grunt direction
  LDA objs_xlocs+obj_grunt
  CMP #55
  BCC switchgruntdirection

  ; Check grunt X position < 78 - otherwise switch grunt direction
  CMP #78
  BCC done

.switchgruntdirection
  ; Switch direction grunt is facing/moving
  LDA objs_attrs+obj_grunt:EOR #ATTR_REVERSE:STA objs_attrs+obj_grunt

  ; Check if grunt X position is 78 - den entrance
  LDA objs_xlocs+obj_grunt
  CMP #78
  BNE done

  ; Check if bone was placed in the den
  LDA objs_attrs+obj_bone
  AND #ATTR_REVERSE
  BEQ done

  ; Bone was placed in the den - so make Armorog happy
  LDA #OFFMAP:STA objs_rooms+obj_bone ; Remove bone - it's been eaten
  LDA #ATTR_REVERSE+PLOT_XOR+PAL_RED:STA objs_attrs+obj_grunt

  LDX #obj_grunt
  JSR ruboutframe

.done
  LDA #attr_offs_screen:STA attrib_offset

  JSR drawobjframe

  ; Fall through
}

; Routine for handling dragons
.dragonsrou
{
  ; Check if Dizzy is in the dragon's underground lair
  LDA roomno
  CMP #DRAGONSLAIRROOM
  BEQ goldeneggrou

  ; Check if Dizzy is in the room with the dragon near the moat
  CMP #WIDEEYEDDRAGONROOM
  BEQ sleepingpotionrou

  LDA #&00:STA dragonflamepos ; Start with no flames
  JMP l295E

.goldeneggrou
  ; Check if golden egg has been returned
  LDA objs_attrs+obj_goldenegg
  CMP #ATTR_REVERSE
  BCC l28E1

  LDA &03BB
  BNE l28E1

  JMP l295E

.sleepingpotionrou
  ; Check if sleeping potion has been used
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
  LDA gamecounter
  AND #&01
  BEQ l28F5

  JMP l295E

.l28F5
  LDX #obj_dragonhead
.erasedragonneck
  {
  JSR ruboutframe

  DEX
  ; loop through each of the dragon head/neck objects
  CPX #obj_dragonneck
  BCS erasedragonneck
  }

  LDX #obj_dragonhead
.l2901
  {
  STX &FF
  LDA #&72
  SEC:SBC &FF
  CMP &03BB
  BEQ l290F
  BCS l2925
.l290F
  LDA objs_attrs+obj_dragonneck
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
  LDA #attr_offs_screen:STA attrib_offset

  JSR drawobjframe
  DEX
  ; Loop while >=108
  CPX #obj_dragonneck
  BCS l2901
  }

  LDA objs_attrs+obj_dragonneck
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
  LDA objs_attrs+obj_dragonneck:EOR #&20:STA objs_attrs+obj_dragonneck

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
  ; Make sure dragon flames don't already exist before breathing fire
  LDA dragonflamepos
  BNE l2993

  ; Set dragon flame initial (right) position
  LDA #66:STA dragonflamepos

  ; Set dragon's head to mouth open
  LDA #SPR_DRAGONHEADOPEN:STA objs_frames+obj_dragonhead

  ; Draw dragon's head
  LDX #obj_dragonhead
  JSR drawobjframe

.l2993
  ; Check if dragon is breathing flames
  LDA dragonflamepos
  BEQ donedrawingflames

  ; Dragon flames are being emitted, so move them left a bit
  DEC dragonflamepos
  DEC dragonflamepos

  ; Is dragon flame position >= 42
  LDA dragonflamepos
  CMP #42
  BCS dodrawflames

  ; Stop dragon breathing flames
  LDA #&00:STA dragonflamepos

  ; Set dragon's head to mouth closed
  LDA #SPR_DRAGONHEADCLOSED:STA objs_frames+obj_dragonhead

  ; Draw dragon's head
  LDX #obj_dragonhead
  JSR drawobjframe

  ; Don't draw any flames
  JMP donedrawingflames

.dodrawflames
  JSR drawdragonflames

.donedrawingflames
  NOP
  JSR l38B1

  JMP l1A25
}

.hideobject
{
  STX &034E ; Cache X

  LDX usedobj ; Get object id

  ; Set objects[X] as hidden
  LDA #OFFMAP
  STA objs_rooms,X

  ; Clear object being interacted with
  STA usedobj

  LDX &034E ; Restore X

  RTS
}

; Draw object in X reg
.redrawobj
{
  LDA #attr_offs_other:STA attrib_offset
  JSR drawobjframe

  LDA #attr_offs_screen:STA attrib_offset
  JSR drawobjframe

  RTS
}

; Initialise some objects slightly differently to default set
.initobjs
{
  ; Move sleeping potion to (82, 128) next to the barrel from on top of barrel (86, 104)
  ;  original game had it at (80, 128)
  LDA #128:STA objs_ylocs+obj_sleepingpotion
  LDA #82:STA objs_xlocs+obj_sleepingpotion

  ; Remove happy dust from game, was situated by the coin at top of the volcano
  ;  original game had sprite but it wasn't an in-game object
  LDA #OFFMAP:STA objs_rooms+obj_happydust ; not used in the game

  ; Add GRID flag to moving enemies
  LDA #ATTR_GRID+PAL_WHITE
  STA objs_attrs+obj_rat
  STA objs_attrs+obj_hawk

  LDA #ATTR_GRID+PAL_RED:STA objs_attrs+obj_grunt

  RTS
}

; Check for just entering/leaving Australia
.check_oz
{
  ; Check for entering Australia
  LDA roomno
  CMP #STRANGENEWROOM
  BEQ oztumble

  ; Check for leaving Australia
  CMP #UNDERAUSROOM
  BNE done

  LDA #TOPWELLROOM:STA roomno

.oztumble
  LDA #114:STA dizzyy

  ; Set Dizzy animation for jumping out of well
  LDA #ANIM_RIGHT
  STA &03C7
  STA player_direction

  LDA #&02:STA &03C8
  LDA #&01:STA &03C9
  LDA #&11:STA &03C3

.done
  RTS
}

.checkdaisy
{
  LDX #obj_daisy
  JSR collidewithdizzy
  BCS collidewithdaisy

  JMP checkbag
}

.collidewithdaisy
{
  ; Check which room we are in
  LDA roomno
  CMP #DAISYSPRISONROOM
  BNE checkcoins

  LDA #str_gottodaisymess:JSR prtmessage

  ; Put Daisy in her hut
  LDA #DAISYSHUTROOM:STA objs_rooms+obj_daisy
  LDA #50:STA objs_xlocs+obj_daisy
  LDA #77:STA objs_ylocs+obj_daisy

  LDA #&00:STA SPR_ENABLE ; Hide sprites
  JSR heartdemo

  LDA #str_daisyrunsmess:JSR prtmessage

  LDA #TUNE_2:STA melody ; In-game melody
  JMP checkdeadlyobj

.checkcoins
  LDA coins_tens
  CMP #&03 ; Check for 30 coins being collected
  BNE notenough

  LDA #str_gotallcoins:JSR prtmessage

  JMP titlescreen

.notenough
  LDA #str_notgotallcoins:JSR prtmessage

  JMP checkdeadlyobj
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
  {
  CLC
  ROL A
  ROL &FC
  DEX
  BNE loop
  }

  STA &FB

  LDA &FC:CLC:ADC #&40:STA &FC

  LDY #&00
  LDX #&3E
.fliploop
  {
  LDA (&FB),Y

  STX &FF ; Cache X
  TAX
  LDA flip_lut,X
  LDX &FF ; Restore X

  STA &4A80,X
  DEX
  INY
  CPY #&3F ; < 63
  BCC fliploop
  }

  ; Set sprite
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
  LDA gamecounter
  AND #&01
  BEQ l2ABC

  ; Is it >= 2
  LDA &03C8
  CMP #&02
  BCS l2ABC ; return

  ; SID audio code ?
  ; 2ACB

  SEI ; Disable interrupts
  LDA #&00:STA SID_CH1_CTRL
  LDA #&09:STA SID_VOL_FLT ; Volume at 60%
  LDA gamecounter:AND #&02:ASL A:CLC:ADC #&06:STA SID_CH1_FREQ_H
  LDA #&00:STA SID_CH1_SURL ; Sustain=0 / Release=0
  LDA #&10:STA SID_CH1_ATDK ; Attack=1 / Decay=0
  LDA #&81:STA SID_CH1_CTRL ; Noise / Test
  CLI ; Enable interrupts

.^v2AF2 ; [] - to make following table 1-based
  RTS
}

; No idea what this is, used by l2D95
.v2AF3 ; [9]
{
  EQUB &00, &00, &b8, &00, &00, &00, &81, &00, &80
}

; Some further unknown bytes here

ORG &2B13

; Flames
.flameindex ; flame counter, up to MAXFLAMES (10)
{
  EQUB 0
}

.flame_x
{
  FOR n, 1, MAXFLAMES
    EQUB 0
  NEXT
}

.flame_y
{
  FOR n, 1, MAXFLAMES
    EQUB 0
  NEXT
}

.flame_attr
{
  FOR n, 1, MAXFLAMES
    EQUB 0
  NEXT
}

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

.isr_counter
{
  EQUB 142
}

.muted
{
  EQUB 0
}

.isr_routine
{
  INC isr_counter

  LDA isr_counter
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
; frmx
; frmy
; frmattr
.frame
{
  STA &FB
  STA &0340 ; frame
  STX &0345 ; Cache X

  LDA frmx
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
  LDA frmy
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
  CMP #SPR_WATER3+1
  BCS notwater

  ; Water processing
  LDA &03DA
  BEQ l2B8F

  CMP frmx
  BCC l2B95

.l2B8F
  LDA frmx:STA &03DA ; X position
.l2B95
  STX &03E0
  LDA hitbitflags:ORA #HIT_WATER:STA hitbitflags
  LDA frmy:AND #&F8:STA frmy ; Y position
  JMP skipflame

.notwater
  CMP #SPR_FLAME
  BNE skipflame

  ; Flame processing
  LDY attrib_offset
  BEQ skipflame

  LDY flameindex
  CPY #MAXFLAMES
  BCS skipflame

  ; Process flame
  LDA frmx:STA flame_x,Y ; X position
  LDA frmy:STA flame_y,Y ; Y position
  LDA frmattr:ORA #PLOT_XOR:STA flame_attr,Y ; attr
  DEC &03BC
  INC flameindex

.skipflame
  ; Calculate screen RAM position
  LDA screentable_lo,X:STA &FB
  LDA screentable_hi,X:STA &FC

  LDA frmy ; Y position
  AND #&07
  CLC:ADC &FB
  BCC l2BEB

  INC &FC
.l2BEB
  SEC:SBC #&60
  BCS l2BF2

  DEC &FC
.l2BF2
  STA &FB

  LDA frmx ; X position
  AND #&FE ; round down to even number
  ASL A
  CLC
  ASL A
  BCC l2C00

  INC &FC
.l2C00
  CLC:ADC &FB
  BCC l2C07

  INC &FC
.l2C07
  STA &FB

  LDA frmy ; Y position
  LSR A:LSR A:LSR A ; Divide by 8
  TAX

  ; Set pointer at &FD to screen attribute RAM
  LDA screenattrtable_hi,X:SEC:SBC attrib_offset:STA &FE
  LDA screenattrtable_lo,X

  SEC:SBC #&0C
  BCS l2C23

  DEC &FE
.l2C23
  STA &FD

  LDA frmx ; X position
  LSR A ; Divide by 2
  CLC:ADC &FD
  BCC l2C30

  INC &FE
.l2C30
  STA &FD
  STA &35 ; lo pointer

  ; Set up pointer (&35) to &5800 range
  LDA attrib_offset ; &00 = &5C00, &58 = &0400
  BNE l2C41

  LDA &FE
  SEC:SBC #&04 ; Retract from &5C00 to &5800 ?

  JMP l2C46

.l2C41
  LDA &FE
  CLC:ADC #&54 ; Advance from &0400 to &5800 ?
.l2C46
  STA &36 ; hi pointer

  LDY #&00
  LDA (&B4),Y:STA &033D
  LSR &033D
  INY
  LDA (&B4),Y:STA &033E

  ; Is it < 48
  LDA &0340 ; frame
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
  CLC:ADC #&02
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
  LDA frmx ; X position
  AND #&FE ; round down to even number
  CMP #34
  BCS l2CA2

  STA &FF
  LDA #&22
  SEC:SBC &FF
  LSR A
  STA &034A
.l2CA2
  LDA frmx:AND #&FE:STA &FF ; rounded down to even number

  LDA #&5E
  SEC:SBC &FF
  LSR A
  CMP &034B
  BCS l2CB7

  STA &034B
.l2CB7
  LDA #&00:STA &0349

.l2CBC
  LDA frmy ; Y position
  CMP &03E3
  BCS l2CC7

  JMP l2D29

.l2CC7
  LDY #&00
.l2CC9
  {
  LDA (&B4),Y:STA v2AF3,Y
  INY
  CPY &033D
  BCC l2CC9
  }

  LDA frmattr ; attr
  AND #ATTR_REVERSE
  BEQ l2CDE

  JSR l2E2E
.l2CDE
  LDA frmx ; X position
  AND #&01
  BEQ l2CE8

  JSR l2D95
.l2CE8
  LDX &034A
.l2CEB
  {
  LDA &1877,X
  TAY
  LDA v2AF3,X
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
  LDA hitbitflags
  AND #&08
  BNE l2D1A

  LDA &03E2
  BEQ l2D0E

  STA (&FD),Y

  ; Strip attribs to convert to hit-detection bitmap
  ;   (&40=solid, &20=fire, &10=water, &00=empty)
.l2D0E
  LDA (&35),Y:AND #HIT_FIRE+HIT_WATER:ORA hitbitflags:STA (&35),Y
  JMP l2D23

  ;   also retain (&80=reverse - h-flip)
.l2D1A
  LDA (&35),Y:AND #&F0:ORA hitbitflags:STA (&35),Y
.l2D23
  INX
  CPX &034B
  BCC l2CEB
  }

.l2D29
  DEC &033E
  BNE l2D46

.l2D2E
  LDX &0345 ; Restore X
  LDA #&FF:STA &03DF
  LDA #attr_offs_screen:STA attrib_offset
  LDA #&30:STA &03E3
  LDA #&B8:STA &03E1
  RTS

.l2D46
  INC frmy ; Y position
  LDA frmy
  CMP &03E1
  BCS l2D2E

  LDA &B4
  CLC:ADC &033D
  BCC l2D5B

  INC &B5
.l2D5B
  STA &B4
  LDA frmy ; Y position
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
  CLC:ADC #&39
  BCC l2D81

  INC &FC
.l2D81
  STA &FB
  LDA &FD
  CLC:ADC #&28
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
  LDA #&00:STA v2AF3,X

.loop
  {
  LDA v2AF2,X
  ASL A ; * 16
  ASL A
  ASL A
  ASL A
  ORA v2AF3,X
  STA v2AF3,X

  LDA v2AF2,X
  LSR A ; / 16
  LSR A
  LSR A
  LSR A
  STA v2AF2,X

  DEX
  BNE loop
  }

  LDA &033D
  CMP &034B
  BCC done

  ; Is it >= 47
  LDA frmx
  LSR A
  CLC:ADC &033D
  CMP #47
  BCS done

  INC &034B

.done
  RTS
}

.l2DCF
{
  LDA frmattr
  AND #&07
  TAX
  LDA c64palette,X:STA &03E2
  BEQ l2DEC

  LDA frmx
  AND #&01
  BEQ l2DEC

  LDA frmattr:ORA #PLOT_XOR:STA frmattr
.l2DEC
  LDA frmattr
  AND #ATTR_NOTSOLID
  BEQ l2DF9

  ORA hitbitflags
  STA hitbitflags
.l2DF9
  LDA frmattr
  AND #&20
  BEQ l2E08

  LDA hitbitflags:ORA #&80:STA hitbitflags ;; TODO - what is &80 ??
.l2E08
  LDA frmattr
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

  LDA v2AF3,X
  TAY
  LDA flip_lut,Y:STA &FF
  LDX &0346
  LDA v2AF3,X
  TAY
  LDA flip_lut,Y
  LDX &0347
  STA v2AF3,X
  LDX &0346
  LDA &FF:STA v2AF3,X
  DEC &0346
  INC &0347

  JMP l2E3A

.l2E6E
  LDA v2AF3,X
  TAY
  LDA flip_lut,Y
  STA v2AF3,X

.done
  RTS
}

.l2E79
{
  STA &0340 ; Store roomno
  ; Check it is a valid room
  CMP #ATTICROOM+1
  BCC validroom

  RTS

.validroom
  ; Set up pointer (FB) to roomtable[roomno]
  LDA #hi(roomdata):STA &FC
  LDA &0340:CLC:ADC &0340 ; * 2
  BCC samepage

  INC &FC
.samepage
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
  CLC:ADC &B1
  STA &B1

  DEY
  LDA (&FB),Y
  CLC:ADC &B0
  BCC l2EB1

  INC &B1
.l2EB1
  STA &B0

  LDY #&03
  LDA (&FB),Y
  CLC:ADC &B3
  STA &B3

  DEY

  LDA (&FB),Y
  CLC:ADC &B2
  BCC l2EC6

  INC &B3
.l2EC6
  STA &B2

  ; Check if B0 pointer is the same as B1, i.e. the room is fully drawn
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
  LDA (&B0),Y:EOR #ATTR_NOTSOLID:STA cursorattr
.l2EEE
  LDA cursorattr:STA frmattr ; attrib
  LDA #HIT_EMPTY:STA hitbitflags

  LDY #&02
  LDA (&B0),Y:STA frmy ; Y position

  DEY
  LDA (&B0),Y
  AND #&7F
  STA frmx ; X position

  DEY
  LDA #attr_offs_other:STA attrib_offset
  LDA (&B0),Y ; frame
  JSR frame

  LDA &B0
  CLC:ADC &0342
  BCC l2F1D

  INC &B1
.l2F1D
  STA &B0

  JMP l2EC8
}

.l2F22
{
  JSR printroomname
  JSR showlives

  ; Check bone
  LDA objs_rooms+obj_bone
  CMP #OFFMAP
  BEQ resetgamestate

  ; Position grunt
  LDA #54:STA objs_xlocs+obj_grunt
  LDA #ATTR_GRID+PAL_RED:STA objs_attrs+obj_grunt

  ; Fall through
}

.resetgamestate
{
  LDA #&00
  STA &03BB
  STA SPR_ENABLE ; Hide sprites
  STA &03E0
  STA &03DA

  LDA gamecounter:AND #&F8:STA gamecounter

  ; Place the hawk in the clouds
  LDA #56:STA objs_ylocs+obj_hawk

  LDA #&0F:STA &03BC

  ; Set flame counter to 0
  LDA #&00:STA flameindex

  ; Clear out flame array
  LDX #&00
.flameloop
  {
  STA flame_x,X
  STA flame_y,X
  STA flame_attr,X

  INX
  ; Is it < max flames
  CPX #MAXFLAMES
  BCC flameloop
  }

  LDA roomno
  CMP #DRAGONSLAIRROOM
  BNE l2F7A

  LDA #&0C
  JMP l2F80

.l2F7A
  CMP #WIDEEYEDDRAGONROOM
  BNE l2FAA

  LDA #&0A
.l2F80
  STA &FF

  ; Loop through dragons neck/head objects to reset Y position
  LDX #obj_dragonneck
.neckresetloop
  {
  LDA roomno:STA objs_rooms,X

  LDA &FF:STA objs_attrs,X
  LDA orig_ylocs,X:STA objs_ylocs,X ; Reset Y position

  INX
  CPX #obj_dragonhead+1
  BCC neckresetloop
  }

  LDA #&0B:STA &03BC
  LDA objs_attrs+obj_dragonhead:AND #PAL_WHITE:STA objs_attrs+obj_dragonhead
  JMP l2FAF

.l2FAA
  ; Set dragon's head to mouth closed
  LDA #SPR_DRAGONHEADCLOSED:STA objs_frames+obj_dragonhead
.l2FAF
  LDA SPR_COLLISION2
  LDA SPR_COLLISION2
  LDA #&FF:STA &03DF
  JSR cleargamescreen

  LDA roomno
  JSR l2E79

  LDA roomno
  CMP #CASTLEDUNGEONROOM
  BNE checkallotment

  ; Check if jug of water has been used
  LDA objs_rooms+obj_jugofwater
  CMP #OFFMAP
  BEQ checkportcullis

  ; Dungeon fire has not been put out, so draw it too
  LDA #FIREROOM
  JSR l2E79

  JMP checkportcullis

.checkallotment
  CMP #ALLOTMENTROOM
  BNE checkportcullis

  ; Check if bucket has been used on bean
  LDA objs_rooms+obj_bucket
  CMP #OFFMAP
  BNE checkportcullis

  ; Bean has been watered, so draw beanstalk too
  LDA #BEANSTALKROOM
  JSR l2E79

.checkportcullis
  ; See if Dizzy is in the moat room
  LDA roomno
  CMP #MOATROOM
  BNE skipportcullis

  ; Set portcullis height
  LDA #96:STA objs_ylocs+obj_portcullis
.l2FF5
  LDX #obj_portcullis
  JSR drawobjframe

  ; Check portcullis height > 136
  LDA objs_ylocs+obj_portcullis
  CMP #136
  BCS skipportcullis

  ; Move portcullis down
  CLC:ADC #4
  STA objs_ylocs+obj_portcullis

  JMP l2FF5

.skipportcullis
  LDA #&FF:STA &03D5
  LDA #noofmoving:STA &03DD

  JSR drawobjects
  JSR drawlifts
  JSR convertpalette

  LDA #&FF:STA SPR_ENABLE ; Show sprites

  RTS
}

; This clears the game screen, not sure what else it does yet
.cleargamescreen
{
  ; Set up a pointer in &FB
  LDA #GAMEAREA_TOP:STA tmp1 ; Start 6 blocks down from top of screen
.clearrow
  LDX tmp1
  LDA screentable_hi,X:STA &FC
  LDA screentable_lo,X
  CLC:ADC #GAMEAREA_LEFT*8 ; Skip left border (bitmap)
  BCC samepage

  INC &FC
.samepage
  STA &FB

  ; Set pointer at &FD to screen attribute RAM
  LDA screenattrtable_hi,X:STA &FE
  LDA screenattrtable_lo,X

  CLC:ADC #GAMEAREA_LEFT ; Skip left border (attribs)
  BCC samepage2

  INC &FE
.samepage2
  STA &FD

  STA &B0
  STA &B2

  LDA &FE:SEC:SBC #&04:STA &B1

  SEC:SBC #&54
  STA &B3

  LDY #&F0
  LDA #&00
.clearbitmaploop
  {
  DEY
  STA (&FB),Y ; Clear bitmap char
  CPY #&00
  BNE clearbitmaploop
  }

  LDY #&1E
.clearattrloop
  {
  DEY
  STA (&B0),Y
  STA (&FD),Y ; Clear attrib char

  LDA #&10:STA (&B2),Y ; Set game area background colour (&10=black)

  LDA #&00 ; Reset char to clear attrib to
  CPY #&00
  BNE clearattrloop
  }

  ; Advance down the screen by 1 block
  INC tmp1

  ; Check for bottom of game screen
  LDA tmp1
  ; Is it < 23
  CMP #GAMEAREA_BOTTOM+1
  BCC clearrow

  ; Clear &5800..&59FF - some of the spectrum palette screen attribs
  LDA #&00
  TAX
.loop
  {
  STA spec_screen_attribs,X
  STA spec_screen_attribs+&100,X

  INX
  BNE loop
  }

  RTS
}

; Screen is initially drawn with attribs in spectrum palette to &5800
; this function swaps them to C64 palette
.convertpalette
{
  LDX #GAMEAREA_TOP ; Row to start from
.rowloop
  {
  LDA screenattrtable_hi,X:STA &FC ; Set up pointer &FB (hi)

  SEC:SBC #hi(screen_attribs-spec_screen_attribs)
  STA &36 ; Set up pointer &35 (hi), &04 pages lower (&5800)

  SEC:SBC #&54
  STA &FE ; Set up pointer &FD (hi), &58 pages lower (&0400)

  LDA screenattrtable_lo,X ; Set up pointers &35 / &FB / &FD (lo), all the same offset
  STA &FB
  STA &FD
  STA &35

  LDY #CHAR_COLUMNS-GAMEAREA_LEFT-1 ; Start at last column of game area
.columnloop
  {
  LDA (&35),Y ; read from &5800[]
  AND #%00000111 ; mask off (spectrum colours)
  BEQ skiplookup ; If it's black - skip C64 palette lookup

  ; C64 palette lookup
  STX &0346 ; Cache X
  TAX ; Convert spectrum palette value to offset
  LDA c64palette,X ; Lookup C64 equivalent colour
  LDX &0346 ; Restore X
  BNE l30C0 ; Row will never be 0, so always branch

.skiplookup
  LDA (&FD),Y ; read from &0400[]

.l30C0
  STA (&FB),Y ; store attribute to screen attrib memory

  DEY ; look at column to the left next, until we are off the left of the game area
  CPY #GAMEAREA_LEFT-1
  BNE columnloop
  }

  ; Advance down to next row, until we are off the bottom of the game area
  INX
  CPX #GAMEAREA_BOTTOM+1
  BCC rowloop
  }

  RTS
}

; If there is a lift in this room, draw it in the right place
.drawlifts
{
  LDX #&00 ; machine offset
  LDA #attr_offs_other:STA attrib_offset
.machineloop
  {
  ; Check if this lift is in current room
  LDA liftrooms,X
  CMP roomno
  BNE nextmachine

  ; Check if machine[x] (for this lift) is activated
  LDA objs_attrs+obj_machines,X
  CMP #PAL_WHITE
  BNE nextmachine

  ; We have an enabled lift in the room we are in
  STX &03DB ; Cache lift id

  ; Calculate offset for this lift into the objects
  TXA
  ASL A ; *2
  CLC:ADC #obj_lifts
  TAX

  ; Reset Y position of top and bottom of this lift
  LDA orig_ylocs,X:STA objs_ylocs,X
  LDA orig_ylocs+1,X:STA objs_ylocs+1,X

  ; This draws a streak of white above the lift to act as the lift rope
.redrawlift
  {
  ; Draw the top of the lift
  JSR drawobjframe

  ; Check the Y position of the bottom of the lift
  LDA objs_ylocs+1,X
  LDY &03DB ; Restore lift id
  CMP v18F4,Y ; Compare Y position
  BCS drawliftbottom ; if >= we're done

  ; Move lift downwards
  INC objs_ylocs,X   ; Top of lift
  INC objs_ylocs+1,X ; Bottom of lift

  ; Loop back to redraw top of lift at new position
  JMP redrawlift
  }

.nextmachine
  INX
  CPX #nummachines
  BCC machineloop
  }

  ; No lifts needed drawing at this point, so move on to check prison lift
  JMP checkprisonlift

.drawliftbottom
  INX
  JSR drawobjframe

  ; Fall through
}

.checkprisonlift
{
  LDA roomno
  CMP #DAISYSPRISONROOM
  BNE done

  ; Check if switch in Daisy's prison is activated
  LDA objs_attrs+obj_switch2
  CMP #PAL_CYAN ; it turns from cyan to white when activated
  BEQ done

  ; Move Daisy's prison lift downwards (redrawing) until it reaches the bottom
  LDX #obj_prisonlifttop
  LDA orig_ylocs,X:STA objs_ylocs,X
.loop
  {
  JSR drawobjframe

  INC objs_ylocs,X
  LDA objs_ylocs,X
  ; Is it < 103
  CMP #103
  BCC loop
  }

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

; ? Hit detection ?
.l3154
{
  ; Calculate X position
  LDA dizzyx
  CLC:ADC frmx ; Add X offset
  STA tmp3
  DEC tmp3

  ; Calculate Y position
  LDA dizzyy
  CLC:ADC frmy ; Add Y offset
  CLC:ADC #40
  STA &033D
  DEC &033D

  ; Calculate offset
  LDA &033D
  LSR A ; / 8
  LSR A ;
  LSR A ;
  TAX

  ; Set pointer at &FB to screen RAM
  LDA screentable_lo,X:STA &FB
  LDA screentable_hi,X:STA &FC

  ; Set pointer at &FD to screen attribute RAM
  LDA screenattrtable_lo,X:STA &FD
  LDA screenattrtable_hi,X:SEC:SBC #&04:STA &FE

  LDA &033D
  AND #&07
  CLC:ADC &FB ; add screen RAM lo
  CLC:ADC #GAMECHAR_COLUMNS ; move down a row
  STA &FB ; update screen RAM lo

  ; Calculate hit-detection offset from X
  LDA tmp3
  LSR A      ; / 2
  CLC:ADC #4 ; + 4
  TAY
  LDA (&FD),Y ; Load from hit-detection bitmap
  STA hitbitflags   ; Store result

  ; Check for even number of X position
  LDA tmp3
  AND #&01
  BEQ l31B5

  LDA #&0F

  JMP l31B7

.l31B5
  LDA #&F0

.l31B7
  STA &033E ; either &F0 (even X pos) or &0F (odd X pos)

  LDA tmp3
  LSR A ; / 2
  TAX
  LDA &1877,X
  TAY
  LDA (&FB),Y ; Load from screen RAM
  AND &033E
  STA &033E

  ; Check hit-detection bitmap value
  LDA hitbitflags
  AND #HIT_SOLID
  CMP #&01 ; Always false due to AND mask above

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
  {
  LDX #&FF ; (2) Game speed

.innerloop
  {
  NOP ; (2)
  NOP ; (2)
  NOP ; (2)
  NOP ; (2)

  DEX ; (2)
  BNE innerloop ; (3 or 2 when not taken)
  }

  DEC &0340 ; (6)
  BNE loop ; (3 or 2 when not taken)
  }

  LDX &0345 ; (4) Restore X

  RTS ; (6)
}

.l31EE
{
  STX &0345 ; Cache X
  STY &0347 ; Cache Y

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
  CMP #28
  BCC l321C

  ; Is it >= 145
  CMP #145
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

  LDX &0345 ; Restore X
  LDY &0347 ; Restore Y

  RTS
}

.l3257
{
  STX &0345 ; Cache X

  INC &03C5
  LDX &03C5

  ; Load character from string table at "BACK YOU GO DIZZY" into &03C6
  LDA &E290,X:STA &03C6

  LDX &0345 ; Restore X

  RTS
}

.l326A
{
  STX &0346 ; Cache X

  INC &03C5
  LDX &03C5

  ; Load character from string table at "INTO THE NEST" into &03C6
  LDA &EA60,X
  AND #&03
  CLC:ADC #&01
  STA &03C6

  LDX &0346 ; Restore X

  RTS
}

.l3282
{
  STX &0345 ; Cache X
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
  CLC:ADC &0384,X
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
  LDX &0345 ; Restore X

  RTS
}

.ruboutframe
{
  LDA objs_xlocs,X:STA frmx ; X position
  LDA objs_ylocs,X:STA frmy ; Y position

  LDA #PLOT_AND+PAL_BLACK
  STA frmattr ; attrib
  STA hitbitflags ; empty

  LDA objs_frames, X ; frame
  JSR frame

  RTS
}

.drawobjframe
{
  LDA objs_xlocs,X:STA frmx ; X position
  LDA objs_ylocs,X:STA frmy ; Y position

  LDA objs_attrs,X:STA frmattr ; attrib
  LDA #HIT_EMPTY:STA hitbitflags

  LDA objs_frames,X ; frame
  JSR frame

  LDA #attr_offs_other:STA attrib_offset

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

  LDA objs_xlocs,X:STA frmx ; X position
  LDA objs_ylocs,X:STA frmy ; Y position
  LDA objs_attrs,X:STA frmattr ; attrib

  ; Check if this is a non-collectable
  LDY #&00
  CPX #maxcollectable+1
  BCS l3373

  ; This is a collectable object
  AND #PAL_WHITE ; Mask off colour
  AND &03D5
  ORA #&08
  TAY

  ; Change plot style if this object has moved from it's initial position
  JSR calcplotstyle
  LDA frmattr:AND #&A7:ORA &FF:STA frmattr ; attrib

.l3373
  STY hitbitflags
  LDA #attr_offs_other:STA attrib_offset
  LDA objs_frames,X ; frame

  JSR frame

  JMP loop
}

.calcplotstyle
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
  STA frmx

  LDA dizzyx:ASL A:CLC:ADC #28:STA dizzyx

  LDA dizzyy:CLC:ADC #90:STA dizzyy

  LDX #&02
.loop
  {
  STX &034E
  JSR l313F

  LDA #COLOUR_WHITE:STA SPR_0_COLOUR,X

  LDA #&33:STA sprite_pointer,X ; Dot sprite
  LDA #&04:STA &0384,X
  LDA #&02:STA &037A,X

  INX
  ; Is it < 6
  CPX #&06
  BCC loop
  }

  LDA dizzyx
  SEC:SBC frmx
  STA &0354
  STA &0355

  LDA dizzyx
  CLC:ADC frmx
  STA &0356
  STA &0357

  LSR frmx

  LDA dizzyy
  SEC:SBC frmx
  STA &035E
  STA &0360

  LDA dizzyy
  CLC:ADC frmx
  STA &035F
  STA &0361

  RTS
}

.l3440
{
  LDX #&05:STX &0346
.loop
  {
  LDX #&02
.innerloop
  {
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
  }

  LDA #&08:JSR delay

  DEC &0346
  BNE loop
  }

  RTS
}

.l346B
{
  LDA olddizzyx:STA dizzyx
  LDA olddizzyy:STA dizzyy

  LDA #&3C
  JSR l33D1

  LDA #&37:STA sprite_pointer ; Reverse death animation "small face"
  LDX #&00:STX &034E
  JSR l31EE

  LDA #&0A:STA &0368
  LDA #&09:STA &0369
  LDA #&06:STA &036A
  LDA #&05:STA &036B

  LDY #&03
.l349F
  JSR l3440

  DEC sprite_pointer
  DEY
  BNE l349F ; Loop until reverse death animation "large face", i.e. &34

  LDA #&00
  STA &03C8
  STA &03C7
  STA &03C9
  STA player_direction ; = ANIM_IDLE
  STA sprite_pointer ; Default Dizzy sprite (arms up"
  STA &03C1

  LDX #&01
.loop
  {
  STX &034E
  JSR l313F

  INX
  ; Is it < 8
  CPX #&08
  BCC loop
  }

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

  LDA #&34:STA sprite_pointer ; Dizzy death "big face"
  LDX #&00:STX &034E
  JSR l31EE

  LDA #TUNE_4:STA melody ; Lose a life / hearts demo melody
  LDA #&05:STA &0368
  LDA #&06:STA &0369
  LDA #&09:STA &036A
  LDA #&0A:STA &036B

  ; Loop from 10 down to 1
  LDY #&0A
.spriteloop
  {
  JSR l3440

  LDA sprite_pointer
  ; Is it < 55
  CMP #&37 ; Dizzy death "small face"
  BCC l3522

  LDA #&45:STA sprite_pointer ; Blank sprite
  JMP l3525

.l3522
  INC sprite_pointer
.l3525
  DEY
  BNE spriteloop
  }

  ; Loop from 0 up to 7
  LDX #&00
.l352A
  {
  STX &034E
  JSR l313F

  INX
  ; Is it < 8
  CPX #&08
  BCC l352A
  }

  LDA #&64:JSR delay

  LDA olddizzyroom:STA roomno

  RTS
}

.mergekeypress
{
  ; Check last pressed key
  LDY KEY_PRESSED
  LDX KEY_SHIFT

  ; Load bitfield
  LDA player_input

  CPY #KEY_Z
  BNE checkx

  ; Simulate joystick left
  ORA #JOY_LEFT
  JMP checkshift

.checkx
  CPY #KEY_X
  BNE checkshift

  ; Simulate joystick right
  ORA #JOY_RIGHT

.checkshift
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

; Get byte at (stringptr) and advance pointer
.nextchar
{
  SEI
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_RAM+LORAM_A000_RAM:STA CPU_CONFIG
  LDY #&00
  LDA (stringptr),Y
  INC stringptr
  BNE samepage

  INC stringptr+1

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
  LDA messages,X:STA stringptr
  LDA messages+1,X:STA stringptr+1
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
  SEC:SBC #mpen
  STA cursorattr

  JMP advance

.notapen
  CMP #mxy
  BCC notxy

  ; Get X position for cursor
  SEC:SBC #mxy-32
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
  LDX cursorx:STX frmx ; X position
  LDX cursory:STX frmy ; Y position
  LDX cursorattr:STX frmattr ; attrib

  LDX #&00
  STX hitbitflags
  STX attrib_offset ; attr_offs_screen

  JSR frame

  INC cursorx
  INC cursorx

  JMP advance
}

.drawmsgbox
{
  ; Get width of messagebox
  JSR nextchar
  STA msgbox_width

  ; Get height of messagebox
  JSR nextchar
  STA msgbox_height

  LDA #&00:STA SPR_ENABLE ; Hide sprites
  LDA cursorx:CLC:ADC #&02:STA &039A

  ; Draw left top-most part of frame
  LDA #SPR_FRAMETOP
  JSR drawchar

  LDA msgbox_width:ASL A:CLC:ADC &039A:STA &039A

  ; Draw right top-most part of frame
  LDA #SPR_FRAMETOP
  JSR drawchar

  ; Draw upper horizontal part of frame
  JSR drawmsgbox_horiz

.loop
  {
  JSR drawmsgbox_vert
  DEC msgbox_height
  BNE loop
  }

  ; Draw lower horiztonal part of frame
  JSR drawmsgbox_horiz

  LDA cursory:CLC:ADC #&08:STA cursory
  LDA cursorx:CLC:ADC #&02:STA &039A

  ; Draw left bottom-most part of frame
  LDA #SPR_FRAMEBOTTOM
  JSR drawchar

  LDA msgbox_width:ASL A:CLC:ADC &039A:STA &039A

  ; Draw right bottom-most part of frame
  LDA #SPR_FRAMEBOTTOM
  JSR drawchar

  RTS
}

; Draw the horiztonal bar of a message box
.drawmsgbox_horiz
{
  LDA cursory:CLC:ADC #&08:STA cursory
  LDA cursorx:STA &039A

  ; Draw left-most point of horizontal
  LDA #SPR_FRAMELEFT
  JSR drawchar

  ; Draw left-side frame intersection
  LDA #SPR_FRAMECROSS
  JSR drawchar

  ; Draw horizontal bar
  LDA msgbox_width:STA cursorindex
.loop
  {
  LDA #SPR_FRAMEHORIZ
  JSR drawchar

  DEC cursorindex
  BNE loop
  }

  ; Draw right-side frame intersection
  LDA #SPR_FRAMECROSS
  JSR drawchar

  ; Draw right-most point of horizontal
  LDA #SPR_FRAMERIGHT
  JSR drawchar

  RTS
}

; Draw left and right verticals of messagebox frame and clear frame contents
;   also leave cursor Y in place to draw bottom horizontal bar
.drawmsgbox_vert
{
  LDA cursory:CLC:ADC #&08:STA cursory
  LDA cursorx:CLC:ADC #&02:STA &039A

  ; Draw left side of frame
  LDA #SPR_FRAMEVERT
  JSR drawchar

  ; Clear middle of frame
  LDA msgbox_width:STA cursorindex
.loop
  {
  LDA #SPR_SPACE
  JSR drawchar

  DEC cursorindex
  BNE loop
  }

  ; Draw right side of frame
  LDA #SPR_FRAMEVERT
  JSR drawchar

  RTS
}

.drawchar
{
  LDX &039A:STX frmx ; X position
  LDX cursory:STX frmy ; Y position
  LDX cursorattr:STX frmattr ; attrib

  LDX #&00
  STX hitbitflags ; empty
  STX attrib_offset ; attr_offs_screen

  JSR frame

  ; Advance cursor
  INC &039A
  INC &039A

  RTS
}

.printinventoryitem
{
  ; First check for empty inventory list
  LDX inventorylist
  BNE notempty

  RTS

.notempty
  ; Calculate string pointer offset
  ASL A
  TAX

  SEI
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_RAM+LORAM_A000_RAM:STA CPU_CONFIG
  CPX #obj_bucket*2
  BNE notbucket

  ; Check if bucket is blue - has water in it
  LDA objs_attrs+obj_bucket
  CMP #PAL_BLUE
  BNE notbucket

  LDA messages+(str_fullbucketmess*2):STA stringptr
  LDA messages+(str_fullbucketmess*2)+1
  JMP setstringptrhi

.notbucket
  LDA objnames,X:STA stringptr
  LDA objnames+1,X
.setstringptrhi
  STA stringptr+1

  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_RAM:STA CPU_CONFIG
  CLI

  ; If ptr hi is zero (no name) it means don't print
  LDA stringptr+1
  BEQ done

.printloop
  {
  JSR nextchar

  ; Check if char is within messagebox range
  ; Is it < 38
  CMP #SPR_SPEECHOPEN
  BCC done

  ; Is it >= 91
  CMP #SPR_Z+1
  BCS done

  JSR drawchar

  JMP printloop
  }

.done
  RTS
}

.buildinventorylist
{
  LDA #obj_null

  ; Clear inventory list
  LDX #&00
.clearloop
  {
  STA inventorylist,X
  INX
  ; Loop while it is < 5
  CPX #BIGBAGSIZE+1
  BCC clearloop
  }

  ; Find items for inventory
  LDX #mincollectable
  LDY #&00
.buildloop
  {
  ; Is this object in "collected" room
  LDA objs_rooms,X
  CMP #collected
  BNE nextobj

  ; Add id for this object to inventory list
  TXA
  STA inventorylist,Y
  INY

.nextobj
  INX
  ; Is it within range of collectables?
  CPX #maxcollectable+1
  BCC buildloop
  }

  ; Add an end marker
  LDA #&00:STA inventorylist,Y

  RTS
}

.drawinventory
{
  JSR buildinventorylist
  LDX #str_inventory

  ; Check for larger inventory
  LDA objs_rooms+obj_bag
  CMP #collected
  BNE drawbag

  LDX #str_inventorywithbag
.drawbag
  TXA
  JSR prtmessage

  LDY #&58 ; small bag

  ; Check for larger inventory
  LDA objs_rooms+obj_bag
  CMP #collected
  BNE setcursory

  LDY #&50 ; large bag
.setcursory
  STY cursory

  LDA #&00:STA cursorindex
  LDA #PAL_MAGENTA:STA cursorattr
.loop
  {
  LDA #&2C:STA &039A

  LDX cursorindex
  LDA inventorylist,X
  JSR printinventoryitem

  LDX cursorindex
  LDA inventorylist,X
  BEQ endoflist

  ; Advance down to next line
  INC cursorindex

  LDA cursory:CLC:ADC #&08:STA cursory
  JMP loop
  }

.endoflist
  LDA inventorylist
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
  LDA roomnames,X:STA stringptr
  LDA roomnames+1,X:STA stringptr+1
  LDA #CASSETTE_OFF+CASSETTE_SWITCH+CHAREN_IO+HIRAM_E000_ROM+LORAM_A000_RAM:STA CPU_CONFIG
  CLI

  ; Set starting X position
  LDX #44
.loop
  {
  ; Get next character to print
  JSR nextchar

  ; Make sure it's not a string terminator
  CMP #mend
  BNE keepgoing

.^done
  RTS

.keepgoing
  STX frmx ; X position

  LDY #24
  STY frmy ; Y position
  STY &03E3

  LDY #PAL_CYAN:STY frmattr ; attrib
  LDY #attr_offs_screen:STY attrib_offset
  JSR frame

  ; Advance cursor
  INX:INX

  ; Next character
  JMP loop
  }
}

.showlives
{
  LDA #&00:STA &03DB

  LDX #46
.loop
  {
  STX frmx ; X position

  LDA #8
  STA frmy ; Y position
  STA &03E3

  LDY #PAL_BLACK ; Default to rubbing out life indicator eggs

  LDA &03DB
  CMP lives
  BCS keepattr

  LDY #PAL_YELLOW ; Draw life indicator eggs in yellow
.keepattr
  STY frmattr ; attrib

  LDA #attr_offs_screen:STA attrib_offset

  LDA #SPR_EGG ; frame
  JSR frame

  ; Check next life indicator
  INC &03DB
  INX
  INX
  ; Loop round again if X position < 50
  CPX #50
  BCC loop
  }

  RTS
}

.heartdemo
{
  JSR cleargamescreen

  LDA #&00:STA &03DB
  LDA #TUNE_4:STA melody ; Lose a life / hearts demo melody

.loop
  {
  JSR l3257
  AND #&3F
  CLC:ADC #&20
  STA frmx ; X position

  JSR l3257
  AND #&7F
  CLC:ADC #&30
  STA frmy ; Y position

  LDA #PLOT_XOR+PAL_RED:STA frmattr ; attrib

  LDA #&00
  STA hitbitflags ; empty
  STA attrib_offset ; attr_offs_screen

  JSR l326A

  CMP #&04
  BNE l3882

  LDA #&01
.l3882
  CLC:ADC #SPR_HEARTNULL ; frame
  JSR frame

  LDA #&05:JSR delay

  INC &03DB
  BNE loop
  }

  RTS
}

; Get pointer to sprite in &FB, result in &B4/&B5
.getframepointer
{
  ; Set initial high-byte
  LDA #hi(frametable):STA &FC

  ; Double low-byte
  LDA &FB
  CLC:ADC &FB
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
  LDA gamecounter
  AND #&01
  BNE l38BB

  JMP l3931

.l38BB
  LDX &03E0
  BNE l38C3

  JMP l392A

.l38C3
  ; Set pointer &B2 to screen attribute RAM
  LDA screenattrtable_hi,X:SEC:SBC #&04:STA &B3
  LDA screenattrtable_lo,X:STA &B2

  LDA &03DA
  SEC:SBC #&18 ; -24
  LSR A        ; /2
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
  CLC:ADC #&18 ; +24
  STA frmx ; X position

  LDA &03E0
  ASL A
  ASL A
  ASL A
  STA frmy ; Y position

  LDA roomno
  CMP #ACTIVEVOLCANOROOM
  BNE notlava

  LDA #ATTR_GRID+PAL_RED ; It's lava
  JMP l3903

.notlava
  LDA #ATTR_GRID+PAL_WHITE ; It's water

.l3903
  STA frmattr ; attrib

  LDA #HIT_EMPTY:STA hitbitflags

  LDA gamecounter
  LSR A
  AND #&03
  CLC:ADC #SPR_WATER0 ; frame
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
  {
  LDA flame_x,X:STA frmx ; X position
  LDA flame_y,X:STA frmy ; Y position

  LDA #&00
  STA frmattr ; attrib
  STA hitbitflags ; empty
  STA attrib_offset ; attr_offs_screen

  LDA #SPR_FLAME ; frame
  JSR frame

  INX
  CPX &03DB
  BCS l3962

  CPX flameindex
  BCC l393B
  }

.l3962
  LDX &034E
.l3965
  {
  LDA flame_attr,X
  EOR #ATTR_REVERSE
  STA flame_attr,X
  STA frmattr ; attrib

  LDA flame_x,X:STA frmx ; X position
  LDA flame_y,X:STA frmy ; Y position
  LDA #HIT_FIRE:STA hitbitflags
  LDA #attr_offs_screen:STA attrib_offset
  LDA #SPR_FLAME ; frame
  JSR frame

  INX
  CPX &03DB
  BCS done

  CPX flameindex
  BCC l3965
  }

.done
  RTS
}

; Collecting a coin
.collect_coin
{
  ; Check to see if this object is a coin - just done before entering this function, but hey ?
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LDX pickupobj
  CPX #firstcoin
  BCC done

  CPX #lastcoin+1
  BCS done
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Set this coin to "collected", by removing from room
  LDA #OFFMAP
  STA objs_rooms,X
  STA pickupobj

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
  LDA dizzyx:CLC:ADC #33:STA frmx
  CLC:ADC #4:STA frmattr ; +width ??

  LDA dizzyy:CLC:ADC #42:STA frmy
  CLC:ADC #21:STA &033D ; +height ??

  ; Return if object.x >= dizzy.x (Dizzy to the left)
  LDA objs_xlocs,X
  CMP frmattr
  BCS objelsewhere

  ; Return if object.x+object.width <= dizzy.x (Dizzy to the right)
  LDY #&00
  LDA (&B4),Y ; Get object width
  CLC:ADC objs_xlocs,X ; Add object.x
  CMP frmx
  BCC objelsewhere
  BEQ objelsewhere

  ; Return if object.y >= dizzy.y (Dizzy above)
  LDA objs_ylocs,X ; Get object.y
  CMP &033D
  BCS objelsewhere

  ; Return if object.y+object.height <= dizzy.y (Dizzy below)
  INY
  CLC:ADC (&B4),Y ; Add object height
  CMP frmy
  BCC objelsewhere
  BEQ objelsewhere

  SEC ; collision

  RTS
}

; Print coins collected counter to screen
.drawcoincount
{
  LDA #78:STA frmx ; X position
  LDA #attr_offs_screen:STA attrib_offset

  LDA #8
  STA frmy ; Y position
  STA &03E3

  LDA #PAL_YELLOW:STA frmattr ; attrib

  ; Convert tens to ASCII
  LDA coins_tens
  CLC:ADC #'0' ; frame

  JSR frame

  LDA #80:STA frmx ; X position
  LDA #attr_offs_screen:STA attrib_offset

  LDA #8
  STA frmy ; Y position
  STA &03E3

  LDA #PAL_YELLOW:STA frmattr ; attrib

  ; Convert units to ASCII
  LDA coins
  CLC:ADC #'0' ; frame

  JSR frame

  RTS
}

.setinventorycolour
{
  TAX
  LDA c64palette,X:STA frmattr

  LDA #&0B ; Default to small bag (drawn lower down screen)

  ; Check for larger inventory (bag collected)
  LDX objs_rooms+obj_bag
  CPX #collected
  BNE l3A83

  LDA #&0A ; Big bag (drawn higher up screen - top of play area)
.l3A83
  ; Create pointer to colour attribs RAM for selected inventory line
  CLC:ADC inventoryindex
  TAX
  LDA screenattrtable_lo,X:STA &FB
  LDA screenattrtable_hi,X:STA &FC

  ; Set colour of text
  LDY #&09 ; Left X position of inventory item text (min 0)
  LDA frmattr
.loop
  {
  STA (&FB),Y
  INY
  ; Is it < 31
  CPY #&1F ; Right X position of inventory item text (max 40)
  BCC loop
  }

  RTS
}

.drawdragonflames
{
  ; Set start/end X positions for flames ??
  LDA dragonflamepos:CLC:ADC #8:STA &03DB

  LDX dragonflamepos
.loop
  {
  ; Is it < 50
  CPX #50
  BCC nextflame

  ; Is it >= 68
  CPX #68
  BCS nextflame

  STX frmx ; X position

  LDA objs_ylocs+obj_dragonneck6:STA frmy ; Y position

  ; Drawing yellow flames
  LDA #PAL_YELLOW

  ; Is Xreg < [&03DB]
  CPX &03DB
  BCC storeattrs

  ; Erase flames by drawing black ones
  LDA #PAL_BLACK
.storeattrs
  STA frmattr ; attrib

  LDA #&00
  STA hitbitflags ; empty
  STA attrib_offset ; attr_offs_screen

  LDA #SPR_DRAGONFIRE ; frame
  JSR frame

.nextflame

  INX
  INX
  CPX &03DB ; Is Xreg <= [&03DB]
  BEQ loop
  BCC loop
  }

  LDX #obj_dragonhead
  LDA #attr_offs_screen:STA attrib_offset
  JSR drawobjframe

  RTS
}

; Cheat mode key-sequence
.eclipse
{
  EQUB KEY_E
  EQUB KEY_S
  EQUB KEY_P
  EQUB KEY_I
  EQUB KEY_L
  EQUB KEY_C
  EQUB KEY_E
}

cheatcodelen = * - eclipse

; Room number adjustments based on key pressed
;   These indexes map to JOYSTICK bitfield
.roomchange
{
  EQUB 0
  EQUB 16   ; Go up (+16)    Joystick UP / Keyboard "SHIFT" or "COMMODORE" or "CONTROL"
  EQUB 0-16 ; Go down (-16)  Joystick DOWN
  EQUB 0
  EQUB 0-1  ; Go left (-1)   Joystick LEFT / Keyboard "Z"
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 1    ; Go right (+1)  Joystick RIGHT / Keyboard "X"
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
  EQUB 0
}

.checkcheatmode
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
  CPX #cheatcodelen
  BCC nextchar

  ; ### Cheat mode activate ###

.l3B16 ; &3B16

  LDA #&00:STA SPR_ENABLE ; Hide sprites

  LDA #2:STA lives ; Reset lives
  JSR showlives

.cheatloop
  {
  LDA #&32:JSR delay

  JSR getplayerinput
  AND #JOY_FIRE+JOY_RIGHT+JOY_LEFT+JOY_DOWN+JOY_UP
  ; If FIRE or RETURN are pressed, exit cheat mode
  CMP #JOY_FIRE
  BCS done

  ; Mask off FIRE button
  AND #JOY_RIGHT+JOY_LEFT+JOY_DOWN+JOY_UP
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
  }

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

  LDA #COLOUR_BLACK:STA GFX_BORDER_COLOUR

  LDA #&FF:STA &03DF
  LDA #&B8:STA &03E1
  LDA #&30:STA &03E3
  LDA #attr_offs_other:STA attrib_offset

  RTS
}

ORG &4000
INCLUDE "dizzy_sprites.asm"
; &5180 - end of sprite bitmaps

ORG &5800
.spec_screen_attribs ; []
INCBIN "attribs.bin"
;&58F5 to &5B92 = solidity bitmap (&40=solid, &20=fire, &10=water, &00=empty)

ORG &5C00
; to 5FE7 = 8x8 screen/border colour attribs
.screen_attribs

ORG &5FF8
.sprite_pointer ; hw sprite "pointers" [8]
{
  EQUB &4E ; sprite 0
  EQUB &36 ; sprite 1
  EQUB &00 ; sprite 2
  EQUB &0A ; sprite 3
  EQUB &60 ; sprite 4
  EQUB &48 ; sprite 5
  EQUB &26 ; sprite 6
  EQUB &43 ; sprite 7
}

ORG &6000
.screen_memory
; &6000..&7F3F = screen RAM (320x200 hires bitmap mode, $d011=$3b, $d016=8)
INCBIN "screendump.bin"

.l7F40
{
  ; $DD00 = %xxxxxx10 -> Bank1: $4000-$7FFF
  LDA #&C6:STA CIA2_PRA

  LDA #&3B:STA GFX_VICII_REG1 ; rst8|ecm|BMM|DEN|RSEL|YSCROLL - Character

  ; $D018 = %xxxx100x -> CharMem is at $2000 (#8192)
  ; $D018 = %0111xxxx -> ScreenMem is at $1c00 (#7168)
  LDA #&78:STA GFX_MEM_PTR

  LDA #COLOUR_BLACK:STA GFX_BORDER_COLOUR

  RTS
}

ORG &8000
.roomdata
INCBIN "roomdata.bin"

  EQUB &00, &00, &00, &00, &00, &00, &00, &00, &00
  EQUB &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00, &00
  EQUB &00, &00, &dd, &8e, &18, &d4, &ca, &8e, &02, &dc, &a9, &07, &8d, &00, &dd, &a9

; &A400
; Horizontal flip look up table
.flip_lut
{
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
}

.frametable
INCBIN "frametable.bin"
.framedefs
INCBIN "framedefs.bin"
; to &C388

ORG &C400
INCLUDE "objects.asm"

ORG &D000
INCLUDE "strings.asm"
; to &F007

ORG &FFFF
.c64end

SAVE "c64_built", c64start, c64end
