; Zero page variables

ORG &0000
GUARD &0090

.zptr1 EQUW 0
.zidx1 EQUB 0

.zptr2 EQUW 0
.zidx2 EQUB 0

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

.zpend

; ---------------------------------------------------------
; Variables in LANGUAGE workspace, &400 to &7FF

ORG &0400
GUARD &0800

.end_of_vars

; ---------------------------------------------------------
; Variables in printer buffer workspace, &880 to &8BF

ORG &880
GUARD &08C0

; ---------------------------------------------------------
; Variables, &E00 to MAIN_LOAD_ADDR

ORG &E00