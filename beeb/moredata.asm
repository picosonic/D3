ORG &00

INCLUDE "os.asm"
INCLUDE "consts.asm"

.moredata_start

INCLUDE "dizzyfrm.asm"

.moredata_end

SAVE "XDATA", moredata_start, moredata_end