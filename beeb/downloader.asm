; This does some initial setup and relocates main code to maximise RAM use
;
; Uses some ideas seen in Crazee Rider BBC Micro source (by Kevin Edwards)
;   https://github.com/KevEdwards/CrazeeRiderBBC

; OS defines
INCLUDE "os.asm"
INCLUDE "consts.asm"

ORG DOWNLOADER_ADDR

  ; Make sure we are not in decimal mode
  CLD

  ; Initialisation
  LDA #&8C:LDX #&0C:JSR OSBYTE ; Select TAPE filing system with 1200 baud (to turn off DFS)
  LDA #&0F:LDX #&00:JSR OSBYTE ; Flush all buffers
  LDA #&C9:LDX #&01:LDY #&00:JSR OSBYTE ; Kbd irqs off!
  LDA #&04:LDX #&01:JSR OSBYTE ; Disable cursor editing
  LDA #&1A:JSR OSWRCH ; Remove text window (tape needs this!)
  LDA #&8F:LDX #&0C:LDY #&FF:JSR OSBYTE ; Disable NMIs to claim absolute workspace (&E00)

  SEI

  ; Clear page ROM type table
  LDX #&0F:LDA #&00
.zaproms
  STA &2A1,X:DEX:BPL zaproms
 
  ; Clear zero page
  LDX #ZP_ECONET_WORKSPACE-1
.clearzp
  STA 0,X:DEX:BNE clearzp
  STA 0

  LDX #&FF:TXS ; Clear stack

  CLI

  ; Clear variables in language workspace
.clearvars
  STA LANGUAGE_WORKSPACE,X
  STA LANGUAGE_WORKSPACE+&100,X
  STA LANGUAGE_WORKSPACE+&200,X
  STA LANGUAGE_WORKSPACE+&300,X
  INX:BNE clearvars

  LDX #&00
  LDY #HI(MODE8BASE-MAIN_RELOC_ADDR) ; MAX program length in pages
.relocate
  LDA MAIN_LOAD_ADDR,X:STA MAIN_RELOC_ADDR,X
  INX:BNE relocate
  INC relocate+2
  INC relocate+5
  DEY:BNE relocate

  ; Start game running
  JMP MAIN_RELOC_ADDR+&2200 ; Main entry point following relocation

PRINT "Saving downloader from ", ~DOWNLOADER_ADDR, " to ", ~P%
SAVE "DOWNLOADER", DOWNLOADER_ADDR, P%