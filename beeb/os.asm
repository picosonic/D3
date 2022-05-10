; OS function vectors

USERV = &0200
BRKV = &0202
IRQ1V = &0204
IRQ2V = &0206
CLIV = &0208
BYTEV = &020A
WORDV = &020C
WRCHV = &020E
RDCHV = &0210
FILEV = &0212
ARGSV = &0214
BGETV = &0216
BPUTV = &0218
GBPBV = &021A
FINDV = &021C
FSCV = &021E
EVNTV = &0220
UPTV = &0222
NETV = &0224
VDUV = &0226
KEYV = &0228
INSBV = &022A
REMVB = &022C
CNPV = &022E
IND1V = &0230
IND2V = &0232
IND3V = &0234

; OS memory locations
ZP_ECONET_WORKSPACE = &90
LANGUAGE_WORKSPACE = &400
SOUND_WORKSPACE = &800
NMI_WORKSPACE = &D00

; OS function call locations

OSFSC  = &F1B1 ; filing system control (entry via FSCV)

OSWRSC = &FFB3 ; write byte to screen
OSRDSC = &FFB9 ; read byte from screen

OSNULL = &FFA6 ; blank function handler (just an RTS)

VDUCHR = &FFBC ; VDU character output
OSEVEN = &FFBF ; generate an EVENT
GSINIT = &FFC2 ; initialise OS string
GSREAD = &FFC5 ; read character from input stream
NVRDCH = &FFC8 ; non vectored OSRDCH
NVWRCH = &FFCB ; non vectored OSWRCH
OSFIND = &FFCE ; open or close a file
OSGBPB = &FFD1 ; transfer block to or from a file (get block / put block)
OSBPUT = &FFD4 ; save a byte to file
OSBGET = &FFD7 ; get a byte from file
OSARGS = &FFDA ; read or write file attributes
OSFILE = &FFDD ; read or write a complete file
OSRDCH = &FFE0 ; get a byte from current input stream
OSASCI = &FFE3 ; output a byte to VDU stream expanding CR (&0D) to LF/CR (&0A,&0D)
OSNEWL = &FFE7 ; output a LF/CR to VDU stream
OSWRCH = &FFEE ; output a character to the VDU stream
OSWORD = &FFF1 ; perform operation using parameter table
OSBYTE = &FFF4 ; perform operation on single byte
OSCLI  = &FFF7 ; pass string to command line interpreter

; System hardware

FREDBASE = &FC00 ; memory mapped hardware

JIMBASE = &FD00 ; 64K paged memory

SHEILABASE = &FE00 ; system peripherals
; 6845 CRTC
CRTC00 = SHEILABASE+&00 ; address register (5 bit)
CRTC01 = SHEILABASE+&01 ; data register
; 6850 ACIA
ACIA08 = SHEILABASE+&08 ; Control / Status
ACIA09 = SHEILABASE+&09 ; Data
; Serial ULA
; Video ULA
ULA_VID20 = SHEILABASE+&20 ; video control register
ULA_VID21 = SHEILABASE+&21 ; colour palette
ULA_VID22 = SHEILABASE+&22 ; border control
ULA_VID23 = SHEILABASE+&23 ; 24-bit palette selection
; Paged ROM selector
PAGEROM = SHEILABASE+&30 ; paged ROM select (4 bit)
; 6522 System VIA
SYSVIA_REGB = SHEILABASE+&40
SYSVIA_REGA = SHEILABASE+&41
SYSVIA_DDRB = SHEILABASE+&42
SYSVIA_DDRA = SHEILABASE+&43
; 6522 User/Printer VIA
USERVIA_REGB = SHEILABASE+&60 ; User port
USERVIA_REGA = SHEILABASE+&61 ; Printer port
USERVIA_DDRB = SHEILABASE+&62 ; Data direction register B
USERVIA_DDRA = SHEILABASE+&63 ; Data direction register A
USERVIA_T2CL = SHEILABASE+&68 ; T2 low order counter
USERVIA_T2CH = SHEILABASE+&69 ; T2 high order counter
USERVIA_SR = SHEILABASE+&6A ; Shift register
USERVIA_ACR = SHEILABASE+&6B ; Auxilary control register
USERVIA_PCR = SHEILABASE+&6C ; Peripheral control register
USERVIA_IFR = SHEILABASE+&6D ; Interrupt flag register
USERVIA_IER = SHEILABASE+&6E ; Interrupt enable register
; 8271 FDC
FDC_STATUS = SHEILABASE+&80
FDC_RESULT = SHEILABASE+&81
FDC_COMMAND = SHEILABASE+&80
FDC_PARAM = SHEILABASE+&81
FDC_RESET = SHEILABASE+&82
FDC_DATA = SHEILABASE+&84
; 68B54 Econet
; uPD7002 ADC
; Tube ULA

; Other constants

MODE0BASE = &3000
MODE1BASE = &3000
MODE2BASE = &3000
MODE3BASE = &4000
MODE4BASE = &5800
MODE5BASE = &5800
MODE6BASE = &6000
MODE7BASE = &7C00
ROMSBASE = &8000

; Zero page availibility
; &00 to &6F - available to machine code programs not using BASIC
; &70 to &8F - reserved by BASIC for the user

; Colours in mode 1
;
; Default logical colours :
;
; 0 black (0)
; 1 red (1)
; 2 yellow (3)
; 3 white (7)
;
; Actual colours :
;
; 0 black
; 1 red
; 2 green
; 3 yellow
; 4 blue
; 5 magenta
; 6 cyan
; 7 white