; Wait for vertical trace
.waitvsync
{
  TXA:PHA

  LDA #&13
  JSR OSBYTE

  PLA:TAX

  RTS
}

; Palettes
PAL_BLANK = &00
PAL_GAME  = &01

; Set palette to one specified in A
.setpal
{
  ASL A:ASL A:ASL A:TAY
  LDX #&00
.loop
  LDA #&13:JSR OSWRCH
  LDA paltable, Y:JSR OSWRCH:INY:INX
  LDA paltable, Y:JSR OSWRCH:INY:INX
  LDA #&00:JSR OSWRCH:JSR OSWRCH:JSR OSWRCH
  CPX #&08
  BNE loop

  RTS

.paltable
  ; blank palette
  ; black, black, black, black
  EQUB 0,0, 1,0, 2,0, 3,0

  ; Game palette
  ; black, red, green, white
  EQUB 0,0, 1,1, 2,2, 3,7
}

; Clear play area
.clearplayarea
{
  LDA #PLAYAREA DIV 256:STA zptr1+1
  LDA #PLAYAREA MOD 256:STA zptr1

.outerloop
  LDY #&10 ; Avoid left border

.leftloop
  LDA #&00:STA (zptr1), Y
  INY
  BNE leftloop

  INC zptr1+1

.rightloop
  LDA #&00:STA (zptr1), Y
  INY
  CPY #&F0 ; Avoid right border
  BNE rightloop

  ; Next line
  INC zptr1+1
  LDA zptr1+1
  CMP #&7E ; Avoid bottom border
  BNE outerloop

  RTS
}

; Test if pixel about to be plotted would overwrite border or header
.test_clip
{
  ; Clipping
  LDA cliptoplayarea:BEQ done ; Don't clip when clipping disabled

  ; Create pointer to where plotting will take place
  LDA zptr2+1:STA zptr6+1
  LDA zptr2:CLC:ADC zidx2:STA zptr6
  BCC samepage
  INC zptr6+1
.samepage

  LDA zptr6+1
  CMP #hi(PLAYAREA):BCC do_clip ; Clip top
  CMP #hi(ROMSBASE)-2:BCS do_clip ; Clip bottom
  AND #&01:BNE try_right
  LDA zptr6:CMP #&10:BCC do_clip ; Clip left
.try_right
  LDA zptr6+1
  AND #&01:BEQ ok_right
  LDA zptr6:CMP #&F0:BCS do_clip ; Clip right
.ok_right

  LDA #&00:BEQ done

.do_clip
  LDA #&FF

.done
  RTS
}

; Flip frame horizontally
.flipframe
{
  ; Save registers
  PHA
  TXA:PHA
  TYA:PHA

  ; Point at flipped frame memory
  LDA #lo(flippedframe):STA zptr6
  LDA #hi(flippedframe):STA zptr6+1

  LDY #&00 ; Initialise offset counter
.yloop
  LDX ztmp1 ; Set row counter to bytes/row
  STY ztmp4 ; Cache start of row offset
.xloop
    STX ztmp6 ; Cache row counter
    LDA (zptr1), Y ; Load source byte
    TAX:LDA flip_lut, X ; FLip pixels using look up table
    PHA ; Cache flipped pixels
    STY ztmp5 ; Cache offset counter
    LDA ztmp4:CLC:ADC ztmp6:TAY:DEY ; Add row to start of row offset
    PLA ; Restore flipped pixels
    STA (zptr6), Y ; Store flipped pixels in flippedframe buffer
    LDY ztmp5 ; Restore offset counter
    INY ; Advance offset
    LDX ztmp6 ; Restore row counter
    DEX:BNE xloop ; Carry on until row counter is zero
  CPY ztmp3:BNE yloop ; Carry on until all source bytes processed

  ; Point at newly flipped frame as the one to render
  LDA #lo(flippedframe):STA zptr1
  LDA #hi(flippedframe):STA zptr1+1

.done
  ; Restore registers
  PLA:TAY
  PLA:TAX
  PLA

  RTS
}

