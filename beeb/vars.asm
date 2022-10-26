; Zero page variables

ORG ZEROPAGE
GUARD ZP_ECONET_WORKSPACE

.zpstart

; Input bitfield
.keys EQUB &00

.zptr1 EQUW 0
.zidx1 EQUB 0

.zptr2 EQUW 0
.zidx2 EQUB 0

.zptr3 EQUW 0
.zidx3 EQUB 0

.zptr4 EQUW 0
.zidx4 EQUB 0

.zptr5 EQUW 0
.zidx5 EQUB 0

.zptr6 EQUW 0
.zidx6 EQUB 0

.roomptr EQUW 0
.nextroomptr EQUW 0

.ztmp1 EQUB 0
.ztmp2 EQUB 0
.ztmp3 EQUB 0
.ztmp4 EQUB 0
.ztmp5 EQUB 0
.ztmp6 EQUB 0

; Seed for random number generator
.seed EQUW &0000, &0000

; Frame data
.frmno EQUB 0
.frmx EQUB 0
.frmy EQUB 0
.frmattri EQUB 0
.frmwidth EQUB 0
.frmheight EQUB 0
.frmplot EQUB 0
.frmreverse EQUB 0
.frmlocation EQUW 0
.frmcolour EQUB 0

.roomno EQUB 0 ; Current room
.loadedroomno EQUB 0 ; Last room loaded from disk
.roomlen EQUW 0 ; Length of active roomdata

; Dizzy position
.dizzyx EQUB 0 ; X
.dizzyy EQUB 0 ; Y
.dizzyfrm EQUB 0 ; Frame
.dizzyox EQUB 0 ; Old X
.dizzyoy EQUB 0 ; Old Y
.dizzyofrm EQUB 0 ; Old frame

.zpend

; ---------------------------------------------------------
; Variables in LANGUAGE workspace, &400 to &7FF

ORG LANGUAGE_WORKSPACE
GUARD SOUND_WORKSPACE

.start_of_vars

; Non-zero to clip draw routine to play area
.cliptoplayarea EQUB 0

; Count of collected coins
.coins EQUB 0

.end_of_vars

; ---------------------------------------------------------
; Variables in printer buffer workspace, &880 to &8BF

ORG PRINTER_BUFFER
GUARD ENVELOPE_DEFS
