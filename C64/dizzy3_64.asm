INCLUDE "consts.asm"
INCLUDE "sprites.asm"

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

CIA1_PRA = &DC00
CIA2_PRA = &DD00

JOY_UP    = %00000001
JOY_DOWN  = %00000010
JOY_LEFT  = %00000100
JOY_RIGHT = %00001000
JOY_FIRE  = %00010000

ORG &00

.c64start

; Variables
.v0001 ; processor port (mem config)

.v0005 ; int to float routine
.v0006

.v0035 ; pointer to string memory (5A77 / 5A4D / 5A5D / 581C / 5AF0)
.v0036

.v00A7 ; pointer (148D / 14EB / 1502 / 1397 / 14F2 / 14FE)
.v00A8

.v00A9 ; pointer (149F / 130F)
.v00AA

.v00B0 ; pointer (8EB7 / 81B0 / 8678 / 8177 / 8FD8) - ROOMDATA
.v00B1

.v00B2 ; pointer (5B48 / 81B0 / 5B20 / 8177 / 8FD8 / 5B48) - ROOMDATA + ?OTHER?
.v00B3

.v00B4 ; pointer (BA83 / A779 / BA81) - FRAMEDATA
.v00B5

.v00C5 ; previously pressed key

.v00FB ; pointer (73BE / 726E / 60E4 / 7787 / 72ED) - SCREEN RAM
.v00FC

.v00FD ; pointer (5E77 / 5E4D / 5C1C / 5EF0 / 5E5D)
.v00FE

.v00FF

.v0314 ; ISR lo
.v0315 ; ISR hi

.v0339
.v033A ; X position
.v033B ; Y position
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
.v0366
.v0368
.v0369
.v036A
.v036B
.v0370
.v037A
.v0384
.v0398
.v0399
.v039A
.v039B
.v039C
.v03B7
.v03B8 ; roomno related ?
lives = &03B9
.v03BA
.v03BB
.v03BC
.v03BD
.v03BE
.v03BF
.v03C0 ; input bitfield ?
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
.v03D6 ; dizzyx related ?
.v03D7 ; dizzyy related ?
.v03D8
.v03D9
.v03DA
.v03DB
.v03DC
.v03DD ; set to &3F and &86
.v03DF
.v03E0
.v03E1
.v03E2
.v03E3
roomno = &03E5

ORG &0B00

.v0B00
  EQUB &FF

.l0B01
{
  LDA v0B00
  BNE l0B0F

  STA &116D
  JSR l0F78
.l0B0C
  JMP l0F72

.l0B0F
  ; Is it >= 5
  CMP #&05
  BCS l0B50

  SBC #&00
  ASL A
  STA &0B1B
  ASL A
  ADC #&00
  TAY
  LDX #&00
.l0B1F
  LDA &1235,Y:STA &11BC,X
  INY
  LDA &1235,Y:STA &11BF,X
  INY
  INX
  CPX #&03
  BNE l0B1F

  LDX #&02
.l0B34
  LDA #&00
  STA &1188,X
  STA &118B,X
  STA &1170,X
  JSR l0FC3

  DEX
  BPL l0B34

  JSR l1147

  LDA #&01:STA &116D
  JMP l0F72

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

  LDA #&00:STA v0B00
  JMP l0B01

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
  BPL l0F72

  LDA &116E:STA &116F
}

; Fall through