; Draw a frame to play area
.drawframe
{
  ; zptr1 = source pointer
  ; zptr2 = screen pointer, add 0x08 to do pixels to the right, add 0x10 for next byte
  ; zptr3 = left edge of frame screen pointer
  ; ztmp1 = source bytes per row
  ; ztmp2 = byte in current row counter
  ; ztmp3 = total bytes in source
  ; ztmp4 = full row counter

  ; Save registers
  PHA
  TXA:PHA
  TYA:PHA

  ; Get offset to frame data
  LDA #hi(frametable):STA zptr2+1
  LDA #lo(frametable):STA zptr2

  LDA frmno
  BPL nochange
  INC zptr2+1
.nochange
  ASL A:TAY

  INY:LDA (zptr2), Y
  CMP #&FF:BEQ jdone ; Don't draw NULL frames
  CLC:ADC #hi(framedefs):STA zptr1+1

  DEY:LDA (zptr2), Y
  CLC:ADC #lo(framedefs):STA zptr1
  BCC samepage
  INC zptr1+1
.samepage

  ; Get (width/4)
  LDY #&00:LDA (zptr1), Y:STA frmwidth

  ; Get height
  INY:LDA (zptr1), Y:STA frmheight

  ; Get colour mask
  LDA frmattri:LSR A:AND #&03:TAX
  LDA colourmask, X:STA frmcolour

  ; Move on past frame header
  INC zptr1:INC zptr1

  ; Get plot type
  LDA frmattri:AND #&018
  LSR A:LSR A
  STA frmplot
  ; Modify code
  TAY
  LDA plot_modes, Y:STA plot_high:STA plot_low
  LDA plot_modes+1, Y:STA plot_high+1:STA plot_low+1

  ; Get h-flip
  LDA frmattri:AND #&80
  STA frmreverse

  ; Calculate bytes per row
  LDA frmwidth:LSR A
  PHA:STA ztmp1

  ; Calculate total number of bytes in source frame
  PLA:TAX ; Get bytes per row
  LDA #&00
.total
  CLC:ADC frmheight
  DEX
  BNE total
  STA ztmp3

  ; Flip frame horizontally if required
  LDA frmreverse:BEQ dontflip
  JSR flipframe
.dontflip

  ; Set source/dest to 0
  LDA #&00:STA zidx1:STA zidx2:STA ztmp4

  ; Just for reachability
  JMP cont
.jdone
  JMP done
.cont

  ; Point to start of top left of position to draw frame
  LDA #MODE8BASE DIV 256:STA zptr3+1:STA zptr2+1
  LDA #MODE8BASE MOD 256:STA zptr3:STA zptr2

  ; Advance to X/Y position
  LDA frmy
  BEQ noy
  LSR A:LSR A ; Divide Y by 4
  AND #&FE
  STA yjump+2 ; Store result as operand for ADC below
  LDA zptr3+1 
.yjump
  CLC:ADC #&00
  STA zptr3+1:STA zptr2+1

  ; Add small y offset
  LDA frmy
  AND #&07
  STA ztmp4
  CLC:ADC zptr3:STA zptr3:STA zptr2
.noy

  LDA frmx:AND #&7F
  BEQ nox
  TAX
.xloop
  LDA zptr3:CLC:ADC #&08:STA zptr3:STA zptr2
  BCC samepage2
  INC zptr3+1:INC zptr2+1
.samepage2
  DEX
  BNE xloop
  DEC zptr3+1:DEC zptr2+1
.nox 

.loop
  LDA #&00:STA ztmp2 ; Reset row counter
.rowloop

  ; Clipping
  JSR test_clip:BEQ no_clip
  LDA #&00:BEQ nextnibble

.no_clip

  ; High nibble
  LDY zidx1
  LDA (zptr1), Y
  AND #&F0
  LSR A:LSR A:LSR A:LSR A
  TAX:LDA convert_1bpp_to_2bpp, X
  LDY zidx2
  AND frmcolour
.plot_high
  NOP:NOP ; Plot mode (gets replaced at runtime)
  STA (zptr2), Y

.nextnibble
  LDA zidx2:CLC:ADC #&08:STA zidx2 ; Advance to next block on the right

  ; Clipping
  JSR test_clip:BEQ no_clip2
  LDA #&00:BEQ nextsourcebyte

.no_clip2

  ; Low nibble
  LDY zidx1
  LDA (zptr1), Y
  AND #&0F
  TAX:LDA convert_1bpp_to_2bpp, X
  LDY zidx2
  AND frmcolour
.plot_low
  NOP:NOP ; Plot mode (gets replaced at runtime)
  STA (zptr2), Y

.nextsourcebyte

  LDA zidx2:CLC:ADC #&08:STA zidx2 ; Advance to next block on the right

  ; Advance to next source byte
  INC zidx1

  ; Advance row counter
  INC ztmp2:LDA ztmp2
  CMP ztmp1
  BNE rowloop ; Go round again if we haven't completed the row

  INC ztmp4

  ; Reset to start of row, but one down
  LDA #&00:STA zidx2
  INC zptr3:LDA zptr3:STA zptr2
  LDA zptr3+1:STA zptr2+1

  ; If we're divisible by 8, need to move to top of next cell down
  LDA ztmp4
  AND #&07
  CMP #&00
  BNE nodiv8
  LDA zptr3:SBC #&08:STA zptr3:STA zptr2
  LDA zptr3+1:CLC:ADC #&02:STA zptr3+1:STA zptr2+1
.nodiv8

  ; Check to see if we've drawn all the source bytes
  LDA zidx1:CMP ztmp3:BEQ done
  JMP loop

.done
  ; Restore registers
  PLA:TAY
  PLA:TAX
  PLA

  RTS

; Table for 1bpp->2bpp graphics conversion
.convert_1bpp_to_2bpp
  EQUB &00, &11, &22, &33, &44, &55, &66, &77
  EQUB &88, &99, &AA, &BB, &CC, &DD, &EE, &FF

; Table for mask values to AND against 1bpp->2bpp values
.colourmask
  EQUB &00 ; Black
  EQUB &0F ; Red
  EQUB &F0 ; Green
  EQUB &FF ; White

; Code for the various plot modes
.plot_modes
  NOP:NOP ; Normal
  ORA (zptr2), Y ; OR
  EOR (zptr2), Y ; Exclusive OR
}

