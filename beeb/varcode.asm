;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Code in language workspace

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This is just for testing
.goback
  RTS

.process_inputs
{
  LDX keys
  BEQ goback ; Nothing pressed

.check_debug
  TXA:AND #PAD_DEBUG
  BEQ case_right
  JMP resetcoins

.case_right
  TXA:AND #PAD_RIGHT
  BEQ case_left
  INC dizzyx

.case_left
  TXA:AND #PAD_LEFT
  BEQ case_up
  DEC dizzyx

.case_up
  TXA:AND #PAD_UP
  BEQ case_down
  DEC dizzyy:DEC dizzyy:DEC dizzyy:DEC dizzyy

.case_down
  TXA:AND #PAD_DOWN
  BEQ checkno
  INC dizzyy:INC dizzyy:INC dizzyy:INC dizzyy

.checkno

  ; See if we've gone offscreen to the left
.chleft
  LDA dizzyx:CMP #32:BCS chright
  LDA roomno:SEC:SBC #&01:STA newroomno
  LDA #92:STA dizzyx:JMP roomrange
  ; See if we've gone offscreen to the right
.chright
  LDA dizzyx:CMP #92:BCC chtop
  LDA roomno:CLC:ADC #&01:STA newroomno
  LDA #32:STA dizzyx:JMP roomrange
  ; See if we've gone offscreen to the top
.chtop
  LDA dizzyy:CMP #40:BCS chbottom
  LDA roomno:CLC:ADC #&10:STA newroomno
  LDA #168:STA dizzyy:JMP roomrange
  ; See if we've gone offscreen to the bottom
.chbottom
  LDA dizzyy:CMP #168:BCC roomrange
  LDA roomno:SEC:SBC #&10:STA newroomno
  LDA #40:STA dizzyy

.roomrange
  LDA newroomno:CMP #ROOM_STRINGS:BCC done
  LDA #STARTROOM:STA newroomno ; Reset

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.updatewater
{
  ; First check if there is any water in current room
  LDA noofwater:BEQ done

  ; Save water count for loop
  TAX

  ; Set water frame size for collision
  LDA #32:LSR A:LSR A:STA cw
  LDA #6:STA ch

  ; Get water colour, e.g. water or lava
  LDA watercolour
  AND #&E7:ORA #&10 ; Make sure it's set to EOR plot
  STA z80creg

  LDY #&00
.updatewaterlp

  LDA waterlist, Y:STA z80ereg:AND #&7F:STA cx:INY
  LDA waterlist, Y:STA z80lreg:STA cy:INY
  LDA waterlist, Y
  STA zidx4:INC zidx4:LDA zidx4:AND #&03:STA waterlist, Y:INY
  CLC:ADC #SPR_WATER0
  JSR store_sprite_vars
  JSR frame

  ; Check for collision with water or lava
  JSR collidewithdizzy3
  BEQ notdrowned

  if liquidkills=1

  LDA #30:STA killed
  ; LDA #6:STA sequence ; bob upside down
  JSR checkkeys ; resets left & right

  LDA #STR_killedbyvolcano:STA deathmsg ; Set death message to show
  LDA roomno:CMP #77:BEQ yesfellinlava
  LDA #STR_killedbywater:STA deathmsg ; Set death message to show
.yesfellinlava
  ;JSR killdizzy1

  endif

.notdrowned
  DEX:BNE updatewaterlp

.done
  RTS
}

.updateflames
{
  ; First check if there are flames in current room
  LDA noofflames:BEQ done

  ; Save flame count for loop
  TAX

  ; Update flame loop
  LDA #SPR_FLAME:STA frmno
  LDA clock:AND #&01:TAY:LDA flamecolours, Y ; Set flame colour based on odd/even clock
  STA frmattri

  LDY #&00
.updateflamelp

  LDA flamelist, Y:STA frmx:AND #&7F:STA cx:INY
  LDA flamelist, Y:STA frmy:STA cy:INY
  INY
  JSR frame

  if firekills=1

  ; Set flame frame size for collision
  LDA #16:LSR A:LSR A:STA cw
  LDA #13:STA ch

  ; Check for collision with flame
  JSR collidewithdizzy3
  BEQ notburnt

  ;Disable left/right movement
  LDA #&00:STA left:STA right

  LDA #STR_killedbyflame:STA deathmsg ; Set death message to show
  LDA #50 ;; flame
  JSR killdizzy1

  endif

.notburnt

  DEX:BNE updateflamelp

.done
  RTS

.flamecolours
  EQUB     &02  ; Red
  EQUB &80+&07  ; White (h-flip)
}

.addtoflame
{
  LDA #lo(flamelist):STA zptr6
  LDA #hi(flamelist):STA zptr6+1
  LDA #0:STA ztmp6
  LDA noofflames:TAY
  INC noofflames

  LDA #PLOT_AND:STA frmplot

  JMP joinaddtothing
}

.addtowater
{
  LDA frmattri:STA watercolour
  LDA #3:STA ztmp6

  ; Check if we're at the broken bridge
  LDA roomno:CMP #48:BNE normalwater

  LDA waterheight
  EOR #&FF:CLC:ADC #1+168 ; Negate then add 168
  STA frmy

  LDA #3:STA ztmp7
.stretchwater
  JSR frame
  JSR normalwater
  LDA frmx:CLC:ADC #8:STA frmx

  DEC ztmp7:LDA ztmp7
  BNE stretchwater

  RTS

.normalwater
  LDA #lo(waterlist):STA zptr6
  LDA #hi(waterlist):STA zptr6+1

  LDA noofwater:TAY
  INC noofwater

  ; Fall through
}

.joinaddtothing
{
  ; Frame in ztmp6
  ; Array pointer in zptr6

  ; Index in Y
  TYA:BEQ first

  STY ztmp5:TYA:ASL A:CLC:ADC ztmp5:TAY ; Y = Y*3

.first
  ; Data is stored as X, Y, Frame
  LDA frmx:STA (zptr6), Y ; X
  INY
  LDA frmy:STA (zptr6), Y ; Y
  INY
  LDA ztmp6:STA (zptr6), Y ; Frame

  RTS
}

; Find pointer to string[A] in room string table
; Sets zptr5 to result
.findroomstr
{
  PHA

  PAGE_ROOMDATA

  ; Check for strings room
  LDA roomno:CMP #ROOM_STRINGS:BEQ roomnotempty

  ; Check for empty room
  LDA roomlen:BNE roomnotempty
  LDA roomlen+1:BNE roomnotempty

  ; Check for room name being requested
  PLA ; Recover string offset
  CMP #STR_roomname:BNE invalidstr
  LDA #hi(emptyroomname):STA zptr5+1
  LDA #lo(emptyroomname):STA zptr5
  JMP done

  ; Some other string being requested - invalid, so return empty string
.invalidstr
  LDA #hi(emptystring):STA zptr5+1
  LDA #lo(emptystring):STA zptr5
  JMP done

.roomnotempty
  ; Point to data for current room
  LDA roomno
  ASL A:TAY
  LDA roomtable, Y:STA zptr5
  LDA roomtable+1, Y:CLC:ADC #hi(ROMSBASE):STA zptr5+1

  ; Copy pointer from zptr5 to zptr6
  LDA zptr5:STA zptr6
  LDA zptr5+1:STA zptr6+1

  PLA ; Recover string offset
  ASL A:TAY
  LDA zptr5:CLC:ADC (zptr6), Y:STA zptr5 ; Increment lo part of pointer
 
  BCC samepage ; Check page for overflow
  INC zptr5+1

.samepage
  INY
  LDA zptr5+1:CLC:ADC (zptr6), Y:STA zptr5+1 ; Increment hi part of pointer

.done
  RTS

.emptystring
  EQUB PRT_END
}

.roomsetup
{
  ; room data was compacted a lot,because of the amount
  ; of memory it took, the edit has data
  ;
  ; 0=room
  ; 1=FRAME
  ; 2=X
  ; 3=Y
  ; 4=COLOUR +reverse stuff
  ;
  ; this was compacted to a table of word pointers to the start of the
  ; of each room therefore using only 4 bytes.
  ;
  ; Then if the colour of the next frame is the same
  ; as the previous then bit 7 of the X coord is set

  STA roomno ; Backup room number

  PAGE_ROOMDATA

  ; Clear palette to hide draw
  LDA #PAL_BLANK:JSR setpal

  ; Clear play area
  JSR clearplayarea

  LDA #&00
  STA noofwater:STA noofflames:STA breathingfire

  JSR drawfullroom

  JSR checkbeanstalk
  JSR checkfireout

  if seecoins=0
    ; Draw any coins in this room
    JSR putcoinsinroom

    ; Draw any objects in this room (after coins so objects can hide coins)
     JSR resetroommoving
  endif

  if seecoins=1
    ; Draw any objects in this room
    JSR resetroommoving

    ; Draw any coins in this room
    JSR putcoinsinroom
  endif

  ; Write the room name
  JSR printroomname

  ; Show room in game palette
  LDA #PAL_GAME:JSR setpal

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LDA roomno:BEQ done
  LDA dontupdatedizzy:BNE done

  ; Draw initial frame (so there is something to rub out)
  LDA dizzyfrm:AND #&1F:STA frmno
  LDA dizzyx:STA frmx:STA oldx
  LDA dizzyy:STA frmy:STA oldy
  LDA #PAL_WHITE:STA frmattri
  JSR drawdizzy
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.done
  RTS
}

.dotreasurepic
{
  ; Clear palette to hide draw
  LDA #PAL_BLANK:JSR setpal

  ; Load treasure island pic
  LDX #lo(trepiccmd)
  LDY #hi(trepiccmd)
  JSR OSCLI

  ; Show the picture with correct palette
  LDA #PAL_DIZZY2:JSR setpal

  JSR handoffandwait

  ; Clear palette to hide draw
  LDA #PAL_BLANK:JSR setpal

  ; Dizzy 3 frame
  LDX #lo(framepiccmd)
  LDY #hi(framepiccmd)
  JSR OSCLI

  ; Re-draw the room
  LDA #52:JSR roomsetup

   ; Revert to game palette
  LDA #PAL_GAME:JSR setpal

.done
  RTS

.trepiccmd
  EQUS "L.TREPIC", &0D
.framepiccmd
  EQUS "L.FRAME", &0D
}

.checkbeanstalk
{
  LDA roomno:CMP #ALLOTMENTROOM:BNE done ; Make sure we are in the allotment

  LDA manurehere+var1
  CMP #02:BNE done ; Check status of manure

  LDA #BEANSTALKROOM:STA roomno:JSR drawfullroom ; Draw beanstalk
  LDA #ALLOTMENTROOM:STA roomno ; Reset current room to be allotment

.done
  RTS
}

.checkfireout
{
  LDA roomno:CMP #STARTROOM:BNE done ; Make sure we are in the dungeon

  LDA fireout:BNE done ; Check status of fire

  LDA #FIREROOM:STA roomno:JSR drawfullroom ; Draw fire
  LDA #STARTROOM:STA roomno ; Reset current room to be dungeon

.done
  RTS
}