.l0F72
{
  LDA #&FF:STA v0B00

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

.l0FC3
{
  LDA &11BC,X:STA &A9
  LDA &11BF,X:STA &AA

.l0FCD
  LDY &1170,X
  INC &1170,X
  LDA (&A9),Y
  BPL l0FEB

  CMP #&FF
  BNE l0FE2

  LDA #&00:STA &1170,X
  BEQ l0FCD

.l0FE2
  CLC
  ADC #&40
  STA &1191,X
  JMP l0FCD

.l0FEB
  ASL A
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
.l105B
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
  BNE l105B

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

.v1085
.v1086

.v10E6
.v10E7

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

.v1158
.v115B
.v115E
.v1166
.v1169
.v116C
.v116D
.v116E
.v116F
.v1170
.v1173
.v1176
.v1179
.v117C
.v117F
.v1182
.v1185
.v1188
.v118B
.v118E
.v1191
.v1194
.v1197
.v119A
.v119B
.v119C
.v119D
.v11A0
.v11A3
.v11A6
.v11A9
.v11AA
.v11AB
.v11AE
.v11B1
.v11B4
.v11B7
.v11B8
.v11B9
.v11BA
.v11BB
.v11BC
.v11BF
.v11C2
.v11C3
.v11C6
.v11C9
.v11CA
.v11CB
.v11CC
.v11CD
.v11ED
.v11EE
.v11EF
.v11F0
.v1215
.v1225
.v1235
.v124D
.v124E
.v124F
.v1250
.v1251
.v1252
.v1253
.v1254
.v12DD
.v12DE
.v180E
.v1828
.v1877
.v1897

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

.v18D9
.v18DE ; object table offset / &FF / ????
coins_tens = &18E5
coins = &18E6
.v18E7
.v18E8
.v18EC
.v18F0
.v18F4
.v18F8
.v1903

; Entry point ??

ORG &190E

.l190E
  JSR l2B32
  LDX #&C6
  LDA #&00
.l1915
  STA &0339,X
  DEX
  BNE l1915

  JSR l3B6D
  LDA #&36:STA &01
  LDA #&0A:STA v0B00
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

  LDA #&01:STA v0B00
  LDA #&00:STA &033F

  JSR l3B6D
  JSR l3023

  LDA #&58:STA &03DC
  LDA #TITLEROOM:STA roomno

  JSR l2E79
  JSR l3090
  JSR l3A30

  LDA #&3A:STA &033A ; X position
  LDA #&39:STA &033B ; Y position
  LDA #PAL_GREEN:STA &033C ; attrib
  LDA #&00:STA &03DC

  LDA #SPR_DIZZYLOGO ; frame
  JSR frame

  JSR printroomname

  LDA #&00
  JSR l357D

  JSR l3023

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

  JSR l3A30

  LDA #&00
  STA SPR_Y_EXP
  STA SPR_X_EXP
  STA SPR_MULTICOLOUR
  STA &CFF8
  STA SPR_PRIORITY
  STA v2B48

  ; Reset moving data (objects)
  LDX #noofmoving
.l19DA
  DEX
  LDA orig_rooms,X:STA objs_rooms,X ; room
  LDA orig_xlocs,X:STA objs_xlocs,X ; X position
  LDA orig_ylocs,X:STA objs_ylocs,X ; Y position
  LDA orig_attrs,X:STA objs_attrs,X ; attrib
  LDA orig_frames,X:STA objs_frames, X ; frame

  CPX #&00
  BNE l19DA

  JSR l29E4

  LDA #&1C
  STA &03D6
  STA dizzyx ; Dizzy starting X position

  LDA #&64
  STA &03D7
  STA dizzyy ; Dizzy starting Y position

  LDA #&FF:STA &03DF

  LDA #&00:STA &03E0

  JSR l2F22
  JSR l346B

  LDA #&02:STA v0B00
.l1A25
  NOP
  JSR l3541

  CPY #&3E
  BNE l1A30

  JMP l1927

.l1A30
  CPY #&29
  BNE l1A45

.l1A34
  JSR l3541

  CPY #&40
  BNE l1A34

.l1A3B
  JSR l3541

  CPY #&40
  BEQ l1A3B

  JMP l1A6C

.l1A45
  CPY #&24
  BNE l1A6C

  LDA v2B48
  BEQ l1A5B

  LDA #&00:STA v2B48
  LDA #&02:STA v0B00

  JMP l1A65

.l1A5B
  LDA #&00:STA v0B00
  LDA #&01:STA v2B48
.l1A65
  JSR l3541
  CPY #&24
  BEQ l1A65

.l1A6C
  JSR l3B00
  JSR l33AA

  LDA #&00:STA &03C1
  LDA &03BC
  JSR l31D6
  INC &03C4

  ; Check brandy bottle
  LDA objs_rooms+obj_brandy
  CMP #OFFMAP
  BNE l1A96

  LDA &03C4
  AND #&20
  BNE l1A96

  LDA &03C0
  EOR #&0C
  STA &03C0

.l1A96
  LDA &03BE
  BEQ l1A9E

  DEC &03BE
.l1A9E
  ; Is it >= 25 (therefore invalid)
  LDA roomno
  CMP #&19
  BCS l1AD2

  LDA &03C0
  AND #&0C
  BEQ l1AB4

  LDA &03C0
  EOR #&0C
  STA &03C0
.l1AB4
  JSR l3257

  ; Is it < 250
  CMP #&FA
  BCC l1AD2

  JSR l326A

  AND #&01
  ORA &03C0
  STA &03C0

  JSR l326A

  ASL A
  AND #&0C
  ORA &03C0
  STA &03C0
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

  LDA &03C0
  AND #&0D
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
  LDA #&00:STA &03C0
.l1B68
  ; Is it >= 2
  LDA &03C8
  CMP #&02
  BCS l1B95

  LDA &03C0
  AND #&04
  BNE l1B80

  LDA &03C0
  AND #&08
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

  LDA &03C0
  AND #&01
  BNE l1BAD

  JMP l1B9C

.l1BAD
  LDA &03C0
  AND #&0F
  CMP #&01
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
  STA &0342

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
  CMP #&39
  BCC l1DB9

  LDA #&02:STA dizzyx ; Set Dizzy position to far left
  INC roomno ; Go right
  JMP l1DFC

.l1DB9
  ; Check Dizzy X position >= 2 (not gone off screen to left)
  CMP #&02
  BCS l1DC8

  LDA #&38:STA dizzyx ; Set Dizzy position to far right
  DEC roomno ; Go left
  JMP l1DFC

.l1DC8
  ; Check Dizzy Y position < 50
  LDA dizzyy
  CMP #&80
  BCC l1E1D

  ; Check Dizzy Y position >= 192
  CMP #&C0
  BCS l1DE7

  LDA #&00:STA dizzyy
  LDA roomno:SEC:SBC #16:STA roomno ; Go down

  JSR l2A01
  JMP l1DFC

.l1DE7
  ; Check Dizzy Y position < 192
  LDA dizzyy
  CMP #&C0
  BCC l1E1D

  LDA #&72:STA dizzyy
  LDA roomno:CLC:ADC #&10:STA roomno ; Go up

.l1DFC
  LDA roomno
  CMP #EASTWINGROOM
  BEQ l1E12

  STA &03B8
  LDA dizzyx:STA &03D6
  LDA dizzyy:STA &03D7
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
  JSR l2A7F
  STA &5FF8
  LDA #&FF:STA SPR_ENABLE
  LDA &03C7
  CMP #&02
  BEQ l1ECC

  LDX #&43
  JSR l39D4
  BCC l1ECC

  LDA #&26
  JSR l357D

  LDA #&00
  STA &03C7
  STA &03C8

  LDA #&05:STA &03C0
  JMP l1B68

.l1ECC
  LDX #&41
  JSR l39D4
  BCC l1EE8

  ; Make shopkeeper appear
  LDA #MARKETSQUAREROOM
  STA &C6DD
  STA &C6DE

  LDA #OFFMAP:STA &C6DF

  LDA #&02
  JSR l357D
  JMP l1F33

.l1EE8
  LDA roomno
  CMP #MINESROOM
  BNE l1F33

  ; Check Dizzy X position < 52 (far right)
  LDA dizzyx
  CMP #&34
  BCC l1F33

  ; Check where troll is
  LDA #MINESROOM
  CMP objs_rooms+obj_troll
  BEQ l1F33

  ; Put troll in mine
  STA objs_rooms+obj_troll

  LDA #&5A:STA objs_xlocs+obj_troll
  LDA #&78:STA objs_ylocs+obj_troll
  LDA #ATTR_NOTSOLID+PAL_GREEN:STA objs_attrs+obj_troll
  LDA #OFFMAP:STA &C6E1

  LDX #obj_troll
  JSR l29D3

  LDA #&1F
  JSR l357D

  LDA #&00
  STA &03C7
  STA &03C8

  LDA #&05:STA &03C0
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
  LDA &03C0
  AND #&EF
  STA &03C0
.l1F50
  LDA &03C0
  AND #&10
  BNE l1F5A

  JMP l24A0

.l1F5A
  LDX #&00
.l1F5C
  LDA dizzyx
  CLC
  ADC #&1E
  STA &033A ; X position
  CLC
  ADC #&08
  STA &033C
  LDA dizzyy
  CLC
  ADC #&1A
  STA &033B ; Y position
  CLC
  ADC #&22
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
  ; Is it < 63
  CPX #&3F
  BCC l1F7A

  LDX #&FF
  STX &18DE
.l1FB3
  LDX #&5E
  JSR l39D4
  BCC l1FD1

  ; Check rope
  LDY #&0A
  LDA objs_rooms+obj_rope
  CMP #&65
  BNE l1FCA

  ; Make rope appear
  LDA #BANQUETHALLROOM:STA objs_rooms+obj_rope

  LDY #&09
.l1FCA
  TYA
  JSR l357D
  JMP l24A0

.l1FD1
  LDX #&55
  JSR l39D4
  BCC l1FE0

  LDA #&12
  JSR l357D
  JMP l24A0

.l1FE0
  LDX #&53
  JSR l39D4
  BCC l1FFB

  ; Check if portcullis switch has been activated
  LDA objs_attrs+obj_switch
  CMP #PAL_CYAN
  BNE l1FFB

  ; Activate portcullis switch
  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_switch
  LDA #&16
  JSR l357D
  JMP l24A0

.l1FFB
  LDX #&4A
  JSR l39D4
  BCC l202B

  ; Check sleeping potion
  LDA objs_rooms+obj_sleepingpotion
  CMP #&65
  BNE l2013

  ; Make sleeping potion appear
  LDA #OUTTOSEAROOM:STA objs_rooms+obj_sleepingpotion

  LDY #&05
  JMP l2024

.l2013
  LDX #obj_dozy
  JSR l32EB

  ; Position Dozy
  LDA #&3C:STA objs_xlocs+obj_dozy
  LDA #&86:STA objs_ylocs+obj_dozy
  LDY #&06
.l2024
  TYA
  JSR l357D
  JMP l24A0

.l202B
  LDA roomno
  CMP #CASTLESTAIRCASEROOM
  BNE l2048

  ; Check for doorknocker
  LDA objs_rooms+obj_doorknocker
  CMP #&04 ; ?? room 4 ??
  BEQ l2048

  LDX #&44
  JSR l39D4
  BCC l2048

  LDA #&20
  JSR l357D
  JMP l24A0

.l2048
  LDX #&63
  JSR l39D4
  BCC l2066

  ; Check crowbar
  LDY #&10
  LDA objs_rooms+obj_crowbar
  CMP #&65
  BNE l205F

  ; Make crowbar appear
  LDA #LIFTTOELDERSROOM:STA objs_rooms+obj_crowbar
  LDY #&0F
.l205F
  TYA
  JSR l357D
  JMP l24A0

.l2066
  LDX #&5C
  JSR l39D4
  BCC l2084

  ; Check Dylan orientation
  LDY #&08
  LDA objs_attrs+obj_dylan
  CMP #PAL_WHITE
  BNE l207D

  ; Make Dylan face the other way
  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_dylan
  LDY #&07
.l207D
  TYA
  JSR l357D
  JMP l24A0

.l2084
  LDX #&64
  JSR l39D4
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

  INC objs_ylocs+obj_liftbottom
  JSR l29D3

  INX ; switch from liftbottom to daisy
  JSR l32EB

  INC objs_ylocs+obj_daisy
  LDA objs_attrs+obj_daisy:EOR #ATTR_REVERSE:STA objs_attrs+obj_daisy
  JSR l29D3

  LDX #obj_lifttop
  INC objs_ylocs+obj_lifttop
  JSR l29D3

  LDA #&0A
  JSR l31D6
  LDA objs_ylocs+obj_liftbottom
  ; Is it < 139
  CMP #&8B
  BCC l209A

  JMP l24A0

.l20CE
  LDX #&46
  JSR l39D4
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

  ; Change bag room to 4 ?
  LDA #&04:STA objs_rooms+obj_bag
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
  LDA #&15
  JSR l357D
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
  CMP #&04
  BNE l213A

  LDA roomno:STA objs_rooms,X ; place object in current room

  LDA dizzyx
  CLC
  ADC #&21
  AND #&FE
  STA objs_xlocs,X ; Update X position of object based on Dizzy X position

  LDA dizzyy:CLC:ADC #&2D:STA objs_ylocs,X
.l213A
  INX
  ; Is it < 63
  CPX #&3F
  BCC objloop

  LDA #&27
  JSR l357D
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
  ; Is it >= 63
  CPX #&3F
  BCS l21A0

  LDA #&04
  STA objs_rooms,X
  CPX #lastcoin+1
  BCC l2177

  LDA &C696,X
  CMP #&65
  BNE l2177

  LDA roomno:STA &C696,X
.l2177
  JSR l374F

  ; Check bag is in room #4 ?
  LDA objs_rooms+obj_bag
  LDX #&02
  CMP #&04
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
  LDA #&3A
  JSR l357D
.l21A0
  LDA #&00
  STA SPR_ENABLE
  JSR l3776
  LDA &18D9
  BEQ l21B4

  LDA &03D9
  CMP #&FF
  BEQ l21C4

.l21B4
  LDA #&F0
  JSR l31D6
  LDA #&F0
  JSR l31D6
  JSR l2F39
  JMP l242D

.l21C4
  LDA #&39
  JSR l357D
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
  LDA #&3C
  JSR l31D6
.l21E1
  JSR l33AA
  LDA &03C0
  AND #&1C
  BEQ l21E1

  AND #&10
  BEQ l2202

  LDX &03D9
  LDA &18D9,X
  BNE l21F9

  LDA #&FF
.l21F9
  STA &03D9
  JSR l2F39
  JMP l222E

.l2202
  LDA #&03
  JSR l3A71
  LDA &03C0
  AND #&04
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
  LDX #&3F
  JSR l39D4
  BCC l225C

  LDA &03D9
  CMP #&06
  BEQ l2244

  LDA #&03
  JSR l357D
  JMP l242D

.l2244
  ; Make bean appear
  LDA #MARKETSQUAREROOM:STA objs_rooms+obj_bean
  JSR l29C1

  ; Hide shopkeeper
  LDA #OFFMAP
  STA &C6DD
  STA &C6DE

  LDA #&04
  JSR l357D
  JMP l242D

.l225C
  LDA &03D9
  CMP #&12
  BNE l2275

  LDX #&42
  JSR l39D4
  BCC l2272

  JSR l29C1
  LDA #&01
  JSR l357D
.l2272
  JMP l242D

.l2275
  CMP #&14
  BNE l2295

  LDX #&44
  JSR l39D4
  BCC l2272

  JSR l29C1
  LDA #&11
  JSR l357D

  LDA #CASTLESTAIRCASEROOM:STA &C6E2
  LDA #&24:STA &C768

  JMP l242D

.l2295
  CMP #&10
  BNE l22B0

  LDX #&56
  JSR l39D4
  BCC l2272

  JSR l29C1
  ; Update crocodile animation frame
  LDA #SPR_CROCCLOSED:STA objs_frames+obj_croc
  LDA #&19
  JSR l357D
  JMP l242D

.l22B0
  ; Is it < 23
  CMP #&17
  BCC l22E2

  ; Is it >= 26
  CMP #&1A
  BCS l22E2

  LDX #&4F
  JSR l39D4
  BCC l2272

  LDA &C7F5
  SEC
  SBC #&05
  STA &C7F5
  STA &C7F6
  STA &C7F7
  LDA &C7F8
  SEC
  SBC #&05
  STA &C7F8
  JSR l29C1
  LDA #&1A
  JSR l357D
  JMP l242D

.l22E2
  CMP #&16
  BNE l2307

  LDX roomno
  CPX #CASTLESTAIRCASEROOM
  BNE l2307

  LDX #&44
  JSR l39D4
  BCC l2304

  JSR l29C1

  ; Remove plank and (egg?)
  LDA #OFFMAP
  STA objs_rooms+obj_plank
  STA &C6E2

  LDA #&21
  JSR l357D
.l2304
  JMP l242D

.l2307
  CMP #&05
  BNE l2324

  LDX #&52
  JSR l39D4
  BCC l2304

  LDA #&17
  JSR l357D
  LDA #ATTR_REVERSE+PAL_WHITE:STA objs_attrs+obj_bone
  LDA #OFFMAP:STA &C6F0
  JMP l242D

.l2324
  CMP #&03
  BNE l233F

  LDX #&57
  JSR l39D4
  BCC l2304

  JSR l29C1
  LDA #OFFMAP:STA objs_rooms+obj_wood
  LDA #&22
  JSR l357D
  JMP l242D

.l233F
  CMP #&01
  BNE l2365

  LDX #&02
  JSR l39D4
  BCC l2304

  JSR l29C1
  LDA #&14
  JSR l357D
  JMP l242D

.l2355
  LDA #&00
  STA &03C7
  STA &03C8

  LDA #&05:STA &03C0
  JMP l1B68

.l2365
  CMP #&04
  BNE l23A7

  ; Check colour of bucket
  LDA objs_attrs+obj_bucket
  CMP #PAL_BLUE
  BNE l238E

  ; Check bean
  LDA objs_rooms+obj_bean
  CMP #OFFMAP
  BNE l23C5

  LDX #&02
  JSR l39D4
  BCC l23C5

  JSR l29C1

  ; ?? put beanstalk in allotment ??
  LDA #ALLOTMENTROOM:STA &C721

  LDA #&13
  JSR l357D
  JMP l2355

.l238E
  LDX #&5D
  JSR l39D4
  BCC l23C5

  ; Set colour of bucket to blue
  LDA #PAL_BLUE:STA objs_attrs+obj_bucket
  LDA #&FF:STA &03D9

  LDA #&1C
  JSR l357D
  JMP l242D

.l23A7
  ; Is it < 12
  CMP #&0C
  BCC l23C8

  ; Is it >= 16
  CMP #&10
  BCS l23C8

  CLC
  ADC #&4C
  TAX
  JSR l39D4
  BCC l23C5

  LDA #PAL_WHITE:STA objs_attrs,X
  JSR l29C1
  LDA #&1B
  JSR l357D
.l23C5
  JMP l242D

.l23C8
  CMP #&09
  BNE l23E0

  LDX #&47
  JSR l39D4
  BCC l23C5

  LDA #&1E
  JSR l357D

  ; Flip golden egg
  LDA #ATTR_REVERSE+PAL_YELLOW:STA objs_attrs+obj_goldenegg
  JMP l242D

.l23E0
  CMP #&08
  BNE l23FB

  LDX #&49
  JSR l39D4
  BCC l23C5

  JSR l29C1

  LDA #OFFMAP:STA &C6E6

  LDA #&23
  JSR l357D
  JMP l242D

.l23FB
  CMP #&0B
  BNE l2417

  LDA #DAISYSPRISONROOM
  CMP roomno
  BNE l23C5

  STA &C708
  STA &C709

  JSR l29C1
  LDA #&25
  JSR l357D
  JMP l242D

.l2417
  CMP #&11
  BNE l242D

  LDA #WIDEEYEDDRAGONROOM
  CMP roomno
  BNE l242D

  JSR l29C1
  LDA #&18
  JSR l357D
  JMP l242D

.l242D
  LDX #&73:STX &03DB
.l2432
  JSR l39D4
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
  LDA #&28
  JSR l357D
  JMP l24A0

.l245B
  CPX #&FF
  BEQ l24A0

  LDA #&3F:STA &03DD
  LDA #&00:STA &03D5

  ; Wait until raster line >= 250
.l2469
  LDA GFX_RASTER_LINE
  ; Is it < 250
  CMP #&FA
  BCC l2469

  JSR l3329
  LDX &03D9
  LDA roomno:STA objs_rooms,X

  LDA dizzyx:CLC:ADC #&21:AND #&FE:STA objs_xlocs,X
  LDA dizzyy:CLC:ADC #&2D:STA objs_ylocs,X

  LDA #&3F:STA &03DD
  LDA #&FF:STA &03D5

  JSR l3329
  JSR l3090
.l24A0
  LDX #&00:STX &03B7
.l24A5
  LDA &18F8,X
  TAX
  JSR l39D4
  BCC l24B7

  LDX &03B7
  LDA &1903,X
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

  LDX #&56
  JSR l39D4
  BCC l24D4

  LDA #&31
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
  LDX #&72
  JSR l39D4
  BCC l24FF

  LDA #&2D
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

  LDA #&2E
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

  LDA #&2F
  JMP l2572

.l2560
  LDA &033F
  AND #&10
  BEQ l25C7

  LDA #&34
  LDY roomno
  CPY #ACTIVEVOLCANOROOM
  BEQ l2572

  LDA #&30
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
  LDA #&04:STA v0B00
  JSR l34E2
  LDA #&29
  JSR l357D
  LDA &03B7
  JSR l357D
  LDA #&07:STA &03B7
.l25A2
  LDA #&FA
  JSR l31D6
  DEC &03B7
  BNE l25A2

  LDA lives
  BNE l25B4

  JMP l1927 ; No lives left

.l25B4
  DEC lives ; lose a life

  JSR l2F22
  JSR l346B
  LDA v2B48
  BNE l25C7

  LDA #&02:STA v0B00
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
  CMP #&64
  BCS l2601

  ; See if rat's X position is less than the bread - i.e. it ate it
  LDA objs_xlocs+obj_bread
  CLC
  ADC #&04
  CMP objs_xlocs+obj_rat
  BCC l2601

  LDA #OFFMAP:STA objs_rooms+obj_bread ; Remove bread

  ; Flip rat to go back to it's nest
  LDA objs_attrs+obj_rat:ORA #ATTR_REVERSE:STA objs_attrs+obj_rat ; Set top bit

  LDA #&1D
  JSR l357D
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
  CMP #&60
  BCC l2650

  JSR l32EB

  ; Remove rat
  LDA #OFFMAP:STA objs_rooms+obj_rat
.l2629
  JMP l2650

.l262C
  ; Check rat X position < 79
  LDA objs_xlocs+obj_rat
  CMP #&4F
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
  CMP #&2F
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
  CMP #&61
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
  CMP #&88
  BCS l269E

  ; Move portcullis down
  CLC:ADC #&04:STA objs_ylocs+obj_portcullis
  JMP l26A6

.l26BE
  LDA roomno
  CMP #OUTTOSEAROOM
  BNE l26E8

  ; Check Dozy X position >= 70
  LDA objs_xlocs+obj_dozy
  CMP #&46
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
  ADC #&86
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
  CMP #&38
  BNE l279B

  ; Check hawk X position > 61
  LDA objs_xlocs+obj_hawk
  CMP #&3D
  BCS l279E

  ; Check hawk X position < 46
  CMP #&2E
  BCC l279E

  ; See if Dizzy is directly below hawk
  LDA dizzyx
  CLC
  ADC #&1C
  CMP objs_xlocs+obj_hawk
  BEQ l279B

  ; Update hawk X position
  CLC
  ADC #&01
  CMP objs_xlocs+obj_hawk
  BNE l279E

.l279B
  JMP l27DF

.l279E
  ; Check hawk X position < 35
  LDA objs_xlocs+obj_hawk
  CMP #&23
  BCC l27A9

  ; Check hawk X position < 80
  CMP #&50
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
  ADC #&08
  STA objs_ylocs+obj_hawk

  ; Keep hawk moving towards Dizzy
  LDA dizzyx
  CLC
  ADC #&1C
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
  CMP #&68
  BCS l283D

  LDA &C6F0
  CMP #OFFMAP
  BEQ l283D

  ; Check grunt (Armorog) X position >= 55
  LDA objs_xlocs+obj_grunt
  CMP #&37
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
  CMP #&37
  BCC l2883

  ; Check grunt X position < 78
  CMP #&4E
  BCC l28A8

.l2883
  ; Switch grunt direction
  LDA objs_attrs+obj_grunt:EOR #ATTR_REVERSE:STA objs_attrs+obj_grunt

  ; Check if grunt X position is 78
  LDA objs_xlocs+obj_grunt
  CMP #&4E
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
  LDA #&80:STA objs_ylocs+obj_sleepingpotion
  LDA #&52:STA objs_xlocs+obj_sleepingpotion

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
  LDA #&72:STA dizzyy

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
  LDX #&67
  JSR l39D4
  BCS l2A38

  JMP l20E5

.l2A38
  LDA roomno
  CMP #DAISYSPRISONROOM
  BNE l2A68

  LDA #&0B
  JSR l357D

  ; Put Daisy in her hut
  LDA #DAISYSHUTROOM:STA objs_rooms+obj_daisy
  LDA #&32:STA objs_xlocs+obj_daisy
  LDA #&4D:STA objs_ylocs+obj_daisy

  LDA #&00:STA SPR_ENABLE
  JSR heartdemo

  LDA #&0C
  JSR l357D

  LDA #&02:STA v0B00
  JMP l24A0

.l2A68
  LDA coins_tens
  CMP #&03
  BNE l2A77

  LDA #&0E
  JSR l357D
  JMP l1927

.l2A77
  LDA #&0D
  JSR l357D
  JMP l24A0

.l2A7F
{
  LDY roomno
  CPY #&19 ; No room #25 ???
  BCC l2A87

  RTS

.l2A87
  LDY #&00:STY &FC

  LDX #&06
.l2A8D
  CLC
  ROL A
  ROL &FC
  DEX
  BNE l2A8D

  STA &FB

  LDA &FC:CLC:ADC #&40:STA &FC

  LDY #&00
  LDX #&3E
.l2AA1
  LDA (&FB),Y
  STX &FF
  TAX
  LDA flip_lut,X
  LDX &FF
  STA &4A80,X
  DEX
  INY
  CPY #&3F
  BCC l2AA1

  LDA #&2A

  RTS
}

.l2AB7
{
  LDA v2B48
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

.v2AF2
  RTS
}

  ; No idea what this is, used by l2D95
.v2AF3
  EQUB &00, &00, &b8, &00, &00, &00, &81, &00, &80

.v2B13
.v2B14

.v2B1E

.v2B28

ORG &2B32

.l2B32
{
  SEI

  LDA #lo(isr_routine)
  STA &0314 ; ISR
  LDA #hi(isr_routine)
  STA &0315 ; ISR

  LDA #&00
  STA v2B48
  STA v0B00

  CLI

  RTS
}

.v2B47
  EQUB 142
.v2B48
  EQUB 0

.isr_routine
{
  INC v2B47

  LDA v2B47
  AND #&07
  CMP #&07
  BEQ done

  JSR l0B01

.done
  JMP &EA31 ; KERNAL ISR
}

; Draw frame/sprite
;
; frame = A reg
; frmx = &033A
; frmy = &033B
.frame
  STA &FB
  STA &0340
  STX &0345

  LDA &033A
  ; Is it < 93
  CMP #&5D
  BCC l2B6B

  RTS

.l2B6B
  JSR l3893
  BCC l2B71

  RTS

.l2B71
  STA &B5
  LDA &033B
  LSR A
  LSR A
  LSR A
  TAX

  ; Is it < 91
  LDA &0340
  CMP #&5B
  BCC l2BAB

  ; Is it >= 96
  CMP #&60
  BCS l2BAB

  LDA &03DA
  BEQ l2B8F

  CMP &033A
  BCC l2B95

.l2B8F
  LDA &033A:STA &03DA
.l2B95
  STX &03E0
  LDA &033F:ORA #&10:STA &033F
  LDA &033B:AND #&F8:STA &033B
  JMP l2BD5

.l2BAB
  CMP #&73
  BNE l2BD5

  LDY &03DC
  BEQ l2BD5

  ; Is it >= 10
  LDY &2B13
  CPY #&0A
  BCS l2BD5

  LDA &033A:STA &2B14,Y
  LDA &033B:STA &2B1E,Y
  LDA &033C:ORA #&10:STA &2B28,Y
  DEC &03BC
  INC &2B13
.l2BD5
  LDA screentable_lo,X:STA &FB
  LDA screentable_hi,X:STA &FC
  LDA &033B
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
  LDA &033A
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
  LDA &033B
  LSR A
  LSR A
  LSR A
  TAX
  LDA &1828,X:SEC:SBC &03DC:STA &FE
  LDA &180E,X
  SEC
  SBC #&0C
  BCS l2C23

  DEC &FE
.l2C23
  STA &FD
  LDA &033A
  LSR A
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
  CMP #&30
  BCC l2C6D

  ; Is it >= 91
  CMP #&5B
  BCS l2C6D

  LDA #&01:STA &033D
  LDA #&08:STA &033E
.l2C6D
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
  LDA &033A
  AND #&FE
  CMP #&22
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
  LDA &033B
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

  LDA &033C
  AND #&80
  BEQ l2CDE

  JSR l2E2E
.l2CDE
  LDA &033A
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
  INC &033B
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
  LDA &033B
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
  BEQ l2F39

  ; Position grunt
  LDA #&36:STA objs_xlocs+obj_grunt
  LDA #ATTR_GRID+PAL_RED:STA objs_attrs+obj_grunt
}

; Fall through

.l2F39
{
  LDA #&00
  STA &03BB
  STA SPR_ENABLE
  STA &03E0
  STA &03DA

  LDA &03C4:AND #&F8:STA &03C4

  LDA #&38:STA objs_ylocs+obj_hawk
  LDA #&0F:STA &03BC
  LDA #&00:STA &2B13

  LDX #&00
.l2F60
  STA &2B14,X
  STA &2B1E,X
  STA &2B28,X

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
  LDA orig_ylocs,X:STA objs_ylocs,X

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
  LDA #&60:STA objs_ylocs+obj_portcullis
.l2FF5
  LDX #obj_portcullis
  JSR l3306

  ; Check portcullis height > 136
  LDA objs_ylocs+obj_portcullis
  CMP #&88
  BCS l300A

  ; Move portcullis down
  CLC
  ADC #&04
  STA objs_ylocs+obj_portcullis

  JMP l2FF5

.l300A
  LDA #&FF:STA &03D5
  LDA #&86:STA &03DD

  JSR l3329
  JSR l30CD
  JSR l3090

  LDA #&FF:STA SPR_ENABLE

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
  CMP #&67
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

.l31D6
{
  STA &0340
  STX &0345
.l31DC
  LDX #&FF
.l31DE
  NOP
  NOP
  NOP
  NOP
  DEX
  BNE l31DE

  DEC &0340
  BNE l31DC

  LDX &0345

  RTS
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
  STX &0345
  INC &03C5
  LDX &03C5
  LDA &E290,X:STA &03C6
  LDX &0345

  RTS
}

.l326A
{
  STX &0346
  INC &03C5
  LDX &03C5
  LDA &EA60,X
  AND #&03
  CLC
  ADC #&01
  STA &03C6
  LDX &0346

  RTS
}

.l3282
{
  STX &0345
  STA &0340
  LDX &034E
  LDA &0340
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

; Draw objects ??
.l3329
{
  LDX &03DD
.l332C
  CPX #&00
  BNE l333B

  ; End of objects, reset
  LDA #&86:STA &03DD
  LDA #&FF:STA &03D5
  RTS

.l333B
  DEX
  LDA objs_rooms,X
  BEQ l332C

  CMP roomno
  BNE l332C

  LDA objs_xlocs,X:STA &033A ; X position
  LDA objs_ylocs,X:STA &033B ; Y position
  LDA objs_attrs,X:STA &033C ; attrib

  LDY #&00
  CPX #&3F
  BCS l3373

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

  JMP l332C
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

.l33AA
{
  LDA CIA1_PRA ; Read inputs
  EOR #&FF
  AND #&1F
  STA &03C0

  JSR l3541

  LDA &03D8
  AND #&10 ; Joystick button pressed ?
  AND &03C0
  BEQ l33CA

  LDA &03C0:AND #&0F:STA &03C0
  RTS

.l33CA
  LDA &03C0:STA &03D8

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
.l3445
  LDX #&02
.loop
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
  BCC loop

  LDA #&08
  JSR l31D6
  DEC &0346
  BNE l3445

  RTS
}

.l346B
{
  LDA &03D6:STA dizzyx
  LDA &03D7:STA dizzyy

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

  LDA &03D6:STA dizzyx
  LDA &03D7:STA dizzyy
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

  LDA #&04:STA v0B00
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

  LDA #&64
  JSR l31D6

  LDA &03B8:STA roomno

  RTS
}

.l3541
{
  ; check last pressed key
  LDY &C5
  LDX &028D
  LDA &03C0
  CPY #&0C ; matrix code for 'Z'
  BNE l3552

  ORA #&04 ; Set bit 2
  JMP l3558

.l3552
  CPY #&17 ; matrix code for 'X'
  BNE l3558

  ORA #&08 ; Set bit 3
.l3558
  CPX #&00
  BEQ l355E

  ORA #&01 ; Set bit 0
.l355E
  CPY #&01 ; matrix code for 'Return'
  BNE l3564

  ORA #&10 ; Set bit 4
.l3564
  STA &03C0

  RTS
}

; Get byte at (&05) and advance pointer
.l3568
{
  SEI
  LDA #&34:STA &01
  LDY #&00
  LDA (&05),Y
  INC &05
  BNE l3577

  INC &06
.l3577
  LDY #&36:STY &01
  CLI

  RTS
}

.l357D
{
  STA &03DB
  ASL A
  TAX

  ; Change memory configuration (with interrupts off)
  SEI
  LDA #&34:STA &01
  LDA &D148,X:STA &05
  LDA &D149,X:STA &06
  LDA #&36:STA &01
  CLI

.l3596
  JSR l3568
.l3599
  ; Is it < 251
  CMP #&FB
  BCC l359E

  RTS

.l359E
  CMP #&FA
  BNE l35A8

  JSR l361D
  JMP l3596

.l35A8
  CMP #&C8
  ; Is it < 200
  BCC l35B5

  SEC
  SBC #&C8
  STA &03BF

  JMP l3596

.l35B5
  CMP #&64
  ; Is it < 100
  BCC l35C8

  SEC
  SBC #&44
  STA &039B

  JSR l3568

  STA &039C

  JMP l3596

.l35C8
  CMP #&5F
  BNE l35ED

.l35CC
  JSR l33AA

  LDA &03C0
  AND #&10
  BNE l35CC

.l35D6
  JSR l33AA
  AND #&10
  BEQ l35D6

  JSR l3568

  CMP #&5F
  BNE l3599

  LDA &03DB
  BEQ l35EC

  JSR l2F39
.l35EC
  RTS

.l35ED
  ; Is it < 38
  CMP #&26
  BCC l35F5

  ; Is it < 91
  CMP #&5B
  BCC l35F7

.l35F5
  LDA #':' ; frame
.l35F7
  LDX &039B:STX &033A ; X position
  LDX &039C:STX &033B ; Y position
  LDX &03BF:STX &033C ; attrib

  LDX #&00
  STX &033F
  STX &03DC

  JSR frame

  INC &039B
  INC &039B

  JMP l3596
}

.l361D
{
  JSR l3568
  STA &0398

  JSR l3568
  STA &0399

  LDA #&00:STA SPR_ENABLE
  LDA &039B:CLC:ADC #&02:STA &039A

  LDA #&2C
  JSR l36E3

  LDA &0398
  ASL A
  CLC
  ADC &039A
  STA &039A

  LDA #&2C

  JSR l36E3
  JSR l3682

.l364F
  JSR l36B6
  DEC &0399
  BNE l364F

  JSR l3682

  LDA &039C:CLC:ADC #&08:STA &039C
  LDA &039B:CLC:ADC #&02:STA &039A

  LDA #&2D
  JSR l36E3

  LDA &0398:ASL A:CLC:ADC &039A:STA &039A

  LDA #&2D
  JSR l36E3

  RTS
}

.l3682
{
  LDA &039C:CLC:ADC #&08:STA &039C

  LDA &039B:STA &039A
  LDA #&2A
  JSR l36E3

  LDA #&2E
  JSR l36E3

  LDA &0398:STA &0344
.loop
  LDA #&28
  JSR l36E3

  DEC &0344
  BNE loop

  LDA #&2E
  JSR l36E3

  LDA #&2B
  JSR l36E3

  RTS
}

.l36B6
{
  LDA &039C:CLC:ADC #&08:STA &039C
  LDA &039B:CLC:ADC #&02:STA &039A

  LDA #SPR_FRAMEVERT
  JSR l36E3

  LDA &0398:STA &0344
.loop
  LDA #':'
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
  LDX &039C:STX &033B ; Y position
  LDX &03BF:STX &033C ; attrib

  LDX #&00
  STX &033F
  STX &03DC

  JSR frame

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
  LDA #&34:STA &01
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
  LDA #&36:STA &01
  CLI

  LDA &06
  BEQ done

.l373D
  JSR l3568

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

.l3776
{
  JSR l374F
  LDX #&37
  LDA &C69E
  CMP #&04
  BNE l3784

  LDX #&38
.l3784
  TXA
  JSR l357D

  LDY #&58
  LDA &C69E
  CMP #&04
  BNE l3793

  LDY #&50
.l3793
  STY &039C
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

  LDA &039C:CLC:ADC #&08:STA &039C
  JMP l37A0

.l37C5
  LDA &18D9
  BNE done

  LDA #&3B
  JSR l357D

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
  LDA #&34:STA &01
  LDA roomnames,X:STA &05
  LDA roomnames+1,X:STA &06
  LDA #&36:STA &01
  CLI

  ; Set starting X position
  LDX #&2C
.loop
  ; Get next character to print
  JSR l3568

  ; Make sure it's not a string terminator
  CMP #&5F
  BNE keepgoing

.done
  RTS

.keepgoing
  STX &033A ; X position

  LDY #&18
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

  LDX #&2E
.loop
  STX &033A ; X position

  LDA #&08
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
  LDA #&04:STA v0B00

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

  LDA #&05
  JSR l31D6

  INC &03DB
  BNE loop

  RTS
}

.l3893
{
  LDA #&A5:STA &FC
  LDA &FB
  CLC
  ADC &FB
  BCC l38A0

  INC &FC
.l38A0
  STA &FB

  LDY #&00
  LDA (&FB),Y:STA &B4
  INY
  LDA (&FB),Y:CLC:ADC #&A7:STA &B5

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
  LDA &2B14,X:STA &033A ; X position
  LDA &2B1E,X:STA &033B ; Y position

  LDA #&00
  STA &033C ; attrib
  STA &033F
  STA &03DC

  LDA #SPR_FLAME ; frame
  JSR frame

  INX
  CPX &03DB
  BCS l3962

  CPX &2B13
  BCC l393B

.l3962
  LDX &034E
.l3965
  LDA &2B28,X
  EOR #&80
  STA &2B28,X
  STA &033C ; attrib

  LDA &2B14,X:STA &033A ; X position
  LDA &2B1E,X:STA &033B ; Y position
  LDA #&20:STA &033F
  LDA #&00:STA &03DC
  LDA #SPR_FLAME ; frame
  JSR frame

  INX
  CPX &03DB
  BCS done

  CPX &2B13
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

  LDA #&03:STA v0B00
  JSR l3A30

  LDA #&36
  JSR l357D

  LDA v2B48
  BNE done

  LDA #&02:STA v0B00

.done
  RTS
}

.l39D4
{
  LDA objs_rooms,X
  CMP roomno
  BEQ l39DE

.l39DC
  CLC
  RTS

.l39DE
  LDA objs_frames,X:STA &FB
  JSR l3893

  LDA dizzyx:CLC:ADC #&21:STA &033A

  CLC:ADC #&04:STA &033C

  LDA dizzyy:CLC:ADC #&2A:STA &033B

  CLC:ADC #&15:STA &033D

  LDA objs_xlocs,X
  CMP &033C
  BCS l39DC

  LDY #&00
  LDA (&B4),Y
  CLC
  ADC objs_xlocs,X
  CMP &033A
  BCC l39DC

  BEQ l39DC
  LDA objs_ylocs,X
  CMP &033D
  BCS l39DC

  INY
  CLC
  ADC (&B4),Y
  CMP &033B
  BCC l39DC

  BEQ l39DC

  SEC

  RTS
}

; Print coins collected counter to screen
.l3A30
{
  LDA #&4E:STA &033A ; X position
  LDA #&00:STA &03DC

  LDA #&08
  STA &033B ; Y position
  STA &03E3

  LDA #&06:STA &033C ; attrib

  ; Convert tens to ASCII
  LDA coins_tens
  CLC:ADC #'0'

  JSR frame

  LDA #&50:STA &033A ; X position
  LDA #&00:STA &03DC

  LDA #&08
  STA &033B ; Y position
  STA &03E3

  LDA #&06:STA &033C ; attrib

  ; Convert units to ASCII
  LDA coins:CLC:ADC #'0' ; frame

  JSR frame

  RTS
}

.l3A71
{
  TAX
  LDA &1897,X:STA &033C

  LDA #&0B
  LDX &C69E
  CPX #&04
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
.l3A97
  STA (&FB),Y
  INY
  ; Is it < 31
  CPY #&1F
  BCC l3A97

  RTS
}

.l3A9F
{
  LDA &03BA:CLC:ADC #&08:STA &03DB

  LDX &03BA
.l3AAB
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
  BEQ l3AAB

  BCC l3AAB

  LDX #obj_dragonhead
  LDA #&00:STA &03DC
  JSR l3306

  RTS
}

.v3AE9
.v3AF0

ORG &3B00

.l3B00
{
  LDX #&00
.l3B02
  ; check last key pressed
  LDA &C5
  CMP &3AE9,X
  BEQ l3B0A

  RTS

.l3B0A
  ; check last key pressed
  LDA &C5
  CMP &3AE9,X
  BEQ l3B0A

  INX
  ; Is it < 7
  CPX #&07
  BCC l3B02

  LDA #&00:STA SPR_ENABLE
  LDA #&02:STA lives

  JSR l3814
.l3B23
  LDA #&32
  JSR l31D6
  JSR l33AA

  AND #&1F
  ; Is it >= 16
  CMP #&10
  BCS l3B53

  AND #&0F
  TAX
  LDA &3AF0,X
  BEQ l3B23

  CLC
  ADC roomno
  ; Is it < 21
  CMP #&15
  BCC l3B23

  ; Is it >= 168
  CMP #&A8
  BCS l3B23

  STA roomno

  JSR l2F22

  LDA #&00:STA SPR_ENABLE
  JMP l3B23

.l3B53
  LDA #&FF:STA SPR_ENABLE
  RTS

  ; $DD00 = %xxxxxx11 -> Bank0: $0000-$3FFF
  LDA #&C7:STA CIA2_PRA

  LDA #&1B:STA GFX_VICII_REG1 ; rst8|ecm|bmm|DEN|RSEL|YSCROLL - Bitmap
  LDA #&15:STA GFX_MEM_PTR
  LDA #&37:STA &01

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

.v5800
.v58C8
.v5900
.v5990
.s5A00 ; to ???? = solidity bitmap ????
.v5A58
.v5B20
.s5C00 ; to 5FE7 = 8x8 screen colour attribs
.v5FF8

; &6000..&7F3F = screen RAM (320x200 hires bitmap mode, $d011=$3b, $d016=8)

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
INCBIN "frametable.bin"
INCBIN "framedefs.bin"

ORG &C400

.movingdata

; static set of objects
.orig_rooms ; rooms
  EQUB &37, &65, &3a, &65, &53 ; 0
  EQUB &64, &3a, &4d, &57, &5d ; 5
  EQUB &48, &28, &55, &18, &3c ; 10
  EQUB &30, &65, &65, &04, &35 ; 15
  EQUB &24, &24, &59, &35, &23 ; 20
  EQUB &32, &16, &18, &1f, &28 ; 25
  EQUB &29, &2e, &31, &33, &39 ; 30
  EQUB &3f, &43, &44, &45, &4b ; 35
  EQUB &4c, &4d, &54, &56, &57 ; 40
  EQUB &59, &5c, &5e, &65, &65 ; 45
  EQUB &65, &65, &65, &65, &65 ; 50
  EQUB &65, &34, &37, &37, &38 ; 55
  EQUB &48, &49, &3b, &65, &65 ; 60
  EQUB &16, &24, &24, &24, &24 ; 65
  EQUB &28, &28, &29, &29, &2d ; 70
  EQUB &30, &30, &30, &30, &30 ; 75
  EQUB &31, &32, &32, &33, &33 ; 80
  EQUB &34, &35, &37, &38, &38 ; 85
  EQUB &38, &38, &3b, &3c, &44 ; 90
  EQUB &45, &47, &47, &54, &58 ; 95
  EQUB &5e, &5e, &5e, &5e, &5e ; 100
  EQUB &5e, &65, &65, &36, &36 ; 105
  EQUB &36, &36, &36, &36, &36 ; 110
  EQUB &47, &47, &28, &28, &58 ; 115
  EQUB &58, &38, &38, &43, &45 ; 120
  EQUB &48, &59, &3b, &2f, &57 ; 125
  EQUB &49, &65, &23, &58      ; 130
.orig_xlocs ; Xs
  EQUB &30, &40, &48, &36, &50 ; 0
  EQUB &34, &3c, &38, &54, &50 ; 5
  EQUB &3c, &34, &2a, &50, &3c ; 10
  EQUB &28, &46, &56, &00, &30 ; 15
  EQUB &44, &48, &32, &5a, &3a ; 20
  EQUB &56, &24, &2a, &26, &32 ; 25
  EQUB &2c, &56, &3c, &58, &48 ; 30
  EQUB &3c, &3e, &54, &28, &36 ; 35
  EQUB &46, &34, &3c, &52, &58 ; 40
  EQUB &2c, &40, &3c, &56, &3a ; 45
  EQUB &4c, &54, &4c, &38, &34 ; 50
  EQUB &52, &56, &3a, &4c, &54 ; 55
  EQUB &4c, &38, &34, &42, &46 ; 60
  EQUB &40, &4e, &50, &28, &50 ; 65
  EQUB &3c, &36, &24, &2a, &4a ; 70
  EQUB &34, &3c, &44, &3c, &4a ; 75
  EQUB &2c, &36, &52, &42, &4c ; 80
  EQUB &40, &46, &2e, &32, &48 ; 85
  EQUB &34, &46, &48, &2f, &50 ; 90
  EQUB &28, &34, &3c, &22, &2a ; 95
  EQUB &3e, &4a, &4a, &4a, &2a ; 100
  EQUB &32, &28, &2e, &4c, &4b ; 105
  EQUB &4a, &49, &48, &47, &44 ; 110
  EQUB &34, &34, &28, &28, &3a ; 115
  EQUB &3a, &3c, &3c, &54, &2e ; 120
  EQUB &22, &3e, &40, &44, &3c ; 125
  EQUB &3e, &43, &5a, &3a      ; 130
.orig_ylocs ; Ys
  EQUB &90, &90, &aa, &50, &90 ; 0
  EQUB &a0, &98, &70, &50, &98 ; 5
  EQUB &80, &70, &70, &88, &78 ; 10
  EQUB &60, &84, &68, &00, &88 ; 15
  EQUB &90, &90, &88, &90, &88 ; 20
  EQUB &a0, &68, &98, &78, &48 ; 25
  EQUB &40, &80, &a0, &98, &a0 ; 30
  EQUB &96, &70, &70, &a0, &50 ; 35
  EQUB &38, &70, &60, &96, &a0 ; 40
  EQUB &60, &50, &98, &58, &88 ; 45
  EQUB &80, &80, &50, &48, &68 ; 50
  EQUB &a0, &58, &88, &80, &80 ; 55
  EQUB &50, &48, &68, &88, &88 ; 60
  EQUB &98, &88, &a0, &a0, &49 ; 65
  EQUB &98, &a0, &65, &68, &74 ; 70
  EQUB &ac, &ac, &ac, &a3, &68 ; 75
  EQUB &38, &9c, &a0, &4e, &88 ; 80
  EQUB &68, &98, &a0, &74, &74 ; 85
  EQUB &9c, &9c, &93, &90, &9b ; 90
  EQUB &70, &30, &30, &90, &4c ; 95
  EQUB &46, &30, &54, &40, &98 ; 100
  EQUB &98, &98, &98, &98, &98 ; 105
  EQUB &98, &98, &98, &98, &96 ; 110
  EQUB &38, &60, &38, &58, &30 ; 115
  EQUB &60, &68, &88, &70, &b0 ; 120
  EQUB &60, &48, &80, &50, &40 ; 125
  EQUB &40, &72, &80, &b0      ; 130
.orig_attrs ; attribs
  EQUB PAL_RED,                 PAL_GREEN,               PAL_RED,                 PAL_CYAN,                PAL_CYAN                ; 0
  EQUB PAL_WHITE,               PAL_WHITE,               PAL_MAGENTA,             PAL_RED,                 PAL_YELLOW              ; 5
  EQUB PAL_WHITE,               PAL_RED,                 PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 10
  EQUB PAL_YELLOW,              PAL_WHITE,               PAL_GREEN,               PAL_GREEN,               PAL_YELLOW              ; 15
  EQUB PAL_CYAN,                PAL_YELLOW,              PAL_YELLOW,              PAL_RED,                 PAL_RED                 ; 20
  EQUB PAL_RED,                 PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 25
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 30
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 35
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 40
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 45
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 50
  EQUB PAL_YELLOW,              PAL_WHITE,               PAL_GREEN,               PAL_RED,                 PAL_RED                 ; 55
  EQUB PAL_RED,                 PAL_GREEN,               PAL_GREEN,               PAL_WHITE,               ATTR_REVERSE+PAL_WHITE  ; 60
  EQUB &20,                     PAL_GREEN,               &20,                     PAL_BLACK,               PAL_WHITE               ; 65
  EQUB PAL_YELLOW,              PAL_BLACK,               PLOT_XOR+ATTR_NOTSOLID+PAL_RED, &10,              PAL_WHITE               ; 70
  EQUB PAL_WHITE,               PAL_WHITE,               PAL_WHITE,               ATTR_NOTSOLID+PAL_RED,   PAL_BLACK               ; 75
  EQUB PAL_WHITE,               PAL_RED,                 PAL_BLACK,               PAL_CYAN,                ATTR_NOTSOLID+PAL_WHITE ; 80
  EQUB PAL_BLACK,               ATTR_NOTSOLID+PAL_GREEN, ATTR_NOTSOLID+PAL_RED,   PAL_CYAN,                PAL_CYAN                ; 85
  EQUB PAL_CYAN,                PAL_CYAN,                PAL_WHITE,               PAL_BLACK,               PAL_WHITE               ; 90
  EQUB PAL_WHITE,               PAL_RED,                 PAL_RED,                 ATTR_NOTSOLID+PAL_RED,   PAL_WHITE               ; 95
  EQUB PAL_CYAN,                PAL_WHITE,               ATTR_NOTSOLID+PAL_WHITE, PAL_WHITE,               PLOT_XOR+PAL_WHITE      ; 100
  EQUB PLOT_XOR+PAL_WHITE,      ATTR_NOTSOLID+PAL_RED,   ATTR_NOTSOLID+PAL_RED,   ATTR_GRID+PAL_RED,       ATTR_GRID+PAL_RED       ; 105
  EQUB ATTR_GRID+PAL_RED,       ATTR_GRID+PAL_RED,       ATTR_GRID+PAL_RED,       ATTR_GRID+PAL_RED,       PAL_RED                 ; 110
  EQUB PAL_WHITE,               ATTR_NOTSOLID+PAL_WHITE, PAL_WHITE,               ATTR_NOTSOLID+PAL_WHITE, PAL_WHITE               ; 115
  EQUB ATTR_NOTSOLID+PAL_WHITE, PAL_WHITE,               ATTR_NOTSOLID+PAL_WHITE, PAL_BLACK,               ATTR_NOTSOLID+PAL_RED   ; 120
  EQUB ATTR_NOTSOLID+PAL_GREEN, ATTR_NOTSOLID+PLOT_XOR+PAL_GREEN, ATTR_NOTSOLID+PLOT_XOR+PAL_RED, ATTR_NOTSOLID+PLOT_XOR+PAL_RED, ATTR_NOTSOLID+PAL_GREEN ; 125
  EQUB ATTR_NOTSOLID+PLOT_XOR+PAL_GREEN, ATTR_REVERSE+ATTR_NOTSOLID+PAL_GREEN,         ATTR_NOTSOLID+PAL_RED,   ATTR_NOTSOLID+PAL_RED   ; 130
.orig_frames ; frames
  EQUB SPR_BAG,         SPR_BEAN,       SPR_MANURE,         SPR_CROWBAR,     SPR_BUCKET           ; 0
  EQUB SPR_BONE,        SPR_COW,        SPR_HAPPYDUST,      SPR_PICKAXE,     SPR_GOLDENEGG        ; 5
  EQUB SPR_BLACKHOLE,   SPR_THICKRUG,   SPR_KEY,            SPR_KEY,         SPR_KEY              ; 10
  EQUB SPR_KEY,         SPR_ROPE,       SPR_SLEEPINGPOTION, SPR_APPLE,       SPR_BRANDYBOTTLE     ; 15
  EQUB SPR_JUGOFWATER,  SPR_BREAD,      SPR_DOORKNOCKER,    SPR_SMALLSTONE5, SPR_SMALLSTONE3      ; 20
  EQUB SPR_SMALLSTONE2 ; 25
.coinstart
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN                              ; 26
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 30
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 35
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 40
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 45
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 50
  EQUB SPR_COIN                                                                                   ; 55
.coinend
  EQUB SPR_WOODENRAIL,  SPR_LEAFYBIT1,  SPR_WOODENRAIL,     SPR_WOODENRAIL                        ; 56
  EQUB SPR_WOODENRAIL,  SPR_WINDOW,     SPR_LEAFYBIT1,      SPR_SHOPKEEPER,  SPR_SHOPKEEPER       ; 60
  EQUB SPR_EGG,         SPR_TROLL,      SPR_EGG,            SPR_EGG,         SPR_RAT              ; 65
  EQUB SPR_GOLDENEGG,   SPR_EGG,        SPR_LARGESTONE2,    SPR_EGG,         SPR_DOZY             ; 70
  EQUB SPR_WATER,       SPR_WATER,      SPR_WATER,          SPR_WOOD0,       SPR_EGG              ; 75
  EQUB SPR_HAWK0,       SPR_GRUNT0,     SPR_EGG,            SPR_SWITCH,      SPR_PORTCULLIS       ; 80
  EQUB SPR_EGG,         SPR_CROCCLOSED, SPR_WOOD0,          SPR_MACHINE,     SPR_MACHINE          ; 85
  EQUB SPR_MACHINE,     SPR_MACHINE,    SPR_DYLAN,          SPR_EGG,         SPR_DENZIL           ; 90
  EQUB SPR_DAGGERBLADE, SPR_WOOD0,      SPR_WOOD0,          SPR_PLANKOFWOOD, SPR_GRANDDIZZY       ; 95
  EQUB SPR_SWITCH,      SPR_LIFTTOP,    SPR_LIFTBOTTOM,     SPR_DAISY,       SPR_DAGGERBLADE      ; 100
  EQUB SPR_DAGGERBLADE, SPR_GROUND,     SPR_GROUND,         SPR_DRAGONNECK,  SPR_DRAGONNECK       ; 105
  EQUB SPR_DRAGONNECK,  SPR_DRAGONNECK, SPR_DRAGONNECK,     SPR_DRAGONNECK,  SPR_DRAGONHEADCLOSED ; 110
  EQUB SPR_LIFTTOP,     SPR_LIFTBOTTOM, SPR_LIFTTOP,        SPR_LIFTBOTTOM,  SPR_LIFTTOP          ; 115
  EQUB SPR_LIFTBOTTOM,  SPR_LIFTTOP,    SPR_LIFTBOTTOM,     SPR_FRAMERIGHT,  SPR_STONEBLOCK4      ; 120
  EQUB SPR_LEAFYBIT1
.vC696
  EQUB                  SPR_LEAFYBIT,   SPR_BRANCH2,        SPR_HYPHEN,      SPR_LEAFYBIT1        ; 125
  EQUB SPR_LEAFYBIT1,   SPR_LEAF0,      SPR_STONEBLOCK3,    SPR_WOOD0                             ; 130

.endofmovingdata

movingsize = 5
noofmoving = (((endofmovingdata-movingdata)/movingsize) AND &FF)

IF (endofmovingdata-movingdata) <> (noofmoving*movingsize)
  ERROR "moving data typed in wrong"
ENDIF

firstcoin = coinstart-orig_frames
lastcoin = coinend-orig_frames-1

; object arrays
objs_rooms  = &C69E
objs_xlocs  = &C724
objs_ylocs  = &C7AA
objs_attrs  = &C830
objs_frames = &C8B6

; object offsets
obj_bag            = 0
obj_bean           = 1
obj_manure         = 2
obj_crowbar        = 3
obj_bucket         = 4
obj_bone           = 5
obj_goldenegg      = 9
obj_blackhole      = 10
obj_rug            = 11
obj_rope           = 16
obj_sleepingpotion = 17
obj_brandy         = 19
obj_jugofwater     = 20
obj_bread          = 21
obj_doorknocker    = 22
obj_troll          = 66
obj_rat            = 69
obj_goldenegg2     = 70
obj_dozy           = 74
obj_hawk           = 80
obj_grunt          = 81
obj_switch         = 83
obj_portcullis     = 84
obj_croc           = 86
obj_wood           = 87
obj_machines       = 88
obj_dylan          = 92
obj_plank          = 98
obj_switch2        = 100
obj_lifttop        = 101
obj_liftbottom     = 102
obj_daisy          = 103
obj_dragonhead     = 114

; Live set of objects (copied from C400)
; room[] array
;.vC69E ; bag
;.vC69F ; bean
;.vC6A1 ; crowbar
;.vC6A2 ; bucket
;.vC6A3 ; bone
.vC6A5 ; happydust
;.vC6A8 ; blackhole
;.vC6A9 ; rug
;.vC6AE ; rope
;.vC6AF ; sleepingpotion
;.vC6B1 ; brandy
;.vC6B2 ; jugofwater
;.vC6B3 ; bread
;.vC6B4 ; doorknocker
.vC6D5 ; (last coin)
.vC6DD ; shopkeeper
.vC6DE ; shopkeeper
.vC6DF ; egg
;.vC6E0 ; troll
.vC6E1 ; egg
.vC6E2 ; egg
;.vC6E3 ; rat
;.vC6E4 ; goldenegg2
.vC6E6 ; largestone
.vC6F0 ; egg
;.vC6F5 ; wood
;.vC700 ; plank
;.vC705 ; daisy
.vC708 ; ground
.vC709 ; ground
.vC721 ; leaf

; X[] array
;.vC724 ; bag
;.vC735 ; sleepingpotion
;.vC739 ; bread
;.vC766 ; troll
.vC768 ; 68 ? egg
;.vC769 ; rat
;.vC76E ; dozy
;.vC774 ; hawk
;.vC775 ; grunt
;.vC78B ; daisy

; Y[] array
;.vC7AA ; bag
;.vC7BB ; sleepingpotion
;.vC7BF ; bread
;.vC7EC ; troll
;.vC7F4 ; dozy
.vC7F5 ; 75 these 3 are "water" ?
.vC7F6 ; 76
.vC7F7 ; 77
.vC7F8 ; wood2
;.vC7FA ; hawk
;.vC7FE ; portcullis
;.vC80F ; lifttop
;.vC810 ; liftbottom
;.vC811 ; daisy
.vC81B ; 113 ? dragonneck

; attrib[] array
;.vC830 ; bag
;.vC831 ; bean
;.vC832 ; manure
;.vC834 ; bucket
;.vC835 ; bone
;.vC839 ; goldenegg
;.vC872 ; troll
;.vC875 ; rat
;.vC880 ; hawk
;.vC881 ; grunt
;.vC883 ; switch
;.vC884 ; portcullis
;.vC888 ; machines
;.vC88C ; dylan
;.vC894 ; switch2
;.vC897 ; daisy
.vC89C ; 108 ? dragonneck
;.vC8A2 ; dragonhead

; frame[] array
;.vC8B6 ; bag
;.vC906 ; hawk
;.vC907 ; grunt
;.vC90C ; croc
;.vC928 ; dragonhead

.vCFF8


ORG &D000
; String table pointers
.roomnames
  EQUW room0 ,room1 ,room2 ,room3 ,room4 ,room5 ,room6 ,room7
  EQUW room8 ,room9 ,room10,room11,room12,room13,room14,room15
  EQUW room16,room17,room18,room19,room20,room21,room22,room23
  EQUW room24,room25,room26,room27,room28,room29,room30,room31
  EQUW room32,room33,room34,room35,room36,room37,room38,room39
  EQUW room40,room41,room42,room43,room44,room45,room46,room47
  EQUW room48,room49,room50,room51,room52,room53,room54,room55
  EQUW room56,room57,room58,room59,room60,room61,room62,room63
  EQUW room64,room65,room66,room67,room68,room69,room70,room71
  EQUW room72,room73,room74,room75,room76,room77,room78,room79
  EQUW room80,room81,room82,room83,room84,room85,room86,room87
  EQUW room88,room89,room90,room91,room92,room93,room94,room95
  EQUW room96,room97,room98,room99,room100

  EQUW bagmess
  EQUW greenbeanmess

  EQUW &0000

  EQUW crowbarmess
  EQUW mtbucketmess
  EQUW bonemess
  EQUW pigmycowmess

  EQUW &0000

  EQUW pickaxemess
  EQUW goldeneggmess
  EQUW blackholemess
  EQUW rugmess
  EQUW keymess, keymess, keymess, keymess
  EQUW ropemess
  EQUW sleeppotionmess
  EQUW applemess
  EQUW fullwhiskeymess
  EQUW jugmess
  EQUW loafmess
  EQUW doorknockermess
  EQUW rockmess, rockmess, rockmess

  EQUW &0000, &0000, &0000, &0000, &0000, &0000, &0000, &0000
  EQUW &0000, &0000, &0000, &0000, &0000, &0000, &0000, &0000
  EQUW &0000, &0000, &0000, &0000, &0000, &0000, &0000, &0000
  EQUW &0000, &0000, &0000, &0000, &0000, &0000

  EQUW railingmess
  EQUW leavesmess
  EQUW railingmess, railingmess, railingmess
  EQUW windowmess
  EQUW leavesmess

  EQUW startmess
  EQUW trollgotapplemess
  EQUW shopkeeperappearsmess
  EQUW givingjunkmess

  EQUW thanksforthecowmess
  EQUW dozytalking
  EQUW kickdozyagainmess
  EQUW dylantalking
  EQUW trancemess
  EQUW denziltalking
  EQUW stereoess
  EQUW gottodaisymess
  EQUW daisyrunsmess

  EQUW notgotallcoins
  EQUW gotallcoins

  EQUW dougtalking
  EQUW goonmysonmess

  EQUW throwwateronfiremess
  EQUW lookatpicturemess
  EQUW throwwateronbeanmess
  EQUW plantbeanmess
  EQUW pickupmanuremess
  EQUW throwswitchmess
  EQUW fedarmorog
  EQUW dragonasleepmess
  EQUW croctiedmess
  EQUW rockinwatermess
  EQUW keyinmachine
  EQUW fillbucketmess
  EQUW thanksforloafmess
  EQUW puteggbackmess
  EQUW goawaymess
  EQUW knockandentermess
  EQUW usedoorknockermess
  EQUW usecrowbarmess
  EQUW usepickaxemess
  EQUW obstructingliftmess
  EQUW userugmess
  EQUW getbackintheremess
  EQUW holdingholemess
  EQUW dropwhiskeymess

  EQUW deadwindow
  EQUW armorogkilledmess
  EQUW killedbyportcullis
  EQUW killedbyliftmess
  EQUW dragonkilledmess
  EQUW dragonflameskilledmess
  EQUW killedbyflame
  EQUW killedbywater
  EQUW croceatenmess
  EQUW killedbyhawk
  EQUW ratgotyoumess
  EQUW killedbyvolcano
  EQUW killedbydaggersmess

  EQUW youfoundcoinmess
  EQUW inventory
  EQUW inventorywithbag
  EQUW selectitemmess
  EQUW carryingtoomuchmess
  EQUW nothingatallmess
  EQUW fullbucketmess

mplot   = 3
mgosub  = 4
mrep    = 5
mendrep = 6
nr      = 10

mend    = 95  ; YES
mxy     = 100 ; YES
mend2   = 160
mpen    = 200 ; YES
drawbox = 250 ; YES

.room0 EQUS "I>GRAY==OLIVER:TWINS",mend
.room1 EQUS mend
.room2 EQUS mend
.room3 EQUS mend
.room4 EQUS mend
.room5 EQUS mend
.room6 EQUS mend
.room7 EQUS mend
.room8 EQUS mend
.room9 EQUS mend
.room10 EQUS mend
.room11 EQUS mend
.room12 EQUS mend
.room13 EQUS mend
.room14 EQUS mend
.room15 EQUS mend
.room16 EQUS mend
.room17 EQUS mend
.room18 EQUS mend
.room19 EQUS mend
.room20 EQUS mend
.room21 EQUS mend
.room22 EQUS ":THE:MARKET:SQUARE::",mend
.room23 EQUS "A:STRANGE:NEW:WORLD@",mend
.room24 EQUS ":INSIDE:THE:CHURCH::",mend
.room25 EQUS mend
.room26 EQUS mend
.room27 EQUS mend
.room28 EQUS mend
.room29 EQUS mend
.room30 EQUS mend
.room31 EQUS "THE:AMAZING:ILLUSION",mend
.room32 EQUS mend
.room33 EQUS mend
.room34 EQUS mend
.room35 EQUS ":SMUGGLER;S:HIDEOUT:",mend
.room36 EQUS "THE:CASTLE;S:DUNGEON",mend
.room37 EQUS mend
.room38 EQUS mend
.room39 EQUS "GOING:DOWN:THE:WELL@",mend
.room40 EQUS ":THE:DRAGON;S:LAIR::",mend
.room41 EQUS ":THE:DESERTED:MINES:",mend
.room42 EQUS mend
.room43 EQUS mend
.room44 EQUS mend
.room45 EQUS ":LOOKING:OUT:TO:SEA:",mend
.room46 EQUS ":THE:DOCKS:AND:PIER:",mend
.room47 EQUS ":FOURWAY:WAREHOUSE::",mend
.room48 EQUS ":THE:BROKEN:BRIDGE::",mend
.room49 EQUS "::THE:GUARD:HOUSE:::",mend
.room50 EQUS ":::ARMOROG;S:DEN::::",mend
.room51 EQUS "MOAT:AND:PORTCULLIS:",mend
.room52 EQUS ":THE:ENTRANCE:HALL::",mend
.room53 EQUS "THE:SNAP=HAPPY:GATOR",mend
.room54 EQUS "THE:WIDE=EYED:DRAGON",mend
.room55 EQUS "THE:BOTTOMLESS:WELL:",mend
.room56 EQUS "THE:LIFT:CONTROL:HUT",mend
.room57 EQUS ":BASE:OF:TREE:HOUSE:",mend
.room58 EQUS "THE:SMELLY:ALLOTMENT",mend
.room59 EQUS ":THE:LARGE:OAK:TREE:",mend
.room60 EQUS "BASE:OF:THE:VOLCANO:",mend
.room61 EQUS mend
.room62 EQUS mend
.room63 EQUS "::THE:CRAFTY:CLOUD::",mend
.room64 EQUS mend
.room65 EQUS mend
.room66 EQUS mend
.room67 EQUS ":::THE:WEST:WING::::",mend
.room68 EQUS "THE:BANQUETING:HALL:",mend
.room69 EQUS ":::THE:EAST:WING::::",mend
.room70 EQUS "::::::::SKY:::::::::",mend
.room71 EQUS "KEEP:OUT@:DOZY;S:HUT",mend
.room72 EQUS "::::DENZIL;S:PAD::::",mend
.room73 EQUS ":DAISY;S:EMPTY:HUT::",mend
.room74 EQUS "THE:GIANT:BEANSTALK:",mend
.room75 EQUS "COMPLEX:CLOUD:ROUTE:",mend
.room76 EQUS "NEAR:THE:VOLCANO:TOP",mend
.room77 EQUS ":THE:ACTIVE:VOLCANO:",mend
.room78 EQUS mend
.room79 EQUS mend
.room80 EQUS mend
.room81 EQUS mend
.room82 EQUS mend
.room83 EQUS ":::THE:WEST:TOWER:::",mend
.room84 EQUS "THE:CASTLE:STAIRCASE",mend
.room85 EQUS ":::THE:EAST:TOWER:::",mend
.room86 EQUS ":THE:LONGJUMP:CLOUD:",mend
.room87 EQUS "::THE:MEETING:HALL::",mend
.room88 EQUS ":LIFT:TO:THE:ELDERS:",mend
.room89 EQUS "DIZZY;S:PARENTS;:HUT",mend
.room90 EQUS mend
.room91 EQUS "::YET:MORE:CLOUDS:::",mend
.room92 EQUS "MORE:;ORRIBLE:CLOUDS",mend
.room93 EQUS ":THE:CLOUD:CASTLE:::",mend
.room94 EQUS ":::DAISY;S:PRISON:::",mend
.room95 EQUS mend
.room96 EQUS mend
.room97 EQUS mend
.room98 EQUS mend
.room99 EQUS mend
.room100 EQUS ":::::THE:ATTIC::::::",mend

.greenbeanmess   EQUS "A:SINGLE:GREEN:BEAN",mend
.bonemess        EQUS "A:FRESH:MEATY:BONE",mend
.goldeneggmess   EQUS "A:HEAVY:DRAGON:EGG",mend
.blackholemess   EQUS "A:LARGE:ROUND:HOLE",mend
.sleeppotionmess EQUS "SOME:SLEEPING:POTION",mend
.applemess       EQUS "A:FRESH<:GREEN:APPLE",mend
.jugmess         EQUS "A:JUG:OF:WATER",mend
.loafmess        EQUS "STALE:LOAF:OF:BREAD",mend
.fullwhiskeymess EQUS "A:BOTTLE:OF:WHISKY:",mend
.ropemess        EQUS "A:PIECE:OF:ROPE",mend
.rockmess        EQUS "A:HEAVY:BOULDER",mend
;.fullwinemess    EQUS "A:BOTTLE:OF:WINE",mend
;.emptybottlemess EQUS "AN:EMPTY:BOTTLE",mend
.keymess         EQUS "A:SHINY:GOLD:KEY",mend
.mtbucketmess    EQUS "AN:EMPTY:BUCKET",mend
.fullbucketmess  EQUS "A:BUCKET:OF:WATER",mend
.leavesmess      EQUS "A:CLUMP:OF:LEAVES",mend
.pigmycowmess    EQUS "A:CUTE:PIGMY:COW",mend
.railingmess     EQUS "A:PIECE:OF:RAILING",mend
.doorknockermess EQUS "BRASS:DOOR:KNOCKER",mend
.crowbarmess     EQUS "A:STRONG:CROWBAR",mend
.pickaxemess     EQUS "A:RUSTY:PICKAXE",mend
.rugmess         EQUS "AN:OLD<:THICK:RUG",mend
.windowmess      EQUS "A:WINDOW:FRAME",mend
.bagmess         EQUS "EXIT:AND:DON;T:DROP",mend

.startmess
  EQUS mxy+19,48,mpen+3,  "FANTASY:WORLD"
  EQUS mxy+24,80,mpen+2,  "STARRING"
  EQUS mxy+20,89,         "THE:YOLKFOLK"
  EQUS mxy+20,108,mpen+5,"D",mxy+22,106,"I",mxy+24,104,"Z"
  EQUS mxy+26,102,"Z",mxy+28,100,"Y"

  EQUS mxy+35,100,"D",mxy+37,102,"A",mxy+39,104,"I"
  EQUS mxy+41,106,"S",mxy+43,108,"Y"

  EQUS mxy+9,142, "DENZIL:DYLAN"
  EQUS mxy+35,136,"DOZY"
  EQUS mxy+46,136,"GRAND"
  EQUS mxy+46,144, "DIZZY"
  EQUS mpen+6,":"
  EQUS mend,mend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PEOPLE TALKING MESSAGES

.trollgotapplemess
  EQUS mpen+7,mxy+2,48,drawbox,13,5,mpen+3
  EQUS mxy+11,72,"YOU:GIVE"
  EQUS mxy+10,80,"THE:APPLE"
  EQUS mxy+7,88,"T0:THE:TROLL",mend
  EQUS mpen+5,mxy+16,80,drawbox,11,5,mpen+6
  EQUS mxy+23,104,"&FOR:ME?"
  EQUS mxy+22,112,"YOU;RE:SO"
  EQUS mxy+22,120,"GENEROUS'",mend
  EQUS mpen+5,mxy+8,48,drawbox,20,6,mpen+6
  EQUS mxy+16,72,"&I;D:LIKE:TO:LET"
  EQUS mxy+16,80,"YOU:PASS<:BUT:IF"
  EQUS mxy+14,88,"THE:KING:FOUND:OUT"
  EQUS mxy+15,96,"HE;D:TORTURE:ME@'",mend
  EQUS mpen+5,mxy+6,112,drawbox,22,5,mpen+6
  EQUS mxy+16,136,"&BUT:YOU:COULD"
  EQUS mxy+14,144,"ESCAPE:THROUGH:THE"
  EQUS mxy+11,152,"FIRE:USING:THE:WATER'",mend,mend

.shopkeeperappearsmess
  EQUS mpen+7,mxy+2,96,drawbox,20,5,mpen+3
  EQUS mxy+10,120,"PING@:>>>:AND:AS"
  EQUS mxy+10,128,"IF:BY:MAGIC<:THE"
  EQUS mxy+8,136,"SHOPKEEPER:APPEARS",mend,mend

.givingjunkmess
  EQUS mpen+5,mxy+2,96,drawbox,25,4,mpen+6
  EQUS mxy+10,120,"&THAT;S:NO:GOOD:TO:ME"
  EQUS mxy+8,128,"GIVE:US:SOMETHIN;:ELSE'",mend,mend

;.stopgivingjunkmess
;  EQUS mpen+5,mxy+2,96,drawbox,19,4,mpen+6
;  EQUS mxy+10,120,"&STOP:GIVIN;:US"
;  EQUS mxy+11,128,"ALL:THAT:TRASH'",mend

;shoptalk        defw beanhere+room

.thanksforthecowmess
  EQUS mpen+5,mxy+2,80,drawbox,26,4,mpen+6
  EQUS mxy+8,104,"&G;DAY:DIZ<:AHH@:A:PIGMY"
  EQUS mxy+9,112, "COW:THAT;S:INTERESTIN;'",mend
.tencoinsmess
  EQUS mpen+4,mxy+10,120,drawbox,22,4,mpen+3
  EQUS mxy+20,144,"&WELL<:HOW:ABOUT"
  EQUS mxy+15,152,"10:GOLD:COINS:FOR:IT?",mend
.nottengoldcoins
  EQUS mpen+5,mxy+18,48,drawbox,18,5,mpen+6
  EQUS mxy+24,72,"&STREWTH MATE<:I"
  EQUS mxy+24,80,"SAID:INTERESTIN;"
  EQUS mxy+27,88,"NOT:VALUABLE'",mend
.fivecoinsmess
  EQUS mpen+4,mxy+2,104,drawbox,15,4,mpen+3
  EQUS mxy+11,128,"&WELL<:OK<"
  EQUS mxy+8,136,"5:GOLD:COINS'",mend
.notfivegoldcoins
  EQUS mpen+5,mxy+6,72,drawbox,24,5,mpen+6
  EQUS mxy+13,96, "&BE:SERIOUS<:IT:AIN;T"
  EQUS mxy+14,104,"WORTH:SPIT<:HERE;S:A"
  EQUS mxy+12,112,"BEAN<:THAT;S:GENEROUS'",mend
.erumbut
  EQUS mpen+4,mxy+16,112,drawbox,10,4,mpen+3
  EQUB &CC, &10, &70, &FA, &0A, &04, &CB ; ???????
  EQUS mxy+22,136,"&ER<:UM<:"
  EQUS mxy+22,144,"BUT:>>>'",mend
.throwsbean
  EQUS mpen+5,mxy+2,48,drawbox,11,5,mpen+6
  EQUS mxy+8,72,"&NOW:STOP"
  EQUS mxy+8,80,":WASTIN;"
  EQUS mxy+7,88,"MY:TIME@'"
  EQUS mpen+7,mxy+12,112,drawbox,15,5,mpen+3
  EQUS mxy+18,136,"AND:HE:THROWS"
  EQUS mxy+21,144,":THE:BEAN"
  EQUS mxy+19,152,"ON:THE:CRATE",mend
.letsfaceitmess
  EQUS mpen+7,mxy+8,80,drawbox,20,5,mpen+3
  EQUS mxy+15,104,"YOU:LEAVE:=:LET;S"
  EQUS mxy+18,112,"FACE:IT:DIZZY<"
  EQUS mxy+15,120,"YOU:CAN;T:BARTER@",mend,mend

.dozytalking
; EQUW sleepingpotionhere+room
  EQUS mpen+4,mxy+30,48,drawbox,12,4,mpen+3
  EQUS mxy+36,72, "&HEY@:DOZY"
  EQUS mxy+38,80, "GET:UP@'",mend

  EQUS mpen+7,mxy+2,80,drawbox,16,5,mpen+3
  EQUS mxy+10,104,"YOU:KICK:THE"
  EQUS mxy+8,112, "DECK:CHAIR:AND"
  EQUS mxy+11,120,"HE:WAKES:UP",mend

  EQUS mpen+5,mxy+12,112,drawbox,17,4,mpen+6
  EQUS mxy+18,136,"&OH@:WHAT;S:THE"
  EQUS mxy+20,144,"PROBLEM:DIZZY?'",mend

  EQUS mpen+4,mxy+2,48,drawbox,26,7,mpen+3
  EQUS mxy+9,72,  "&DAISY;S:BEEN:EGGNAPPED"
  EQUS mxy+8,80,  "AND:IS:BEING:HELD:IN:THE"
  EQUS mxy+10,88, "WIZARD;S:CLOUD:CASTLE<"
  EQUS mxy+12,96, "AND:NOBODY:WILL:HELP"
  EQUS mxy+17,104,"ME:RESCUE:HER@'",mend

  EQUS mpen+5,mxy+2,88,drawbox,14,6,mpen+6
  EQUS mxy+8 ,112,"&AHH<:THAT;S"
  EQUS mxy+11,120,"BAD:LUCK>"
  EQUS mxy+11,128,"I;LL:HELP"
  EQUS mxy+9,136, "YOU<:DIZZY'",mend

  EQUS mpen+5,mxy+18,112,drawbox,18,5,mpen+6
  EQUS mxy+28,136,"&HERE;S:SOME"
  EQUS mxy+24,144,"SLEEPING:POTION<"
  EQUS mxy+23,152,"THAT:SHOULD:HELP'",mend

  EQUS mpen+4,mxy+2,120,drawbox,17,4,mpen+3
  EQUS mxy+10,144,"&BUT:I;D:LIKE"
  EQUS mxy+8,152,"YOU:TO:HELP:ME'",mend

  EQUS mpen+5,mxy+2,48,drawbox,16,7,mpen+6
  EQUS mxy+9,72,"&SORRY:DIZZY<"
  EQUS mxy+10,80,"LOVE:TO:BUT"
  EQUS mxy+10,88,"IT;S:FAR:TOO"
  EQUS mxy+9,96, "NICE:A:DAY:TO"
  EQUS mxy+7,104,"RESCUE:MAIDENS'",mend

  EQUS mpen+7,mxy+8,80,drawbox,20,5,mpen+3
  EQUS mxy+14,104,"I:DON;T:THINK:HE;S"
  EQUS mxy+14,112,"GOING:TO:HELP<:AND"
  EQUS mxy+14,120,"HE;S:FALLEN:ASLEEP",mend,mend

.kickdozyagainmess
  EQUS mpen+7,mxy+10,80,drawbox,17,4,mpen+3
  EQUS mxy+18,104,"YOU:KICK:DOZY"
  EQUS mxy+16,112,"BUT:HE;S:ASLEEP",mend

.pushdozymess
  EQUS mpen+7,mxy+6,72,drawbox,22,6,mpen+3
  EQUS mxy+14,96,"WHOOPS@:YOU:KICKED"
  EQUS mxy+13,104,"TOO:HARD:AND:DOZY;S"
  EQUS mxy+11,112,"FALLEN:IN:THE:WATER"
  EQUS mxy+11,120,"AND:HE;S:STILL:ASLEEP",mend,mend

;duffmem EQUW 0

.dylantalking
; EQUW duffmem ;;poked value,so must point somewhere
  EQUS mpen+5,mxy+2,48,drawbox,18,4,mpen+6
  EQUS mxy+10,72, "&HEY:MAN<:LIKE"
  EQUS mxy+6,80, "WHAT;S:HAPPENIN:?'",mend

  EQUS mpen+4,mxy+4,96,drawbox,24,6,mpen+3
  EQUS mxy+10,120,"&PLEASE:HELP:ME:DYLAN<"
  EQUS mxy+12,128,"I;M:TRYING:TO:RESCUE"
  EQUS mxy+10,136,"DAISY:BUT:I:CAN;T:FIND"
  EQUS mxy+14,144,"THE:CLOUD:CASTLE>'",mend

  EQUS mpen+5,mxy+12,72,drawbox,19,5,mpen+6
  EQUS mxy+18,96, "&IT;S:QUITE:EASY<"
  EQUS mxy+18,104,"REMEMBER:HOW:JACK"
  EQUS mxy+18,112,"FOUND:THE:CASTLE'"
  EQUS mend,mend

.trancemess
  EQUS mpen+7,mxy+4,80,drawbox,24,4,mpen+3
  EQUS mxy+18,104,"STRANGE<:DYLAN"
  EQUS mxy+9,112,"SEEMS:TO:BE:IN:A:TRANCE",mend,mend

.denziltalking
; EQUW ropehere+room
  EQUS mpen+4,mxy+2,96,drawbox,26,5,mpen+3
  EQUS mxy+8,120,"&WHAT:ARE:YOU:DOING:HERE"
  EQUS mxy+8,128, "DENZIL:=:DON;T:YOU:KNOW"
  EQUS mxy+12,136, "IT;S:DANGEROUS?'",mend

  EQUS mpen+5,mxy+2,48,drawbox,24,6,mpen+6
  EQUS mxy+9,72,  "&HEY<:STAY:COOL<:DIZ>"
  EQUS mxy+10,80, "I:SAW:THE:KING:LEAVE"
  EQUS mxy+9,88,  "AND:THOUGHT:I;D:CHECK"
  EQUS mxy+15,96,  "OUT:THE:CASTLE>'",mend

  EQUS mpen+4,mxy+4,96,drawbox,24,7,mpen+3
  EQUS mxy+10,120, "&BUT:DAISY:AND:I:WERE"
  EQUS mxy+12,128, "CAUGHT>:I:WAS:THROWN"
  EQUS mxy+13,136, "IN:THE:DUNGEONS:AND"
  EQUS mxy+11,144, "DAISY;S:BEEN:TAKEN:TO"
  EQUS mxy+12,152, "THE:WIZARD;S:CASTLE'",mend

  EQUS mpen+5,mxy+2,48,drawbox,26,7,mpen+6
  EQUS mxy+14,72,"&OH@:WE:WONDERED"
  EQUS mxy+13,80, "WHERE:YOU:HAD:GONE>"
  EQUS mxy+11,88,"I;M:TOO:BUSY:TO:HELP<"
  EQUS mxy+12,96,"BUT:HERE;S:THE:ROPE"
  EQUS mxy+9,104,"YOU:LENT:ME:LAST:WEEK>'"

  EQUS mend,mend

.stereoess
  EQUS mpen+7,mxy+8,80,drawbox,19,5,mpen+3
  EQUS mxy+13,104,"DENZIL;S:TURNED:UP"
  EQUS mxy+16,112,"HIS:STEREO:AND"
  EQUS mxy+16,120,"IS:IGNORING:YOU",mend,mend


;daisytalking    ;;;;;;;;;;;;;defw beanhere+room
;;;     EQUS mend,mend

.gottodaisymess
  EQUS mpen+5,mxy+2,48,drawbox,17,5,mpen+6
  EQUS mxy+8,72,"&OH@:MY:HERO@:I"
  EQUS mxy+8,80,"KNEW:YOU;D:COME"
  EQUS mxy+8,88,"TO:MY:RECSUE@'",mend,mend
.daisyrunsmess
  EQUS mpen+7,mxy+4,64,drawbox,24,9,mpen+3
  EQUS mxy+13,88, "WELL<:DAISY:DOESN;T"
  EQUS mxy+10,96, "HANG:AROUND<:SHE;S:RUN"
  EQUS mxy+11,104,"HOME:AND:WANTS:YOU:TO"
  EQUS mxy+9,112, "BRING:HER:30:GOLD:COINS"
  EQUS mxy+11,120,"SO:THAT:YOU:CAN:BUY:A"
  EQUS mxy+10,128,"HOME:TOGETHER:AND:LIVE"
  EQUS mxy+14,136,"HAPPILY:EVER:AFTER",mend,mend

.notgotallcoins
  EQUS mpen+5,mxy+2,48,drawbox,21,6,mpen+6
  EQUS mxy+10,72, "&OH:DIZZY@:YOU;RE"
  EQUS mxy+8,80,  "SO:BRAVE:AND:CLEVER"
  EQUS mxy+9,88,  "AND:NOW:WE:CAN:BUY"
  EQUS mxy+9,96,  "THAT:TREE:COTTAGE'",mend

  EQUS mpen+4,mxy+6,112,drawbox,24,5,mpen+3
  EQUS mxy+12,136, "&ER<:UM<:WELL:ACTUALLY"
  EQUS mxy+13,144, "I:WAS:WONDERING:IF:WE"
  EQUS mxy+12,152, "NEEDED:ALL:30:COINS?'",mend

  EQUS mpen+5,mxy+6,64,drawbox,21,4,mpen+6
  EQUS mxy+12,88,"&YOU:DISAPPOINT:ME<"
  EQUS mxy+14,96, "OF:COURSE:WE:DO@'",mend

  EQUS mpen+7,mxy+8,80,drawbox,21,5,mpen+3
  EQUS mxy+15,104,"BACK:YOU:GO:DIZZY>"
  EQUS mxy+15,112,"SHE;S:A:REAL:SLAVE"
  EQUS mxy+13,120,"DRIVER<:BUT:WORTH:IT"
  EQUS mend,mend

.gotallcoins
  EQUS mpen+5,mxy+2,48,drawbox,24,3,mpen+6
  EQUS mxy+8,72, "&WOW@:YOU;VE:GOT:THEM'",mend

  EQUS mpen+4,mxy+4,128,drawbox,24,3,mpen+3
  EQUS mxy+10,152, "&WELL<:IT:WAS:NOTHING'",mend

  EQUS mpen+7,mxy+20,88,drawbox,7,3,mpen+3,mpen+7
  EQUS mxy+26,112,"LIAR@",mend

  EQUS mpen+7,mxy+2,80,"H",drawbox,23,5,mpen+3
  EQUS mxy+10,104,"AND:SO:WE:SAY:GOODBYE"
  EQUS mxy+12,112,"TO:THE:HAPPY:COUPLE"
  EQUS mxy+16,120,"UNTIL:>>>>>",mend

  EQUS mpen+7,mxy+8,72,drawbox,20,10,mpen+3
  EQUS mxy+13,96,"WELL<WHO:KNOWS:WHAT"
  EQUS mxy+15,104,"MIGHT:HAPPEN:NEXT?",mpen+4
  EQUS mxy+16,120,"WE:HOPE:YOU:HAVE"
  EQUS mxy+15,128,"ENJOYED:THIS:GAME",mpen+2
  EQUS mxy+14,140,"THAT;S:ALL:FOLKS@",mpen+5
  EQUS mxy+16,152,"THE:OLIVER:TWINS", mpen+7
  EQUS mxy+20,160,"AND:IAN:GRAY"

  EQUS mend,mend

.dougtalking
;  EQUW crowbarhere+room
  EQUS mpen+5,mxy+2,48,drawbox,25,6,mpen+6
  EQUS mxy+9,7, "&AFTERNOON:YOUNG:DIZZY"
  EQUS mxy+14,80,"YOU:LOOK:FRANTIC<"
  EQUS mxy+8,88, "ANYTHING:YOUR:OLD:GRAND"
  EQUS mxy+9,96, "DIZZY:CAN:DO:TO:HELP?'",mend

  EQUS mpen+4,mxy+6,104,drawbox,24,6,mpen+3
  EQUS mxy+15,128,"&HAVEN;T:YOU:HEARD?"
  EQUS mxy+13,136,"DAISY;S:BEING:HELD:IN"
  EQUS mxy+14,144,"THE:CLOUD:CASTLE:AND"
  EQUS mxy+11,152,"I;M:TRYING:TO:SAVE:HER'",mend

  EQUS mpen+5,mxy+12,48,drawbox,21,4,mpen+6
  EQUS mxy+18,72,"&JUST:WAIT:HERE:AND"
  EQUS mxy+21,80,"I;LL:GET:MY:HAT'",mend

  EQUS mpen+4,mxy+2,96,drawbox,25,5,mpen+3
  EQUS mxy+9,120,"&WHAT@:WELL:THANKS:FOR"
  EQUS mxy+8,128,"OFFERING<:BUT:I:THINK"
  EQUS mxy+8,136,"YOU:SHOULD:STAY:HERE>'",mend

  EQUS mpen+5,mxy+4,64,drawbox,24,6,mpen+6
  EQUS mxy+13,88, "&WELL<:IF:YOU:THINK"
  EQUS mxy+10,96, "IT;S:BEST<:BUT:PLEASE"
  EQUS mxy+14,104,"TAKE:THIS:CROWBAR>"
  EQUS mxy+11,112,"I:REMEMBER:WHEN>>>>'",mend

  EQUS mpen+7,mxy+6,80,drawbox,22,5,mpen+3
  EQUS mxy+13,104,"YOU:DECIDE:TO:LEAVE"
  EQUS mxy+12,112,"AS:HE:STARTS:TO:TELL"
  EQUS mxy+12,120,"YOU:HIS:LIFE:STORY"

  EQUS mend,mend

.goonmysonmess
  EQUS mpen+5,mxy+2,48,drawbox,21,5,mpen+6
  EQUS mxy+10,72,"OH:NO@:HE;S:STILL"
  EQUS mxy+10,80,"WAFFLING:ON:ABOUT"
  EQUS mxy+8,88, "HIS:PAST:ADVENTURES",mend,mend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MESSAGES FOR DOING THINGS

.throwwateronfiremess
  EQUS mpen+7,mxy+2,48,drawbox,21,6,mpen+3
  EQUS mxy+10,72, "YOU:THROW:THE:JUG"
  EQUS mxy+10,80,"OF:WATER:ONTO:THE"
  EQUS mxy+8,88, "FIRE:AND:THE:FLAMES"
  EQUS mxy+7,96, "ARE:QUICKLY:QUENCHED",mend,mend

.lookatpicturemess
  EQUS mpen+7,mxy+2,96,drawbox,23,6,mpen+3
  EQUS mxy+11,120, "YOU:LOOK:UP:AT:THE"
  EQUS mxy+9,128,  "PICTURE=:IT;S:YOU:IN"
  EQUS mxy+10,136, "YOUR:LAST:ADVENTURE",mpen+5
  EQUS mxy+8,144,  "TREASURE:ISLAND:DIZZY",mend,mend

.throwwateronbeanmess
  EQUS mpen+7,mxy+2,48,drawbox,26,8,mpen+3
  EQUS mxy+8,72,  "YOU:THROW:YOUR:BUCKET:OF"
  EQUS mxy+13,80, "WATER:ONTO:THE:BEAN",mpen+5
  EQUS mxy+11,88, "YOU:JUMP:CLEAR:AS:THE"
  EQUS mxy+10,96, "GROUND:RUMBLES:AND:A"
  EQUS mxy+12,104,"BEANSTALK:SPIRALS:UP"
  EQUS mxy+14,112,"THROUGH:THE:CLOUDS",mend,mend

.plantbeanmess
  EQUS mpen+7,mxy+6,48,drawbox,22,5,mpen+3
  EQUS mxy+12,72,"THIS:TIME:YOU:DECIDE"
  EQUS mxy+15,80,"TO:PLANT:THE:BEAN"
  EQUS mxy+15,88,"IN:THE:DRY:MANURE"
  EQUS mpen+2,mxy+2,112,drawbox,16,4,mpen+6
  EQUS mxy+8,136,":>>>:BUT:IT:IS"
  EQUS mxy+8,144,"UNABLE:TO:GROW",mend,mend

.pickupmanuremess
  EQUS mpen+7,mxy+2,48,drawbox,26,5,mpen+3
  EQUS mxy+6,72,"OH@:HOW:DISGUSTING@YOU:TRY"
  EQUS mxy+7,80,"TO:PICK:UP:THE:MANURE:BUT"
  EQUS mxy+8,88,"IT:SLIPS:FROM:YOUR:HANDS",mend,mend


.throwswitchmess
  EQUS mpen+7,mxy+2,48,drawbox,15,5,mpen+3
  EQUS mxy+8,72,"YOU:THROW:THE"
  EQUS mxy+8,80,"LEVER:TO:;ON;"
  EQUS mxy+8,88,"BUT:IT:BREAKS",mend,mend

.fedarmorog
  EQUS mpen+7,mxy+2,48,drawbox,18,4,mpen+3
  EQUS mxy+8,72,"THAT:BONE:SHOULD"
  EQUS mxy+10,80,"KEEP:HIM:BUSY@",mend,mend

.dragonasleepmess
  EQUS mpen+7,mxy+2,48,drawbox,21,6,mpen+3
  EQUS mxy+8,72,"YOU:SMASH:THE:FLASK"
  EQUS mxy+10,80,"OF:POTION:AND:THE"
  EQUS mxy+9,88,"DRAGON:INHALES:THE"
  EQUS mxy+8,96,"INTOXICATING:VAPOUR",mend,mend


.croctiedmess
  EQUS mpen+7,mxy+2,48,drawbox,19,5,mpen+3
  EQUS mxy+11,72,"YOU:NIMBLY:TIE"
  EQUS mxy+10,80,"THE:ROPE:AROUND"
  EQUS mxy+8,88, "THE:;GATOR;S:JAWS",mend,mend

.rockinwatermess
  EQUS mpen+7,mxy+2,112,drawbox,26,5,mpen+3
  EQUS mxy+6,136,"YOU:PUSH:THE:ROCK:INTO:THE"
  EQUS mxy+6,144,"RIVER:AND:IT:DISPLACES:THE"
  EQUS mxy+8,152,"WATER<:RAISING:THE:LEVEL",mend,mend
.keyinmachine
  EQUS mpen+7,mxy+2,48,drawbox,24,5,mpen+3
  EQUS mxy+8,72,"YOU:TRY:THE:KEY:IN:THE"
  EQUS mxy+13,80,"LOCK:AND:IT:FITS@"
  EQUS mxy+8,88,"SO:YOU:TURN:IT:TO:;ON;",mend,mend

.fillbucketmess
  EQUS mpen+7,mxy+2,48,drawbox,21,4,mpen+3
  EQUS mxy+8,72,"YOU:FILL:YOUR:EMPTY"
  EQUS mxy+10,80,"BUCKET:WITH:WATER",mend,mend

.thanksforloafmess
  EQUS mpen+7,mxy+2,48,drawbox,18,5,mpen+3
  EQUS mxy+8,72, "THE:RAVENOUS:RAT"
  EQUS mxy+11,80,"EATS:THE:LOAF"
  EQUS mxy+11,88,"AND:RUNS:AWAY",mend,mend
.puteggbackmess
  EQUS mpen+7,mxy+2,48,drawbox,20,6,mpen+3
  EQUS mxy+11,72,"YOU:PUT:THE:EGG"
  EQUS mxy+8,80, "BACK:INTO:THE:NEST"
  EQUS mxy+12,88,"AND:THE:DRAGON"
  EQUS mxy+8,96, "ALLOWS:YOU:TO:PASS",mend,mend

.goawaymess
  EQUS mpen+5,mxy+2,48,drawbox,26,5,mpen+6
  EQUS mxy+10,72,"&OH:NO@:NOT:YOU:AGAIN@"
  EQUS mxy+12,80, "GO:AWAY@:I;M:HIDING<"
  EQUS mxy+8,88, "AND:IT;S:ALL:YOUR:FAULT'",mend,mend


.knockandentermess
  EQUS mpen+2,mxy+2,96,drawbox,17,3,mpen+6
  EQUS mxy+8,120, "KNOCK:AND:ENTER",mend,mend

  EQUS mpen+7,mxy+6,40,drawbox,22,5,mpen+3
  EQUS mxy+14,7, "THAT;S:EASIER:SAID"
  EQUS mxy+11,80, "THAN:DONE:WHEN:YOU;RE"
  EQUS mxy+11,88, "WEARING:BOXING:GLOVES",mend,mend

.usedoorknockermess
  EQUS mpen+7,mxy+2,48,drawbox,20,5,mpen+3
  EQUS mxy+12,72,"USING:THE:DOOR"
  EQUS mxy+8,80,"KNOCKER<:YOU:KNOCK"
  EQUS mxy+8,88,"AND:THE:DOOR:OPENS",mend,mend

.usecrowbarmess
  EQUS mpen+7,mxy+2,48,drawbox,19,5,mpen+3
  EQUS mxy+8,72,"USING:THE:CROWBAR"
  EQUS mxy+8,80,"YOU:FORCE:THE:LID"
  EQUS mxy+13,88,"OFF:THE:WELL",mend,mend
.usepickaxemess
  EQUS mpen+7,mxy+2,48,drawbox,22,4,mpen+3
  EQUS mxy+9,72,"YOU:USE:THE:PICKAXE"
  EQUS mxy+8,80,"TO:BREAK:UP:THE:ROCK",mend,mend

.obstructingliftmess
  EQUS mpen+2,mxy+14,80,drawbox,14,4,mpen+6
  EQUS mxy+21,104,"STAND:CLEAR"
  EQUS mxy+21,112,"OF:THE:LIFT",mend,mend

.userugmess
  EQUS mpen+7,mxy+10,80,drawbox,17,6,mpen+3
  EQUS mxy+18,104,"YOU:THROW:THE"
  EQUS mxy+17,112,"RUG:ACROSS:THE"
  EQUS mxy+16,120,"DAGGERS<:MAKING"
  EQUS mxy+22,128,"THEM:SAFE",mend,mend

.getbackintheremess
  EQUS mpen+5,mxy+2,48,drawbox,21,4,mpen+6
  EQUS mxy+10,72,  "&OY@:WHERE:DO:YOU"
  EQUS mxy+7,80,  "THINK:YOU;RE:GOING?'",mend,mend

.holdingholemess
  EQUS mpen+2,mxy+2,48,drawbox,16,7,mpen+6
  EQUS mxy+8,72,"WHOOPS@:",mpen+4,"YOU;VE"
  EQUS mxy+9,80,"GOT:A:HOLE:IN"
  EQUS mxy+10,88,"YOUR:BAG:AND"
  EQUS mxy+8,96,"EVERYTHING:HAS"
  EQUS mxy+10,104,"DROPPED:OUT@",mend,mend

.dropwhiskeymess
  EQUS mpen+2,mxy+2,48,drawbox,14,7,6
  EQUS mxy+8,72,  "YOU:FIND:THE"
  EQUS mxy+9,80,  "WHISKY:TOO"
  EQUS mxy+9,88,  "TEMPTING:TO"
  EQUS mxy+9,96,  "DROP:AND:SO"
  EQUS mxy+11,104,"DRINK:IT@",mend,mend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ALL DEAD MESSAGES

.deadwindow
  EQUS mpen+6,mxy+10,64,drawbox,18,6
  EQUS mxy+16,112,mpen+2,"YOU:LOSE:A:LIFE@",mpen+5,mend+mend2
.armorogkilledmess
  EQUS mxy+18,88,"ARMOROG:CAUGHT"
  EQUS mxy+17,100,"YOU:TRESPASSING"
  EQUS mend+mend2

.killedbyportcullis
  EQUS mxy+16,88,"YOU:WERE:STABBED"
  EQUS mxy+16,96,"BY:THE:SPIKES:OF"
  EQUS mxy+18,104,"THE:PORTCULLIS"
  EQUS mend+mend2

.killedbyliftmess
  EQUS mxy+17,88,"YOU:GOT:TRAPPED"
  EQUS mxy+18,96,"IN:THE:COGS:ON"
  EQUS mxy+17,104,"TOP:OF:THE:LIFT"
  EQUS mend+mend2-1

.dragonkilledmess
  EQUS mxy+16,88, "THE:DRAGON:BITES"
  EQUS mxy+16,96, "YOU:AND:YOU:KEEL"
  EQUS mxy+20,104,"OVER:AND:DIE"
  EQUS mend+mend2-1

.dragonflameskilledmess
  EQUS mxy+17,88, "YOU:ARE:ROASTED"
  EQUS mxy+17,96, "BY:THE:DRAGON;S"
  EQUS mxy+20,104,"FIREY:BREATH"
  EQUS mend+mend2-1

.killedbyflame
  EQUS mxy+18,88,"YOU:WERE:BURNT"
  EQUS mxy+19,100,"BY:THE:FLAMES"
  EQUS mend+mend2-1

.killedbywater
  EQUS mxy+17,88, "YOU:FELL:IN:THE"
  EQUS mxy+15,100,"WATER:AND:DROWNED"
  EQUS mend+mend2-1

.croceatenmess
  EQUS mxy+19,88,"THE:GATOR:HAS"
  EQUS mxy+19,96,"YOU:FOR:LUNCH"
  EQUS mend+mend2-1

.killedbyhawk
  EQUS mxy+18,88,"THE:DIZZY=HAWK"
  EQUS mxy+21,96,"SWOOPS:DOWN"
  EQUS mxy+19,104,"AND:KILLS:YOU"
  EQUS mend+mend2-1

.ratgotyoumess
  EQUS mxy+20,88,"THE:RAT:GOES"
  EQUS mxy+20,96,"STRAIGHT:FOR"
  EQUS mxy+23,104,"YOUR:NECK"
  EQUS mend+mend2-1

.killedbyvolcano
  EQUS mxy+18,88, "YOU:WERE:BURNT"
  EQUS mxy+17,96, "BY:THE:HOT:LAVA"
  EQUS mxy+18,104,"IN:THE:VOLCANO"
  EQUS mend+mend2-1

.killedbydaggersmess
  EQUS mxy+14,88, "YOU;RE:SKEWERED:BY"
  EQUS mxy+15,100,"THE:SHARP:DAGGERS"
  EQUS mend+mend2-1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ODD MESSAGES

.youfoundcoinmess
  EQUS mpen+5,mxy+16,64,drawbox,12,5,mpen+3
  EQUS mxy+22,88,"WELL:DONE@",mpen+6
  EQUS mxy+23,96,"YOU:FOUND"
  EQUS mxy+26,104,"A:COIN",mend,mend

.inventory
  EQUS mpen+4,mxy+6,56,drawbox,22,6,mxy+16,76
.carrymess
  EQUS mpen+5,"YOU:ARE:CARRYING",mpen+2,mend+mend2-1
.inventorywithbag
  EQUS mpen+4,mxy+6,48,drawbox,22,8,mxy+16,68
  EQUS mpen+5,"YOU:ARE:CARRYING",mpen+2,mend+mend2-1

.selectitemmess
  EQUS mpen+7,mxy+14,136,drawbox,14,2,mpen+5
  EQUS mxy+18,152,"CHOOSE:ITEM:TO"
  EQUS mxy+21,160,"USE:OR:DROP",mend+mend2-1

.carryingtoomuchmess
  EQUS mpen+7,mxy+12,136,drawbox,16,2,mpen+5
  EQUS mxy+16,152,"YOU:ARE:CARRYING"
  EQUS mxy+16,160,"TOO:MUCH:TO:HOLD",mend+mend2

.nothingatallmess
  EQUS mxy+26,96,mpen+7
  EQUS "NOTHING", mend+mend2

ORG &FFFF
.c64end

SAVE "c64_built", c64start, c64end