.drawroom
{
  STA roomno ; Backup room number

  ; Set up pointer to data for this room
  ASL A:TAY
  LDA roomtable, Y:STA roomptr
  LDA roomtable+1, Y:STA roomptr+1

  ; Set up pointer to data for next room
  LDA roomtable+2, Y:STA nextroomptr
  LDA roomtable+3, Y:STA nextroomptr+1

  ; Clear palette to hide draw
  LDA #PAL_BLANK:JSR setpal

  ; Clear play area
  JSR clearplayarea

  ; If this is an empty room, then stop now
  LDA roomptr+1:CMP nextroomptr+1:BNE roomok
  LDA roomptr:CMP nextroomptr:BNE roomok

  ; Write the room name as a blank one
  LDA #ROOM_EMPTY:JSR writeroomname

  ; Show room in game palette
  LDA #PAL_GAME:JSR setpal

  RTS

.roomok

  ; Set up defaults
  LDA #&00:STA frmattri:STA ztmp6

  TAY
.loop
  LDA (roomptr), Y:STA frmno:INY
  LDA (roomptr), Y:STA frmx:INY
  LDA (roomptr), Y:STA frmy:INY

  ; When frmx top-bit not set, then also update attrib
  LDA frmx:BMI sameattrib
  LDA (roomptr), Y:STA frmattri:INY
.sameattrib

  ; All the data has been read for this frame, so draw it
  JSR drawframe

  ; Advance room pointer to next tile
  TYA:CLC:ADC roomptr:STA roomptr
  BCC samepage
  INC roomptr+1
.samepage

  ; Check if we're done
  LDY #&00
  LDA roomptr+1:CMP nextroomptr+1:BNE loop
  LDA roomptr:CMP nextroomptr:BNE loop

  ; If this is first room (title screen), show extra chars
  LDA roomno
  BNE playscr
  JSR titlescreen
.playscr

  ; Write the room name
  JSR writeroomname

  ; Draw any coins in this room
  JSR putcoinsinroom

  ; Draw any objects in this room (after coins so objects can hide coins)
  JSR putobjectsinroom

  ; Show room in game palette
  LDA #PAL_GAME:JSR setpal

  RTS
}

.putcoinsinroom
{
  LDX #&00
.loop
  STX ztmp6:TXA:ASL A:CLC:ADC ztmp6:TAY ; Y = X*3

  ; Is current coin in current room
  LDA cointable+2, Y:CMP roomno:BNE nextcoin

  LDA #&00:STA frmno ; Coin frame
  LDA #PAL_WHITE:STA frmattri
  LDA cointable, Y:STA frmx
  LDA cointable+1, Y:STA frmy
  JSR drawframe

.nextcoin

  INX:CPX #totalcoins:BNE loop

  RTS
}

