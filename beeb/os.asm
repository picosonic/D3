; OS function vectors

USERV = &0200 ; User vector, called by *LINE, *CODE, OSWORD >=&E0
BRKV  = &0202 ; The BRK vector
IRQ1V = &0204 ; Main interrupt vector
IRQ2V = &0206 ; Secondary interrupt vector
CLIV  = &0208 ; Command Line Interpreter vector
BYTEV = &020A ; OSBYTE (*FX) calls
WORDV = &020C ; OSWORD calls
WRCHV = &020E ; Send character to current output stream
RDCHV = &0210 ; Wait for a character from current input stream
FILEV = &0212 ; Operate on a whole file, eg loading/saving/delete/etc
ARGSV = &0214 ; Read/Write arguments on an open file
BGETV = &0216 ; Read a byte from an open file
BPUTV = &0218 ; Write a byte to an open file
GBPBV = &021A ; Read/Write block of data from/to open file or device
FINDV = &021C ; Open or close a file
FSCV  = &021E ; Various filing system control calls
EVNTV = &0220 ; Event handler
UPTV  = &0222 ; User Print vector
NETV  = &0224 ; Network Print vector
VDUV  = &0226 ; Unrecognised VDU commands
KEYV  = &0228 ; Read the keyboard
INSBV = &022A ; Insert characters into a buffer
REMVB = &022C ; Remove characters from a buffer
CNPV  = &022E ; Count or Purge a buffer
IND1V = &0230 ; Spare
IND2V = &0232 ; Spare
IND3V = &0234 ; Spare                   &0234/5 nULA support: old BYTEV

; OS memory locations
ZEROPAGE = &00 ; Start of zero page
ZP_ECONET_WORKSPACE = &90 ; Econet private workspace at &90-&9F

ROMSEL_CACHE = &F4 ; OS cache of ROMSEL value

VDU_VARS = &300 ; VDU Variables at &0300-&037F
LANGUAGE_WORKSPACE = &400 ; Current Language Workspace at &400-&7FF
SOUND_WORKSPACE = &800 ; Sound workspace at &800-&83F
SOUND_BUFFERS = &840 ; Sound buffers at &840-&87F
PRINTER_BUFFER = &880 ; Printer buffer at &880-&8BF
ENVELOPE_DEFS = &8C0 ; Envelope 1 to 4 definitions at &8C0-&8FF
SERIAL_OUT_BUFFER = &900 ; RS423 output buffer at &900-&9BF
ENVELOPE_DEFS2 = &900 ; Envelope 5 to 16 definitions at &900-&9BF
SPEECH_BUFFER = &9C0 ; Speech buffer at &09C0-&09FF
SERIAL_IN_BUFFER = &A00 ; Serial input, transient command buffer at &0A00-&0AFF
SOFT_KEY_DEFS = &B00 ; BBC, Electron: Soft key (function) definitions at &0B00-&0BFF
ECONET_WORKSPACE = &B00 ; Master : Econet workspace at &0B00-&0BFF
CHAR_DEFS = &C00 ; BBC, Electron: Font for ASCII 128-159 at &0C00-&0CFF
ECONET_WORKSPACE2 = &C00 ; Master: Econet workspace - open receive blocks at &0C00-&0CFF
NMI_WORKSPACE = &D00 ; NMI and ROM workspace at &0D00-&0DFF

; DFS memory locations
DFS_CAT_SEC0 = &E00 ; Catalogue filenames - disk sector 0
DFS_CAT_SEC1 = &F00 ; Catalogue addresses - disk sector 1
DFS_WORKSPACE = &1000 ; General disc workspace at &1000-&10FF
DFS_OPEN_FILES = &1100 ; Open files information
DFS_OPEN_FILE_BUFFERS = &1200 ; Open file buffers
DFS_OPEN_FILE_BUFFER1 = &1200 ; First file buffer
DFS_OPEN_FILE_BUFFER2 = &1300 ; Second file buffer
DFS_OPEN_FILE_BUFFER3 = &1400 ; Third file buffer
DFS_OPEN_FILE_BUFFER4 = &1500 ; Fourth file buffer
DFS_OPEN_FILE_BUFFER5 = &1600 ; Fifth file buffer
DFS_WORKSPACE2 = &1700 ; DFS or USER workspace
DFS_WORKSPACE3 = &1800 ; DFS or USER workspace
DFS_PAGE = &1900 ; With no other sideways ROMs claiming workspace, PAGE will be &1900 when DFS is active
; Note : PAGE can be dropped to &E00 if no filing system access is needed
;
;   Deselect DFS and disable NMIs with :
;
;     *TAPE
;     *FX143,13,255

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

NMI_VECTOR = &FFFA
BREAK_VECTOR = &FFFC
IRQ_VECTOR = &FFFE

; System hardware
STACK = &100 ; 6502 hardware stack from &100 to &1FF, fills from the top downwards

