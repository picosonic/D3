; Zero page variables

ORG &0000
GUARD &0090

.zpstart

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

.zpend

; ---------------------------------------------------------
; Variables in LANGUAGE workspace, &400 to &7FF

ORG &0400
GUARD &0800

.start_of_vars

EQUB 0 ; Placeholder

.end_of_vars

; ---------------------------------------------------------
; Variables in printer buffer workspace, &880 to &8BF

ORG &0880
GUARD &08C0

; ---------------------------------------------------------
; Variables, &E00 to MAIN_LOAD_ADDR

ORG &E00
