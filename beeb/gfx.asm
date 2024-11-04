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
PAL_DIZZY2 = &02

; Set palette to one specified in A
.setpal
{
  JSR flyback

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
  ; Blank palette
  ; black, black, black, black
  EQUB 0,0, 1,0, 2,0, 3,0

  ; Game palette
  ; black, red, green, white
  EQUB 0,0, 1,1, 2,2, 3,7

  ; Dizzy2 screenshot palette
  ; black, blue, yellow, white
  EQUB 0,0, 1,4, 2,3, 3,7
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
  CPY #(MAXX-&10) ; Avoid right border
  BNE rightloop

  ; Next line
  INC zptr1+1
  LDA zptr1+1
  CMP #hi(ROMSBASE)-2 ; Avoid bottom border
  BNE outerloop

  JMP clearattris
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

; Rub out Dizzy
.ruboutdizzy
{
  ; Rub out
  LDA dizzyfrm:STA frmno
  LDA oldx:STA frmx
  LDA oldy:STA frmy
  LDA #PAL_WHITE:STA frmattri

  ; Fall through
}

; Draw Dizzy
.drawdizzy
{
  ; Save registers
  PHA
  TXA:PHA
  TYA:PHA

  PAGE_MOREDATA

  ; Get pointer to frame data
  LDA #hi(dizzytable):STA zptr2+1
  LDA #lo(dizzytable):STA zptr2

  LDA frmno
  ASL A:TAY ; Y = A * 2

  ; Get low byte of pointer
  LDA (zptr2), Y
  STA zptr1

  ; Get high byte of pointer
  INY:LDA (zptr2), Y
  CLC:ADC #hi(ROMSBASE):STA zptr1+1

  ; Set (width/4)
  LDA #DIZZY_WIDTH/4:STA frmwidth

  ; Get height
  LDY #&00:LDA (zptr1), Y:STA frmheight

  ; Set frame attributes
  LDA #PAL_WHITE+PLOT_XOR:STA frmattri

  JMP render
}

; Draw a frame to play area
.frame
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

  ; Make sure sprites are paged in
  PAGE_MOREDATA

  LDA frmno
  BPL nochange
  INC zptr2+1
.nochange
  ASL A:TAY ; Y = A * 2

  ; Get high byte of offset
  INY:LDA (zptr2), Y
  CMP #&FF:BEQ jdone ; Don't draw NULL frames
  CLC:ADC #hi(ROMSBASE):STA zptr1+1

  ; Get low byte of offset
  DEY:LDA (zptr2), Y
  CLC:ADC #lo(ROMSBASE):STA zptr1
  BCC samepage
  INC zptr1+1
.samepage

  ; Get (width/4)
  LDY #&00:LDA (zptr1), Y:STA frmwidth

  ; Get height
  INY:LDA (zptr1), Y:STA frmheight

.^render

  ; Get colour mask
  LDA frmattri:LSR A:AND #&03:TAX
  LDA colourmask, X:STA frmcolour

  ; Move on past frame header
  INC zptr1:INC zptr1
  LDA zptr1:CMP #02:BCS samepageb ; If it's >= 2 then no page crossed
  INC zptr1+1
.samepageb

  ; Get plot type
  LDA frmattri:AND #&18
  LSR A:LSR A
  CMP #&06:BEQ jdone ; DONT ALLOW PLOT TYPE 6
  STA frmplot

  ; Modify code
  TAY
  LDA plot_modes, Y:STA plot_high:STA plot_low
  LDA plot_modes+1, Y:STA plot_high+1:STA plot_low+1

  ; Get h-flip
  LDA frmattri:AND #ATTR_REVERSE
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

if allowupsidedown = 0
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
endif

if allowupsidedown = 1
  ;TXA:PHA
  LDA frmy:TAX:TAY
  LDA upsidedown:BEQ noflip
  LDA #MAXY+(5*8):SEC:SBC frmy:TAY
  TAX
.noflip
  LDA screentable_hi, X
  STA zptr3+1:STA zptr2+1

  LDA screentable_lo, X
  STA zptr3:STA zptr2
  ;PLA:TAX

  TYA
  AND #&07
  STA ztmp4
endif

  LDA frmx:AND #&7F
  BEQ nox ; Don't advance pointer if it's 0
  CMP #&5E:BCC onscreen ; Check if frame is onscreen (visible)
  JMP done
.onscreen
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

  ; Test for negative frmx value (i.e. crop LHS of frame when drawn)
  ;   frmx of 32 means 0 in screen coordinates, so anything less is negative
  ;
  ; The formula is screenx = (frmx * 4) - 128
  LDA #&00:STA zidx5 ; first block to draw
  LDA frmx:AND #&7F:PHA
  CMP #NEGATIVE_OFFSET:BCS noneg ; values >= 32 are not negative

  ; Calculate first block to draw in row
  ;  block = (16 - ceil(frmx / 2))
  PLA:LSR A:ADC #&00:STA zidx5
  LDA #&10:SEC:SBC zidx5:STA zidx5
  PHA
.noneg
  PLA

  ; Test for RHS overflow
  ;
  ; Right border starts at 248 pixels (94 in frmx coordinates)

  LDA ztmp1:STA zidx6 ; last block to draw

  LDA frmx:AND #&7F ; get left side of sprite
  CLC:ADC frmwidth ; add width
  CMP #BORDER_RIGHT:BCC loop ; check for border overflow

  SEC:SBC #BORDER_RIGHT ; calculate difference
  LSR A:STA ztmp2 ; convert to delta (bytes per row) and cache
  LDA zidx6:SEC:SBC ztmp2:STA zidx6 ; subtract delta

.loop
  LDA #&00:STA ztmp2 ; Reset row counter
.rowloop

  ; Clipping
  JSR test_clip:BEQ no_clip
  LDA #&00:BEQ nextnibble

.no_clip
  LDA ztmp2:CMP zidx5:BCC nextnibble ; skip while negative screenx
  CMP zidx6:BCS nextnibble ; Skip while RHS overflow

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
  LDA ztmp2:CMP zidx5:BCC nextsourcebyte ; skip while negative screenx
  CMP zidx6:BCS nextsourcebyte ; Skip while RHS overflow

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

if allowupsidedown = 1
  LDA upsidedown
  BNE drawupsidedown
{
endif

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

if allowupsidedown = 1
  JMP drawdone
}

.drawupsidedown
{
  DEC ztmp4

  ; Reset to start of row, but one up
  LDA #&00:STA zidx2
  DEC zptr3:LDA zptr3:STA zptr2
  LDA zptr3+1:STA zptr2+1

  ; If we're divisible by 8, need to move to bottom of next cell up
  LDA ztmp4
  AND #&07
  CMP #&07
  BNE nodiv8
  LDA zptr3:CLC:ADC #&08:STA zptr3:STA zptr2
  LDA zptr3+1:SEC:SBC #&02:STA zptr3+1:STA zptr2+1
.nodiv8
}

.drawdone
endif

  ; Check to see if we've drawn all the source bytes
  LDA zidx1:CMP ztmp3:BEQ done
  JMP loop

.done
  ; Page room data back in after drawing sprite
  PAGE_ROOMDATA

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
  NOP:NOP ; 0 - Normal
  ORA (zptr2), Y ; 1 - OR
  EOR (zptr2), Y ; 2 - Exclusive OR
}