.putobjectsinroom
{
  LDA #lo(movingdata):STA zptr4
  LDA #hi(movingdata):STA zptr4+1

  LDX #&00
.loop
  ; Is current object in current room
  LDY #room:LDA (zptr4), Y:CMP roomno:BNE nextobject

  LDY #movefrm:LDA (zptr4), Y:STA frmno
  LDY #colour:LDA (zptr4), Y:STA frmattri
  LDY #movex:LDA (zptr4), Y:STA frmx
  LDY #movey:LDA (zptr4), Y:STA frmy

  JSR drawframe

.nextobject

  ; Advance to next object
  LDA zptr4:CLC:ADC #&10:STA zptr4
  BCC samepage
  INC zptr4+1
.samepage

  INX:CPX #noofmoving:BNE loop ; Loop until done

  RTS
}

.writeroomname
{
  ; Set pen colour and position cursor
  LDA #hi(roomnamepos):STA zptr5+1
  LDA #lo(roomnamepos):STA zptr5
  JSR prtmessage

  ; Set pointer to room name
  LDA roomno:ASL A:TAY
  LDA roomnames, Y:STA zptr5
  LDA roomnames+1, Y:STA zptr5+1
  JSR prtmessage

  RTS

.roomnamepos
  EQUB PRT_PEN+4,PRT_XY+12,24
  EQUB PRT_END
}

.windowrou
{
  ; dontupdatedizzy = 1 ; Stop Dizzy from moving
  JSR prtmessage

.^windowrou2
  JSR handoffandwait ; Wait for new key press
.^windowrou1
  JSR resetuproom

  ; dontupdatedizzy = 0 ; Allow Dizzy to move again

  RTS
}

; Wait until nothing pressed, then wait for something to be pressed
.handoffandwait
{
  LDA keys:BNE handoffandwait

.waitforkey
  LDA keys:BEQ waitforkey

  RTS
}

.resetuproom
{
  LDA roomno:JSR drawroom

  RTS
}

.titlescreen
{
  LDA #hi(startmess):STA zptr5+1
  LDA #lo(startmess):STA zptr5
  JSR prtmessage

  LDA #58:STA frmx
  LDA #57:STA frmy
  LDA #7:STA frmattri
  LDA #27:STA frmno ; Dizzy logo
  JSR drawframe

  RTS

.startmess
  EQUB PRT_XY+19,49,PRT_PEN+3, "FANTASY:WORLD"

  EQUB PRT_XY+24,80,PRT_PEN+2, "STARRING"
  EQUB PRT_XY+20,89, "THE:YOLKFOLK"
  EQUB PRT_XY+20,108,PRT_PEN+5,"D",PRT_XY+22,106,"I",PRT_XY+24,104,"Z"
  EQUB PRT_XY+26,102,"Z",PRT_XY+28,100,"Y"

  EQUB PRT_XY+35,100,"D",PRT_XY+37,102,"A",PRT_XY+39,104,"I"
  EQUB PRT_XY+41,106,"S",PRT_XY+43,108,"Y"

  EQUB PRT_XY+9,142, "DENZIL:DYLAN"
  EQUB PRT_XY+35,136, "DOZY"
  EQUB PRT_XY+46,136, "GRAND"
  EQUB PRT_XY+46,144, "DIZZY"
  EQUB PRT_PEN+6,":"

  EQUB PRT_END
}

