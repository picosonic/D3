; OS defines
INCLUDE "os.asm"

; Variable and constant defines
INCLUDE "consts.asm"

; Zero page vars
ORG &50

INCLUDE "exomizer310decruncher.h.asm"

ORG EXO_LOAD_ADDR

.start
{
  ; Set displayed chars per horizontal line (64) to match Spectrum (256 pixels)
  LDA #&01:STA CRTC00
  LDA #&40:STA CRTC01

  ; Shift display horizontally to centre (in char widths from left)
  LDA #&02:STA CRTC00
  LDA #&59:STA CRTC01

  ; Set displayed chars per column (24) to match Spectrum (192 pixels)
  LDA #&06:STA CRTC00
  LDA #&18:STA CRTC01

  ; Shift display vertically to centre
  LDA #&07:STA CRTC00
  LDA #&1F:STA CRTC01

	; Turn off interlace and cursor
	LDA #&08:STA CRTC00
	LDA #&C0:STA CRTC01

  ; Change screen start to &4800 to gain an extra 6k bytes
  LDA #&0D:STA CRTC00
  LDA #(MODE8BASE) MOD 256:STA CRTC01
  LDA #&0C:STA CRTC00
  LDA #(MODE8BASE) DIV 256:LSR A:LSR A:LSR A:STA CRTC01

  JSR exo_loader

  ; Back to OS
  RTS
}

.exo_loader
{
  LDX #lo(xscr)
  LDY #hi(xscr)
  LDA #hi(MODE8BASE)

  jsr decrunch_to_page_A

  RTS
}

include "exomizer310decruncher.asm"

.xscr
INCBIN "XSCR"
.end

SAVE "EXOSCR", start, end