.drawfullroom
{
  LDA roomno

  ; Set up pointer to data for this room
  ASL A:TAY
  LDA roomtable, Y:STA roomptr
  LDA roomtable+1, Y:STA roomptr+1

  ; Set up pointer to data for next room
  LDA roomtable+2, Y:STA nextroomptr
  LDA roomtable+3, Y:STA nextroomptr+1

  ; If this is an empty room, then stop now
  LDA roomptr+1:CMP nextroomptr+1:BNE roomok
  LDA roomptr:CMP nextroomptr:BNE roomok

  ; Set roomlen to empty
  LDA #&00:STA roomlen:STA roomlen+1

  RTS

.roomok
  ; Determine room length
  SEC
  LDA nextroomptr:SBC roomptr:STA roomlen
  LDA nextroomptr+1:SBC roomptr+1:STA roomlen+1

  ; Add offset
  CLC
  LDA roomptr+1:ADC #hi(ROMSBASE):STA roomptr+1 ; Adjust to point to SWR
  LDA roomptr:ADC roomlen:STA nextroomptr
  LDA roomptr+1:ADC roomlen+1:STA nextroomptr+1

  ; Set up defaults
  LDA #&00:STA frmattri:STA ztmp6

  ; Skip attributes
  TAY
  LDA (roomptr), Y:STA zptr6:INY:PHA
  LDA (roomptr), Y:STA zptr6+1

  CLC
  PLA:ADC roomptr:STA roomptr
  LDA zptr6+1:ADC roomptr+1:STA roomptr+1

  LDY #&00

.thinglp
  LDA (roomptr), Y:STA frmno:INY
  LDA (roomptr), Y:STA frmx:INY
  LDA (roomptr), Y:STA frmy:INY

  ; When frmx top-bit not set, then also update attrib
  LDA frmx:BMI sameattrib
  LDA (roomptr), Y:STA frmattri:INY
.sameattrib

  ; All the data has been read for this frame, so draw it
  JSR frame

  ; ... and fill in solidity bitmap
  JSR plotattris

  TYA:PHA

  ; Check for water
  LDA frmno
  CMP #SPR_WATER:BNE checkflame

  JSR addtowater

  ; Check for flame
.checkflame
  LDA frmno
  CMP #SPR_FLAME:BNE otherobj

  JSR addtoflame

.otherobj

  ; Advance room pointer to next tile
  PLA:CLC:ADC roomptr:STA roomptr
  BCC samepage
  INC roomptr+1
.samepage

  ; Check if we're done
  LDY #&00
  LDA roomptr+1:CMP nextroomptr+1:BNE thinglp
  LDA roomptr:CMP nextroomptr:BNE thinglp

.done
  RTS
}