FREDBASE = &FC00 ; memory mapped hardware

JIMBASE = &FD00 ; 64K paged memory

SHEILABASE = &FE00 ; system peripherals
; 6845 CRTC - Video controller
CRTC00 = SHEILABASE+&00 ; address register (5 bit)
CRTC01 = SHEILABASE+&01 ; data register
; 6850 ACIA - Serial controller
ACIA08 = SHEILABASE+&08 ; Control / Status
ACIA09 = SHEILABASE+&09 ; Data
; Serial ULA
; Video ULA
ULA_VID20 = SHEILABASE+&20 ; video control register
ULA_VID21 = SHEILABASE+&21 ; colour palette
ULA_VID22 = SHEILABASE+&22 ; border control
ULA_VID23 = SHEILABASE+&23 ; 24-bit palette selection
; Paged ROM/RAM selector
ROMSEL = SHEILABASE+&30 ; paged ROM select (4 bit)
RAMSEL = SHEILABASE+&32 ; paged RAM select
; 6522 - System VIA
SYSVIA_REGB = SHEILABASE+&40 ; Port B I/O
SYSVIA_ORB = SYSVIA_REGB
SYSVIA_IRB = SYSVIA_REGB
SYSVIA_REGA = SHEILABASE+&41 ; Slow data bus - keyboard/sound/speech - Port A I/O
SYSVIA_ORA = SYSVIA_REGA
SYSVIA_IRA = SYSVIA_REGA
SYSVIA_DDRB = SHEILABASE+&42 ; Data direction register B
SYSVIA_DDRA = SHEILABASE+&43 ; Data direction register A
SYSVIA_T1CL = SHEILABASE+&44 ; Timer 1 low order latch / counter
SYSVIA_T1CH = SHEILABASE+&45 ; Timer 1 high order counter
SYSVIA_T1LL = SHEILABASE+&46 ; Timer 1 low order latch
SYSVIA_T1LH = SHEILABASE+&47 ; Timer 1 high order latch
SYSVIA_T2CL = SHEILABASE+&48 ; Timer 2 low order latch / counter
SYSVIA_T2CH = SHEILABASE+&49 ; Timer 2 high order counter
SYSVIA_SR = SHEILABASE+&4A ; Shift register
SYSVIA_ACR = SHEILABASE+&4B ; Auxilary control register
SYSVIA_PCR = SHEILABASE+&4C ; Peripheral control register
SYSVIA_IFR = SHEILABASE+&4D ; Interrupt flag register
SYSVIA_IER = SHEILABASE+&4E ; Interrupt enable register
SYSVIA_ORAS = SHEILABASE+&4F ; Same as REGA but with no handshake I/O
; 6522 - User/Printer VIA
USERVIA_REGB = SHEILABASE+&60 ; User port B I/O
USERVIA_ORB = USERVIA_REGB
USERVIA_IRB = USERVIA_REGB
USERVIA_REGA = SHEILABASE+&61 ; Printer port A I/O
USERVIA_ORA = USERVIA_REGA
USERVIA_IRA = USERVIA_REGA
USERVIA_DDRB = SHEILABASE+&62 ; Data direction register B
USERVIA_DDRA = SHEILABASE+&63 ; Data direction register A
USERVIA_T1CL = SHEILABASE+&64 ; Timer 1 low order latch / counter
USERVIA_T1CH = SHEILABASE+&65 ; Timer 1 high order counter
USERVIA_T1LL = SHEILABASE+&66 ; Timer 1 low order latch
USERVIA_T1LH = SHEILABASE+&67 ; Timer 1 high order latch
USERVIA_T2CL = SHEILABASE+&68 ; Timer 2 low order latch / counter
USERVIA_T2CH = SHEILABASE+&69 ; Timer 2 high order counter
USERVIA_SR = SHEILABASE+&6A ; Shift register
USERVIA_ACR = SHEILABASE+&6B ; Auxilary control register
USERVIA_PCR = SHEILABASE+&6C ; Peripheral control register
USERVIA_IFR = SHEILABASE+&6D ; Interrupt flag register
USERVIA_IER = SHEILABASE+&6E ; Interrupt enable register
USERVIA_ORAS = SHEILABASE+&6F ; Same as REGA but with no handshake I/O
; 8271 - FDC / 1770 - FDC
FDC_STATUS = SHEILABASE+&80
FDC_RESULT = SHEILABASE+&81
FDC_COMMAND = SHEILABASE+&80
FDC_PARAM = SHEILABASE+&81
FDC_RESET = SHEILABASE+&82
FDC_DATA = SHEILABASE+&84
; 68B54 - ADLC Econet controller
; uPD7002 - Analogue-to-digital converter
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
OSBASE = &C000

; OSFIND open modes
OPENIN = &40
OPENOUT = &80
OPENINOUT = &C0

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
