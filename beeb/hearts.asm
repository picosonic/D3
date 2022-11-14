; The heart demo

.heartdemo
{
  JSR resethearts

  ; TODO
.allhearts
  ; TODO

  RTS
}

.resethearts
{
  ; TODO

  RTS
}

.updatehearts
{
  ; TODO

  RTS
}

.printheart
{
  ; TODO
.addpatch
  ; TODO

  RTS
}

.getvalue
{
  ; TODO
.waspos
  ; TODO

  RTS
}

; A=0..127
; return A=-64 to 64
.getsincos
{
  ; TODO
  RTS

.sincostable
  EQUB 0, 6,12,18,24,30,35,40,45,49,53,56,59,61,62,63  ; quad 0
  EQUB 64,63,62,61,59,56,53,49,45,40,35,30,24,18,12, 6  ; quad 1
  EQUB -0,-6,-12,-18,-24,-30,-35,-40,-45,-49,-53,-56,-59,-61,-62,-63  ; quad 2
  EQUB -64,-63,-62,-61,-59,-56,-53,-49,-45,-40,-35,-30,-24,-18,-12,-6  ; quad 3
}

.multiply
{
  ; TODO

  RTS
}