.putcoinsinroom
{
  LDX #&00
.loop
  STX ztmp6:TXA:ASL A:CLC:ADC ztmp6:TAY ; Y = X*3

  ; Is current coin in current room
  LDA cointable+2, Y:CMP roomno:BNE nextcoin

  LDA #SPR_COIN:STA frmno ; Coin frame
  LDA #PAL_WHITE+ATTR_NOTSOLID:STA frmattri
  LDA cointable, Y:STA frmx
  LDA cointable+1, Y:STA frmy

  ; Draw coin
  JSR frame

  ; ... and fill in solidity bitmap
  JSR plotattris

.nextcoin

  INX:CPX #totalcoins:BNE loop

  RTS
}

.printroomname
{
  ; Set pen colour and position cursor
  LDA #hi(readytoprintname):STA zptr5+1
  LDA #lo(readytoprintname):STA zptr5
  JSR prtmessage

  ; Set pointer to room name
  LDA #STR_roomname:JSR findroomstr
  JMP prtmessage


.readytoprintname
  EQUB PRT_PEN+4,PRT_XY+12,24
  EQUB PRT_END
}

.windowrou
{
  LDA #&01:STA dontupdatedizzy ; Stop Dizzy being drawn
  JSR prtmessage

.^windowrou2
  JSR handoffandwait ; Wait for new key press
.^windowrou1
  JSR resetuproom ; Draw the room again

  LDA #&00:STA dontupdatedizzy ; Allow Dizzy to be drawn

  RTS
}

.printandwait
{
  JSR prtmessage
  ; Fall through ...
}

