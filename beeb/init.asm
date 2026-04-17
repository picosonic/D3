  ; Make sure we are not in decimal mode
  CLD

  ; Initialisation
  ;LDA #OSB_STAR_TAPE:LDX #&0C:JSR OSBYTE ; Select TAPE filing system with 1200 baud (to turn off DFS)
  LDA #OSB_FLUSH_BUFFERS:LDX #&00:JSR OSBYTE ; Flush all buffers
  LDA #OSB_KEYBOARD_STATUS:LDX #&01:LDY #&00:JSR OSBYTE ; Kbd irqs off!
  LDA #OSB_CURSOR_EDITING:LDX #&01:JSR OSBYTE ; Disable cursor editing
  LDA #&1A:JSR OSWRCH ; Remove text window (tape needs this!)
  LDA #OSB_PAGE_ROM_REQ:LDX #&0C:LDY #&FF:JSR OSBYTE ; Disable NMIs to claim absolute workspace (&E00)

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

  ; Set up vsync event handler
  LDA #eventhandler MOD 256:STA EVNTV
  LDA #eventhandler DIV 256:STA EVNTV+1

  CLI

  ; Enable vsync event handler
  LDX #EV_VSYNC
  LDA #OSB_ENABLE_EVENTS
  JSR OSBYTE

  ; Clear variables in language workspace
  LDX #&00
.clearvars
  STA LANGUAGE_WORKSPACE,X
  STA LANGUAGE_WORKSPACE+&100,X
  STA LANGUAGE_WORKSPACE+&200,X
  STA LANGUAGE_WORKSPACE+&300,X
  INX:BNE clearvars
