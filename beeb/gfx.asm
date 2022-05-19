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
  PHA ; Backup room number

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

  PLA
  
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
  PLA
  BNE playscr
  JSR titlescreen
.playscr

  ; Write the room name
  JSR writeroomname

  ; Show room in game palette
  LDA #PAL_GAME:JSR setpal

  RTS
}

.writeroomname
{
  PHA

  ; Set pen colour and position cursor
  LDA #hi(roomnamepos):STA zptr5+1
  LDA #lo(roomnamepos):STA zptr5
  JSR prtmessage

  ; Set pointer to room name
  PLA:ASL A:TAY
  LDA roomnames, Y:STA zptr5
  LDA roomnames+1, Y:STA zptr5+1
  JSR prtmessage

  RTS

.roomnamepos
  EQUB PRT_PEN+4,PRT_XY+12,24
  EQUB PRT_END
}

.titlescreen
{
  PHA

  LDA #hi(startmess):STA zptr5+1
  LDA #lo(startmess):STA zptr5
  JSR prtmessage

  LDA #58:STA frmx
  LDA #57:STA frmy
  LDA #7:STA frmattri
  LDA #27:STA frmno ; Dizzy logo
  JSR drawframe

  PLA

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
  BEQ done

  ; Is it a change of X/Y
  CMP #PRT_XY:BCS changexy

  ; Anything else above control codes must be a character
  CMP #' ':BCS mustbeachar

  ; Is it a pen change
  CMP #PRT_PEN:BCS changepen

  ; Is it a plot type change
  CMP #PRT_PLOT:BEQ changeplot

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
  LDA (zptr5), Y:STA messy
  INY
  JMP loop

  ; Change pen 
.changepen
  AND #&07:STA messpen
  JMP loop

  ; Change plot type
.changeplot
  LDA (zptr5), Y:STA messplot:INY
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
}