; Wait until nothing pressed, then wait for something to be pressed
.handoffandwait
{
  LDA keys:BNE handoffandwait

.waitforkey
  LDA keys:BEQ waitforkey

  RTS
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

if allowupsidedown = 1
  ; Cache upsidedown state
  LDA upsidedown:PHA
endif

  ; Disable clipping so we can print room name, lives and coin counts
  LDA #&00:STA cliptoplayarea

if allowupsidedown = 1
  STA upsidedown ; Also force upsidedown off
endif

  LDY #&00

.prtmessage1
  LDA (zptr5), Y:INY

  ; Is it the end of the message
  BNE notdone
  JMP done
.notdone

  ; Is it a change of X/Y
  CMP #PRT_XY:BCS changexy

  ; Anything else above control codes must be a character
  CMP #' ':BCS mustbechar

  ; Is it a pen change
  CMP #PRT_PEN:BCS changepen

  ; Is it a plot type change
  CMP #PRT_PLOT:BEQ changeplot

  ; Is it a gosub
  CMP #PRT_GOSUB:BEQ gosub

  ; Is it a box drawing command
  CMP #PRT_DRAWBOX:BEQ drawboxjmp

  ; Is it a nop (skip)
  CMP #PRT_NR:BEQ noprou

  ; Is it a start repeat
  CMP #PRT_REP:BEQ repeat

  ; Is it an end repeat
  CMP #PRT_ENDREP:BEQ endrepeatjmp

  ; Anything else is not supported at this time
  JMP done

.drawboxjmp
  JMP drawboxrou

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.endrepeatjmp
  JMP endrepeat

  ; Byte in A must be a char, so print it at cursor position
.mustbechar
  STA frmno
  LDA messx:CLC:ADC #&20:STA frmx
  LDA messy:STA frmy
  LDA messpen:STA frmattri
  LDA messplot:STA frmplot
  JSR frame
.noprou
  LDA messx:CLC:ADC #&02:STA messx ; Advance cursor
  JMP prtmessage1

  ; Change the X/Y position
.changexy
  STA messx
  LDA (zptr5), Y:STA messy:INY
  JMP prtmessage1

  ; Change pen
.changepen
  AND #&07:STA messpen
  JMP prtmessage1

  ; Change plot type
.changeplot
  LDA (zptr5), Y:STA messplot:INY
  JMP prtmessage1

  ; Gosub - move message pointer to somewhere else, until END, then come back here
  ;   next 2 bytes are 16-bit address to go to
.gosub
  ; Save current address
  LDA zptr5:PHA   ; lo byte
  LDA zptr5+1:PHA ; hi byte
  TYA:PHA         ; offset

  ; Get new address
  LDA (zptr5), Y:INY:PHA ; lo byte
  LDA (zptr5), Y:INY     ; hi byte

  ; Jump to new address
  STA zptr5+1   ; lo byte
  PLA:STA zptr5 ; hi byte
  LDY #&00      ; offset

  ; Print message from new location
  JSR prtmessage1

  ; Continue from where we were (after gosub)
  PLA:TAY:INY:INY  ; offset
  PLA:STA zptr5+1  ; hi byte
  PLA:STA zptr5    ; lo byte

  JMP prtmessage1

  ; Start repeat
.repeat
  LDA (zptr5), Y:STA printloops:INY ; Save count
  LDA printloops:BEQ noloop ; Loop counter is zero, so don't loop
  STY printidx ; Save where to loop to
  JMP prtmessage1

.noloop
  LDA (zptr5), Y:INY
  CMP #PRT_ENDREP:BNE noloop
  JMP prtmessage1

  ; End repeat
.endrepeat
  DEC printloops:LDA printloops
  BEQ loopstop
  LDY printidx
.loopstop
  JMP prtmessage1

.drawboxrou
  ; Draw a box from messx,messy with messwidth,messheight
  ;
  ;   44          44
  ;42 46 40 40 40 46 43
  ;   41          41
  ;   41          41
  ;   41          41
  ;42 46 40 40 40 46 43
  ;   45          45
 
 if allowsndfx = 1

  LDA #6:STA sndfx

 endif

  LDA #10:STA usepickup

  LDA #&00
  STA pickup:STA frmplot:STA frmreverse

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
  LDA #SPR_FRAMECROSS:BNE dodraw ; Intersection

.ch1
  ; Check for left edge
  CPX #01:BNE ch2 ; Is it the left edge
  CPY #00:BNE ch1b ; Is it the top edge
  LDA #SPR_FRAMETOP:BNE dodraw ; Top of vertical bar
.ch1b
  CPY ztmp6:BCC ch1c ; Is it the bottom edge
  LDA #SPR_FRAMEBOTTOM:BNE dodraw ; Bottom of vertical bar
.ch1c
  LDA #SPR_FRAMEVERT:BNE dodraw ; Vertical bar

.ch2
  ; Check for right edge
  CPX ztmp5:BNE ch3 ; Is it the right edge
  CPY #00:BNE ch2b ; Is it the top edge
  LDA #SPR_FRAMETOP:BNE dodraw ; Top of vertical bar
.ch2b
  CPY ztmp6:BCC ch2c ; Is it the bottom edge
  LDA #SPR_FRAMEBOTTOM:BNE dodraw ; Bottom of vertical bar
.ch2c
  LDA #SPR_FRAMEVERT:BNE dodraw ; Vertical bar

.ch3
  ; Check for top edge
  CPY #01:BNE ch4 ; Is it the top edge
  CPX #00:BNE ch3b; Is it the left edge
  LDA #SPR_FRAMELEFT:BNE dodraw ; Left horizontal bar
.ch3b
  CPX ztmp5:BCC ch3c; Is it the right edge
  LDA #SPR_FRAMERIGHT:BNE dodraw
.ch3c
  LDA #SPR_FRAMEHORIZ:BNE dodraw ; Horizontal bar

.ch4
  ; Check for bottom edge
  CPY ztmp6:BNE ch5
  CPX #00:BNE ch4b; Is it the left edge
  LDA #SPR_FRAMELEFT:BNE dodraw ; Left horizontal bar
.ch4b
  CPX ztmp5:BCC ch4c; Is it the right edge
  LDA #SPR_FRAMERIGHT:BNE dodraw
.ch4c
  LDA #SPR_FRAMEHORIZ:BNE dodraw ; Horiztonal bar

.dodraw
  STA frmno:JSR frame

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
  JMP prtmessage1

.done
  LDA #&01:STA cliptoplayarea

if allowupsidedown = 1
  ; Restore upsidedown state
  PLA:STA upsidedown
endif

  RTS

; Message variables
.^messx
  EQUB 0
.^messy
  EQUB 0
.^messpen
  EQUB 0
.messplot
  EQUB 0

.messwidth
  EQUB 0
.messheight
  EQUB 0
}

