ORG &00

INCLUDE "os.asm"
INCLUDE "consts.asm"

.framedefs_start
INCBIN "framedefs.bin"
.framedefs_end

INCLUDE "dizzyfrm.asm"

SAVE "XTABLE", dizzytable_start, dizzytable_end
SAVE "XDATA", framedefs_start, dizzyframe_end