.prtmessage
{
  ; Control codes are
  ; 0 - END
  ; 128+X, Y
  ; 3 - Plot chr/attr bit 0 chr bit 1 attr
  ; 4 - GOSUB
  ; 5 - REPEAT
  ; 6 - ENDREPEAT
  ; 9 - DRAW BOX width, height
  ; 10 - NOP (but moves across like a char)
  ; 16+(0-7) - Pen colour
  ;
  ; Pointer to message in zptr5

  LDA #&00:STA cliptoplayarea

  LDY #&00

.loop
  LDA (zptr5), Y:INY

  ; Is it the end of the message
  BNE notdone
  JMP done
.notdone

  ; Is it a change of X/Y
  CMP #PRT_XY:BCS changexy

  ; Anything else above control codes must be a character
  CMP #' ':BCS mustbeachar

  ; Is it a pen change
  CMP #PRT_PEN:BCS changepen

  ; Is it a plot type change
  CMP #PRT_PLOT:BEQ changeplot

  CMP #PRT_DRAWBOX:BEQ drawbox

  ; Anything else is not supported at this time
  JMP done

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Byte in A must be a char, so print it at cursor position
.mustbeachar
  STA frmno
  LDA messx:CLC:ADC #&20:STA frmx
  LDA messy:STA frmy
  LDA messpen:STA frmattri
  LDA messplot:STA frmplot
  JSR drawframe
  LDA messx:CLC:ADC #&02:STA messx ; Advance cursor
  JMP loop

  ; Change the X/Y position
.changexy
  STA messx
  LDA (zptr5), Y:STA messy:INY
  JMP loop

  ; Change pen 
.changepen
  AND #&07:STA messpen
  JMP loop

  ; Change plot type
.changeplot
  LDA (zptr5), Y:STA messplot:INY
  JMP loop

.drawbox
  ; Draw a box from messx,messy with messwidth,messheight
  ;
  ;   44          44
  ;42 46 40 40 40 46 43
  ;   41          41
  ;   41          41
  ;   41          41
  ;42 46 40 40 40 46 43
  ;   45          45
  
  LDA (zptr5), Y:CLC:ADC #&02:STA ztmp5:STA messwidth:INC messwidth:INC messwidth:INY
  LDA (zptr5), Y:CLC:ADC #&02:STA ztmp6:STA messheight:INC messheight:INC messheight:INY
  TYA:PHA ; Cache Y index

  LDA messx:CLC:ADC #&20:STA frmx ; Set X position
  LDA messy:STA frmy ; Set Y position
  LDA messpen:STA frmattri ; Store attributes
  LDA messplot:STA frmplot ; Store draw style

  LDY #&00
.boxyloop
  LDX #&00
.boxxloop
  ; Depending on where we are draw different frame

  ; Check for "middle"
  CPX #02:BCC ch0
  CPY #02:BCC ch0
  CPX ztmp5:BCS ch0
  CPY ztmp6:BCS ch0
  LDA #':':JMP dodraw ; Blank space

.ch0
  ; Check for intersections
  CPX #01:BNE ch0b ; Check for left side
  CPY #01:BEQ intersect
  CPY ztmp6:BEQ intersect
  LDA #&01:BNE ch1 ; Always branch - not an intersection
.ch0b
  CPX ztmp5:BNE ch1; Check for right side
  CPY #01:BEQ intersect
  CPY ztmp6:BEQ intersect
  LDA #&01:BNE ch1 ; Always branch - not an intersection

.intersect
  LDA #46:BNE dodraw ; Intersection

.ch1
  ; Check for left edge
  CPX #01:BNE ch2 ; Is it the left edge
  CPY #00:BNE ch1b ; Is it the top edge
  LDA #44:BNE dodraw ; Top of vertical bar
.ch1b
  CPY ztmp6:BCC ch1c ; Is it the bottom edge
  LDA #45:BNE dodraw ; Bottom of vertical bar
.ch1c
  LDA #41:BNE dodraw ; Vertical bar

.ch2
  ; Check for right edge
  CPX ztmp5:BNE ch3 ; Is it the right edge
  CPY #00:BNE ch2b ; Is it the top edge
  LDA #44:BNE dodraw ; Top of vertical bar
.ch2b
  CPY ztmp6:BCC ch2c ; Is it the bottom edge
  LDA #45:BNE dodraw ; Bottom of vertical bar
.ch2c
  LDA #41:BNE dodraw ; Vertical bar

.ch3
  ; Check for top edge
  CPY #01:BNE ch4 ; Is it the top edge
  CPX #00:BNE ch3b; Is it the left edge
  LDA #42:BNE dodraw ; Left horizontal bar
.ch3b
  CPX ztmp5:BCC ch3c; Is it the right edge
  LDA #43:BNE dodraw
.ch3c
  LDA #40:BNE dodraw ; Horizontal bar

.ch4
  ; Check for bottom edge
  CPY ztmp6:BNE ch5
  CPX #00:BNE ch4b; Is it the left edge
  LDA #42:BNE dodraw ; Left horizontal bar
.ch4b
  CPX ztmp5:BCC ch4c; Is it the right edge
  LDA #43:BNE dodraw
.ch4c
  LDA #40:BNE dodraw ; Horiztonal bar

.dodraw
  STA frmno:JSR drawframe

.ch5

  LDA frmx:CLC:ADC #&02:STA frmx ; Advance X position
  INX:CPX messwidth:BEQ loopxdone
  JMP boxxloop
.loopxdone

  LDA messx:CLC:ADC #&20:STA frmx ; Reset X position
  LDA frmy:CLC:ADC #&08:STA frmy ; Advance Y position
  INY:CPY messheight:BEQ loopydone
  JMP boxyloop
.loopydone

  PLA:TAY ; Restore Y index
  JMP loop

.done
  LDA #&01:STA cliptoplayarea

  RTS

; Message variables
.messx
  EQUB 0
.messy
  EQUB 0
.messpen
  EQUB 0
.messplot
  EQUB 0

.messwidth
  EQUB 0
.messheight
  EQUB 0
}
