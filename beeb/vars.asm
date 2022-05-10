; Zero page variables

ORG &0000
GUARD &0090

EQUB &00 ; Placeholder

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
; Variables, &E00 to &1900

ORG &E00
GUARD &18FF