; Dizzy animation frames
.seq0 EQUB 0,1,0,1,0,1,0,1 ; Looking forward idle
.seq1 EQUB 9,10,11,12,13,14,15,16 ; Walking left
.seq2 EQUB 17,18,19,20,21,22,23,24 ; Walking right
.seq3 EQUB 2,3,4,5,6,7,8,1 ; Jumping/tumbling straight up/down
.seq4 EQUB 25,26,27,28,29,30,31,9 ; Jump/tumble left
.seq5 EQUB 32,33,34,35,36,37,38,17 ; Jump/tumble right
.seq6 EQUB 4,5,5,6,6,5,5,4; bob upside down
.seq7 EQUB 0,1,8,8,7,6,7,7; fall over backwards
.seq8 EQUB 8,7,6,5,4,3,2,1; upside down tumble

; Clear attribute table (used for solidity)
.clearattris
{
  LDA #0

  LDY #attrisize
.loop
  STA attritable, Y
  DEY
  BPL loop

  RTS
}

; Plot a shape onto the attribute table
; uses frmx, frmy, frmwidth, frmheight and frmattri
;
; Attribute table, used for hit-detection on 8x8 grid of screen
; 256x136 = 32x17 blocks = 4x17 bytes
.plotattris
{
  ; Save registers
  PHA
  TXA:PHA
  TYA:PHA

  ; Set dest pointer
  LDA #hi(attritable):STA zptr2+1
  LDA #lo(attritable):STA zptr2

  ; Find out if this shape is solid or not
  LDA frmattri:AND #ATTR_NOTSOLID:BNE notsolid
  LDA #&00
.notsolid
  STA columnloop+1

  ; Calculate width in blocks (rounded up)
  LDA frmwidth:LSR A:ADC #&00:STA bwidth

  ; Calculate height in blocks (rounded up)
  LDA frmheight:LSR A:LSR A:LSR A:ADC #&00:STA bheight

  ; Calculate first row
  LDA frmy
  LSR A:LSR A:LSR A ; A /= 8 (8 pixel high blocks)
  STA fymax
  SEC:SBC #6 ; A -= 6 (attritable ignores top header)
  BPL notopclip
  LDA #&00 ; Clip to top
.notopclip
  STA fymin

  ; Set starting offset
  ASL A:ASL A ; Determine byte offset for start of row
  STA zptr2

  ; Calculate last row
  LDA fymax:CLC:ADC bheight
  SEC:SBC #6 ; A -= 6 (attritable ignores top header)
  CMP #17:BCC nobotclip
  LDA #16 ; Clip to bottom
.nobotclip
  STA fymax

  ; Calculate first column (bit position 0..31)
  LDA frmx:AND #&7F
  STA fxmax
  CMP #34:BCS noleftclip
  LDA #34 ; Clip to left
.noleftclip
  SEC:SBC #32
  LSR A
  STA fxmin

  ; Calculate last column
  LDA fxmax
  SEC:SBC #32
  LSR A
  CLC:ADC bwidth
  CMP #32:BCC norightclip
  LDA #31 ; Clip to right
.norightclip
  STA fxmax

  ; Calculate starting bit pattern
  LDA fxmin:AND #&07
  TAY:LDA bitpattern, Y
  STA bits

  ; Row loop
  LDX fymin
.rowloop
  ; Move to starting byte on this row
  LDA fxmin:LSR A:LSR A:LSR A
  CLC:ADC zptr2:STA zptr2

  ; Column loop
  TXA:PHA ; Cache row
  LDX fxmin

  LDY #&00
.columnloop
  
  LDA #&00:BNE makeclear
  LDA bits
  ORA (zptr2), Y
  STA (zptr2), Y
  LDA #&00:BEQ setdone
.makeclear
  LDA bits:EOR #&FF
  AND (zptr2), Y
  STA (zptr2), Y
.setdone

  LDA bits ; Move to next bit
  LSR A
  BNE samebyte
  INC zptr2 ; Move to next byte
  LDA bitpattern
.samebyte
  STA bits

  INX
  CPX fxmax:BCC columnloop

  ; Move to start of next row down
  PLA:PHA:CLC:ADC #&01:ASL A:ASL A
  STA zptr2

  ; Calculate starting bit pattern
  LDA fxmin:AND #&07
  TAY:LDA bitpattern, Y
  STA bits

  PLA:TAX ; Restore row
  INX
  CPX fymax:BCC rowloop

  ; Restore registers
  PLA:TAY
  PLA:TAX
  PLA

  RTS

.bwidth
  EQUB &00
.bheight
  EQUB &00

.fymin
  EQUB &00
.fymax
  EQUB &00

.fxmin
  EQUB &00
.fxmax
  EQUB &00

.bits
  EQUB &00
}

