; Wait for vertical trace
.waitvsync
{
  TXA:PHA

  LDA #&13
  JSR OSBYTE

  PLA:TAX

  RTS
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

.^cpdone
  RTS
}

; widths 8/16/24/32/40/48/80, mostly 16/8/24/32
; heights 2..45, mostly 8/16/24

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

  ; Get offset to frame data
  LDA #hi(frametable):STA zptr2+1
  LDA #lo(frametable):STA zptr2

  LDA frmno
  BPL nochange
  INC zptr2+1
.nochange
  ASL A:TAY

  INY:LDA (zptr2), Y
  CMP #&FF:BEQ cpdone ; Don't draw NULL frames
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

  LDA zidx2:CLC:ADC #&08:STA zidx2 ; Advance to next block on the right

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
  LDA zidx1
  CMP ztmp3
  BNE loop

.done
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
  JSR clearplayarea

  LDA #&00:STA frmattri:STA ztmp6

  TAY
.loop
  LDA room0, Y:STA frmno:INY
  LDA room0, Y:STA frmx:INY
  LDA room0, Y:STA frmy:INY

  ; When frmx top-bit not set, then also update attrib
  LDA frmx:BMI sameattrib
  LDA room0, Y:STA frmattri:INY
.sameattrib

  STY ztmp6
  JSR drawframe
  LDY ztmp6
  CPY #(dataend-room0)
  BCC loop

.done
  RTS
}
