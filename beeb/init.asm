  ; Make sure we are not in decimal mode
  CLD

  ; Initialisation
  ;LDA #&8C:LDX #&0C:JSR OSBYTE ; Select TAPE filing system with 1200 baud (to turn off DFS)
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

  ; Set up vsync event handler
  LDA #eventhandler MOD 256:STA EVNTV
  LDA #eventhandler DIV 256:STA EVNTV+1

  CLI

  LDA #&0E:LDX #EV_VSYNC:JSR OSBYTE ; Enable vsync event handler

  ; Clear variables in language workspace
  LDX #&00
.clearvars
  STA LANGUAGE_WORKSPACE,X
  STA LANGUAGE_WORKSPACE+&100,X
  STA LANGUAGE_WORKSPACE+&200,X
  STA LANGUAGE_WORKSPACE+&300,X
  INX:BNE clearvars
