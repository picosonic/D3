ORG &033A

.startofgamevars ; start of game variables

.frmx ; X position
.tmp1
  EQUB &58
.frmy ; Y position
  EQUB &97
.frmattr ; attrib
.tmp2
  EQUB &06
.v033D
  EQUB &01
.v033E ; ?? set to 8, compared to 0, decremented, set to &F0 (even X pos) or &0F (odd X pos) ??
  EQUB &00
.hitbitflags ; hit-detection bitmap flags
  EQUB &00
.v0340 ; frame
.tmp3
  EQUB &3A
  EQUB &00
.v0342 ; ?? inc and dec, set to 01/03/06 ?? maybe jump/gravity related ??
  EQUB &04
  EQUB &00
.cursorindex
  EQUB &00
.v0345 ; cache for X reg
  EQUB &00
.v0346 ; cache for X reg, and index
  EQUB &00
.v0347 ; cache for Y reg, and index
  EQUB &01
  EQUB &00
.v0349 ; ?? set to 0, incremented ??
  EQUB &07
.v034A ; ?? set to 0, used as an index ??
  EQUB &00
.v034B ; ?? linked to &033d, compared, incremented ??
  EQUB &01
  EQUB &00
  EQUB &00
.v034E ; cache for X reg, ??
  EQUB &07
  EQUB &00
  EQUB &00
  EQUB &00
.dizzyx
  EQUB &00
  EQUB &00
.v0354 ; .. same as 0355 ..
  EQUB &00
.v0355 ; ?? set to dizzyx-frmx, but never used ??
  EQUB &00
.v0356 ; .. same as 0357 ..
  EQUB &00
.v0357 ; ?? set to dizzyx+frmx, but never used ??
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
.dizzyy
  EQUB &00
  EQUB &00
.v035E ; .. same as 0360 ..
  EQUB &00
.v035F ; .. same as 0361 ..
  EQUB &00
.v0360 ; ?? set to dizzyy-frmx, but never used ??
  EQUB &00
.v0361 ; ?? set to dizzyy+frmx, but never used ??
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
.v0366 ; [2]
  EQUB &00
  EQUB &00
.v0368 ; ?? set to 10 and 5, but never used ??
  EQUB &00
.v0369 ; ?? set to 9 and 6, but never used ??
  EQUB &00
.v036A ; ?? set to 6 and 9, but never used ??
  EQUB &00
.v036B ; ?? set to 5 and 10, but never used ??
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
.v0370 ; [10] ?? set to 0 but never used ??
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
.v037A ; [10] related to dizzyy
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
.v0384 ; [20?] related to dizzyx
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
.msgbox_width
  EQUB &00
.msgbox_height
  EQUB &00
.cursorx_offs ; adjusted char cursor X
  EQUB &00
.cursorx ; char cursor X
  EQUB &5A
.cursory ; char cursor Y
  EQUB &90
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
.index
.deathid
.v03B7
  EQUB &00
.olddizzyroom ; &03B8 ; roomno to reincarnate into
  EQUB &00
.lives
  EQUB &00
.dragonflamepos ; 0=no flames. Active range is 66 down to 42
  EQUB &00
.v03BB ; set to 0, incremented, decremented, compared to !=0, <7, !=255, dragon related
  EQUB &00
.gameloopdelay ; main loop delay, default 15, dragon mouth open 11, decrement each flame
  EQUB &00
.v03BD ; armorog related
  EQUB &00
.liftwait ; timeout to delay lift movement when lift changes direction
  EQUB &00
.cursorattr ; char attrib
  EQUB &06
.player_input
  EQUB &00
.v03C1 ; set to 0/1/2, related to movement/animation
  EQUB &00
.player_direction ; sprite animation direction
  EQUB &00
.v03C3 ; ?? sprite animation frame related ??
  EQUB &00
.gamecounter ; pace of game actions
  EQUB &00
.v03C5 ; incremented index into ?? strings table ??
  EQUB &00
.v03C6 ; byte read using index from &03C5
  EQUB &00
.v03C7 ; ?? animation sequence related ??
  EQUB &00
.v03C8 ; ?? movement or animation related 0/1/2/3 ??
  EQUB &00
.v03C9 ; ?? sprite animation frame related ??
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
  EQUB &00
.v03D5 ; set to &FF and &00
  EQUB &00
.olddizzyx ; position where Dizzy entered current room
  EQUB &00
.olddizzyy ;   used for where to reincarnate to
  EQUB &00
.prev_player_input ; cache for input from player when fire button/return was last pressed
  EQUB &00
.inventoryindex
.usedobj  ; id of objected being interacted with from inventory
  EQUB &00
.v03DA ; related to X position of water frames, set to 0
  EQUB &00
.multi_tmp ; multi-purpose temporary variable
  EQUB &00
.attrib_offset ; location of screen attribs to use, &00 = &5C00, &58 = &0400
  EQUB &00
.v03DD ; max object id to draw
  EQUB &00
  EQUB &00
.v03DF ; mostly set to &FF, but can take the value of &03E2 when non-zero
  EQUB &FF
.v03E0 ; set to 0 when entering rooms, can be frmy/8
  EQUB &00
.v03E1 ; always &B8 (184), compared against frmy
  EQUB &B8
.v03E2 ; related to c64 palette conversion and attributes
  EQUB &70
.v03E3 ; Y related when printing text, set to 8 (lives/coins), 24 (room name), and 48 ??
  EQUB &30
  EQUB &00
.roomno
  EQUB &00

  SKIP 26

.endofgamevars ; end of game variables