; 1 set bit shifted down
.bitpattern
  EQUB &80, &40, &20, &10, &08, &04, &02, &01

; Protects and exit when next flyback (vsync) occurs
; interrupts must be enabled
.flyback
{
  ; Save A/B regs
  PHA
  LDA z80breg:PHA

  ; Wait until vsync by seeing when clock value (incremented in vsync) changes
  LDA clock:STA z80breg

.flybacklp
  LDA clock:CMP z80breg:BEQ flybacklp

  ; Restore A/B regs
  PLA:STA z80breg
  PLA

  RTS
}

; Store z80 registers into sprite variables
;
; IN a=frmno, c=frmattri, b=frmplot/frmreverse, e=frmx, l=frmy
.store_sprite_vars
{
  STA z80hreg ; Cache frmno

  LDA z80creg:STA frmattri
  LDA z80breg:AND #&03:STA frmplot
  LDA z80breg:PHA:ASL A:PLA:ROL A:AND #&01:STA frmreverse

  LDA z80hreg ; Restore frmno

.^store_sprite_vars1
  STA frmno
  LDA z80ereg:STA frmx
  LDA z80lreg:STA frmy

  ; Fall through
}

.findfrmsize
{
  ; TODO

  RTS
}

; Lookup table for start of each line of the screen in memory
;
; high bytes are : 50,50,50,50,50,50,50,50 52,52,52,52,52,52,52,52...
;  low bytes are : 00,01,02,03,04,05,06,07 00,01,02,03,04,05,06,07...
ALIGN &100
.screentable_hi
{
  FOR n, 0, (MAXY/8)-1
    FOR m, 0, 7
      EQUB HI((MODE8BASE)+(n*512)+m)
    NEXT
  NEXT
}
ALIGN &100
.screentable_lo
{
  FOR n, 0, (MAXY/8)-1
    FOR m, 0, 7
      EQUB LO((MODE8BASE)+(n*512)+m)
    NEXT
  NEXT
}
