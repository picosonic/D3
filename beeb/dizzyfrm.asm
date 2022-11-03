DIZZY_WIDTH = (3*8)

.dizzytable
EQUW frame00, frame01, frame02, frame03, frame04, frame05, frame06, frame07, frame08
EQUW frame09, frame10, frame11, frame12, frame13, frame14, frame15, frame16, frame17
EQUW frame18, frame19, frame20, frame21, frame22, frame23, frame24, frame25, frame26
EQUW frame27, frame28, frame29, frame30, frame31, frame32, frame33, frame34, frame35
EQUW frame36, frame37, frame38

.frame00
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%01111100,%00000000
EQUB %00000000,%11111110,%00000000
EQUB %00000001,%11111111,%00000000
EQUB %00000001,%10010011,%00000000
EQUB %00000011,%00010001,%10000000
EQUB %00000011,%01010101,%10000000
EQUB %00000011,%00010001,%10000000
EQUB %00000111,%11111111,%11000000
EQUB %00110111,%11111111,%11011000
EQUB %11110111,%01111101,%11011110
EQUB %11110111,%10000011,%11011110
EQUB %11110011,%11101111,%10011110
EQUB %00000011,%11111111,%10000000
EQUB %00000000,%11111110,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%11000111,%00000000
EQUB %00000001,%01000101,%00000000
EQUB %00000010,%11101011,%10000000
EQUB %00000011,%11101111,%10000000
.frame01
EQUB 20,04
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%01111100,%00000000
EQUB %00000000,%11111110,%00000000
EQUB %00000001,%11111111,%00000000
EQUB %00000001,%10010011,%00000000
EQUB %00000011,%00010001,%10000000
EQUB %01100011,%01010101,%10001100
EQUB %11110011,%00010001,%10011110
EQUB %11110111,%11111111,%11011110
EQUB %01110111,%11111111,%11011100
EQUB %00000111,%01111101,%11000000
EQUB %00000111,%10000011,%11000000
EQUB %00000011,%11101111,%10000000
EQUB %00000011,%11111111,%10000000
EQUB %00000000,%11111110,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%11000111,%00000000
EQUB %00000001,%01000101,%00000000
EQUB %00000010,%11101011,%10000000
EQUB %00000011,%11101111,%10000000
.frame02
EQUB 18,06
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%01111100,%00000000
EQUB %00000001,%11111111,%00000000
EQUB %00000011,%11111111,%10000000
EQUB %00000011,%11111111,%10000000
EQUB %00000111,%11111111,%11000000
EQUB %00000111,%11111111,%11000000
EQUB %00100111,%10010011,%11001000
EQUB %01110111,%00010001,%11011100
EQUB %11110111,%01010101,%11011110
EQUB %11100011,%11111111,%10001110
EQUB %01100000,%11111110,%00001100
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%11000111,%00000000
EQUB %00000001,%01000101,%00000000
EQUB %00000010,%11101011,%10000000
EQUB %00000011,%11101111,%10000000
EQUB %00000001,%11000111,%00000000
.frame03
EQUB 14,05
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11000110,%00000000
EQUB %00000001,%00111001,%00000000
EQUB %00000000,%11111110,%00000000
EQUB %00000011,%11111111,%10000000
EQUB %00000011,%11111111,%10000000
EQUB %00100111,%11111111,%11001000
EQUB %01110111,%11111111,%11011100
EQUB %11110111,%11111111,%11011110
EQUB %11100011,%11111111,%10001110
EQUB %01100011,%11111111,%10001100
EQUB %00000001,%10010011,%00000000
EQUB %00000000,%01111100,%00000000
EQUB %00000000,%00000000,%00000000
.frame04
EQUB 18,03
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%11000111,%00000000
EQUB %00000011,%11101111,%10000000
EQUB %00000011,%11101111,%10000000
EQUB %00000001,%11000111,%00000000
EQUB %00000001,%00000001,%00000000
EQUB %00000000,%11111110,%00000000
EQUB %00000011,%11111111,%10000000
EQUB %00000111,%11111111,%11000000
EQUB %00110111,%11111111,%11011000
EQUB %11110111,%11111111,%11011110
EQUB %11100111,%11111111,%11001110
EQUB %11100111,%11111111,%11001110
EQUB %11000011,%11111111,%10000110
EQUB %00000011,%11111111,%10000000
EQUB %00000001,%11111111,%00000000
EQUB %00000000,%01111100,%00000000
EQUB %00000000,%00000000,%00000000
.frame05
EQUB 20,03
EQUB %00000000,%00000000,%00000000
EQUB %00000011,%11101111,%10000000
EQUB %00000011,%11101111,%10000000
EQUB %00000001,%11000111,%00000000
EQUB %00000001,%11000111,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111110,%00000000
EQUB %00000011,%11111111,%10000000
EQUB %00000011,%11111111,%10000000
EQUB %00000111,%11111111,%11000000
EQUB %11100111,%11111111,%11001110
EQUB %11110111,%11111111,%11011110
EQUB %11110111,%11111111,%11011110
EQUB %11110011,%11111111,%10011110
EQUB %11000011,%11111111,%10000110
EQUB %00000001,%11111111,%00000000
EQUB %00000001,%11111111,%00000000
EQUB %00000000,%11111110,%00000000
EQUB %00000000,%00111000,%00000000
EQUB %00000000,%00000000,%00000000
.frame06
EQUB 18,03
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%11000111,%00000000
EQUB %00000011,%11101111,%10000000
EQUB %00000011,%11101111,%10000000
EQUB %00000001,%11000111,%00000000
EQUB %00000001,%11000111,%00000000
EQUB %00000000,%00111000,%00000000
EQUB %00000011,%11111111,%10000000
EQUB %00000111,%11111111,%11000000
EQUB %00000111,%11111111,%11000000
EQUB %11000111,%11111111,%11000110
EQUB %11110111,%11111111,%11011110
EQUB %11110111,%11111111,%11011110
EQUB %01110011,%11111111,%10011100
EQUB %00000011,%11111111,%10000000
EQUB %00000001,%11111111,%00000000
EQUB %00000000,%01111100,%00000000
EQUB %00000000,%00000000,%00000000
.frame07
EQUB 14,06
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%11000111,%00000000
EQUB %00000011,%11101111,%10000000
EQUB %00000011,%11101111,%10000000
EQUB %00000001,%11010111,%00000000
EQUB %00000001,%11010111,%00000000
EQUB %11000110,%11010110,%11000110
EQUB %11100111,%00111001,%11001110
EQUB %11110111,%11111111,%11011110
EQUB %01110011,%11111111,%10011100
EQUB %00000011,%11111111,%10000000
EQUB %00000001,%11111111,%00000000
EQUB %00000000,%01111100,%00000000
EQUB %00000000,%00000000,%00000000
.frame08
EQUB 17,07
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%01111100,%00000000
EQUB %00000001,%10010011,%00000000
EQUB %00000011,%00010001,%10000000
EQUB %00000011,%01010101,%10000000
EQUB %11000111,%11111111,%11000110
EQUB %11100111,%01111101,%11001110
EQUB %11110111,%10000011,%11011110
EQUB %01110111,%11101111,%11011100
EQUB %00000111,%11111111,%11000000
EQUB %00000010,%00111000,%10000000
EQUB %00000001,%11010111,%00000000
EQUB %00000011,%11101111,%10000000
EQUB %00000011,%11101111,%10000000
EQUB %00000001,%11101111,%00000000
EQUB %00000000,%11000110,%00000000
EQUB %00000000,%00000000,%00000000
.frame09
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00001111,%10011111,%10000000
EQUB %00001111,%01101111,%10000000
EQUB %00001110,%11110111,%10000000
EQUB %00000000,%11110111,%10000000
EQUB %00000110,%11110111,%00000000
EQUB %00000111,%01101111,%00000000
EQUB %00000001,%10011100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%01101100,%00000000
EQUB %00000000,%10011100,%00000000
EQUB %00000011,%01111100,%00000000
EQUB %00000011,%01111100,%00000000
.frame10
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00000110,%00111111,%10000000
EQUB %00001111,%11110000,%10000000
EQUB %00001111,%11101111,%00000000
EQUB %00001111,%01101111,%10000000
EQUB %00000000,%11110111,%10000000
EQUB %00000111,%11111011,%10000000
EQUB %00000111,%11111100,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11000111,%00000000
EQUB %00000001,%11100111,%10000000
EQUB %00000111,%11011111,%10000000
EQUB %00000111,%11011111,%00000000
EQUB %00000001,%11011100,%00000000
.frame11
EQUB 20,04
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00101110,%00111111,%10100000
EQUB %01101111,%11111111,%01110000
EQUB %11101111,%11111111,%01111000
EQUB %11101111,%01111111,%01111000
EQUB %11100000,%11111111,%10111000
EQUB %00000111,%11111111,%00000000
EQUB %00000111,%11111111,%00000000
EQUB %00000001,%11111100,%11000000
EQUB %00010110,%00000001,%11100000
EQUB %00111111,%00000001,%11110000
EQUB %00111111,%00000011,%11100000
EQUB %00011110,%00000011,%11000000
EQUB %00001100,%00000001,%10000000
.frame12
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00000110,%00111111,%10000000
EQUB %00001111,%11110000,%10000000
EQUB %00001111,%11101111,%00000000
EQUB %00001111,%01101111,%10000000
EQUB %00000000,%11110111,%10000000
EQUB %00000111,%11111011,%10000000
EQUB %00000111,%11111100,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11000111,%00000000
EQUB %00001101,%11100111,%10000000
EQUB %00001111,%11011111,%10000000
EQUB %00000111,%11011111,%00000000
EQUB %00000001,%11011100,%00000000
.frame13
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00000110,%00111111,%10000000
EQUB %00001111,%10011111,%10000000
EQUB %00001111,%01101111,%10000000
EQUB %00001110,%11110111,%10000000
EQUB %00000000,%11110111,%10000000
EQUB %00000110,%11110111,%00000000
EQUB %00000111,%01101111,%00000000
EQUB %00000001,%10011100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%01101100,%00000000
EQUB %00000001,%10011100,%00000000
EQUB %00000011,%01111100,%00000000
EQUB %00000011,%01111100,%00000000
.frame14
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00000110,%00111111,%10000000
EQUB %00001100,%01111111,%10000000
EQUB %00001011,%10111111,%10000000
EQUB %00000111,%11011111,%10000000
EQUB %00000111,%10111111,%10000000
EQUB %00001011,%01111111,%00000000
EQUB %00000100,%11111110,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11000111,%00000000
EQUB %00001101,%11100111,%10000000
EQUB %00001111,%11011111,%10000000
EQUB %00000111,%11011111,%00000000
EQUB %00000001,%11011100,%00000000
.frame15
EQUB 20,04
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00100110,%00111111,%10100000
EQUB %01110111,%11111111,%10110000
EQUB %11110111,%11111111,%10111000
EQUB %11101111,%01111111,%10111000
EQUB %11100000,%11111111,%10111000
EQUB %00000111,%11111111,%00000000
EQUB %00000111,%11111111,%00000000
EQUB %00000001,%11111100,%11000000
EQUB %00010110,%00000001,%11100000
EQUB %00111111,%00000001,%11110000
EQUB %00111111,%00000011,%11100000
EQUB %00011110,%00000011,%11000000
EQUB %00001100,%00000001,%10000000
.frame16
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00001100,%01111111,%10000000
EQUB %00001011,%10111111,%10000000
EQUB %00000111,%11011111,%10000000
EQUB %00000111,%10111111,%10000000
EQUB %00001011,%01111111,%00000000
EQUB %00000100,%11111110,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11000111,%00000000
EQUB %00000001,%11100111,%10000000
EQUB %00000111,%11011111,%10000000
EQUB %00000111,%11011111,%00000000
EQUB %00000001,%11011100,%00000000
.frame17
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00001111,%11001111,%10000000
EQUB %00001111,%10110111,%10000000
EQUB %00001111,%01111011,%10000000
EQUB %00000111,%01111000,%00000000
EQUB %00000111,%01111011,%00000000
EQUB %00000111,%10110111,%00000000
EQUB %00000001,%11001100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%10110000,%00000000
EQUB %00000001,%11001100,%00000000
EQUB %00000001,%11110110,%00000000
EQUB %00000001,%11110110,%00000000
.frame18
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00000111,%11100011,%10000000
EQUB %00001111,%11110001,%10000000
EQUB %00001111,%11101110,%10000000
EQUB %00001111,%11011111,%00000000
EQUB %00000111,%11101111,%00000000
EQUB %00000111,%11110110,%10000000
EQUB %00000111,%11111001,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000111,%00010000,%00000000
EQUB %00001111,%00111011,%00000000
EQUB %00001111,%11011111,%00000000
EQUB %00000111,%11011110,%00000000
EQUB %00000001,%11011100,%00000000
.frame19
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00101111,%11100011,%10100000
EQUB %01101111,%11111111,%01110000
EQUB %11101111,%11111111,%01111000
EQUB %11101111,%11110111,%10111000
EQUB %11100111,%11111000,%00111000
EQUB %00000111,%11111111,%00000000
EQUB %00000111,%11111111,%00000000
EQUB %00011001,%11111100,%00000000
EQUB %00111100,%00000011,%00000000
EQUB %01111000,%00000111,%11000000
EQUB %00111100,%00001111,%11100000
EQUB %00011110,%00000111,%11000000
EQUB %00001100,%00000011,%00000000
.frame20
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00001111,%11110001,%10000000
EQUB %00001111,%11101110,%10000000
EQUB %00001111,%11011111,%00000000
EQUB %00000111,%11101111,%00000000
EQUB %00000111,%11110110,%00000000
EQUB %00000111,%11111010,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000111,%00010000,%00000000
EQUB %00001111,%00111010,%00000000
EQUB %00001111,%10111111,%00000000
EQUB %00000111,%11011110,%00000000
EQUB %00000001,%11011100,%00000000
.frame21
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00001111,%11001111,%10000000
EQUB %00001111,%10110111,%10000000
EQUB %00001111,%01111011,%10000000
EQUB %00000111,%01111000,%00000000
EQUB %00000111,%01111011,%00000000
EQUB %00000111,%10110111,%00000000
EQUB %00000001,%11001100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%10110000,%00000000
EQUB %00000001,%11001000,%00000000
EQUB %00000001,%11110110,%00000000
EQUB %00000001,%11110110,%00000000
.frame22
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00001100,%01111111,%10000000
EQUB %00001011,%10111111,%10000000
EQUB %00000111,%11010111,%10000000
EQUB %00000111,%10111000,%00000000
EQUB %00000111,%01111111,%00000000
EQUB %00000000,%11111111,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000111,%00010000,%00000000
EQUB %00001111,%00111010,%00000000
EQUB %00001111,%11011111,%00000000
EQUB %00000111,%11011110,%00000000
EQUB %00000001,%11011100,%00000000
.frame23
EQUB 20,04
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00100111,%11100011,%00100000
EQUB %01110111,%11111111,%10110000
EQUB %11110111,%11111111,%10111000
EQUB %11110111,%11110111,%10111000
EQUB %11100111,%11111000,%00111000
EQUB %00000111,%11111111,%00000000
EQUB %00000111,%11111111,%00000000
EQUB %00011001,%11111100,%00000000
EQUB %00111100,%00000011,%01000000
EQUB %01111100,%00000111,%11100000
EQUB %00111110,%00001111,%11100000
EQUB %00011110,%00000111,%11000000
EQUB %00001100,%00000011,%00000000
.frame24
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00001100,%01111111,%10000000
EQUB %00001011,%10111111,%10000000
EQUB %00000111,%11010111,%10000000
EQUB %00000111,%10111000,%00000000
EQUB %00000011,%01111111,%00000000
EQUB %00000100,%11111111,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000111,%00010000,%00000000
EQUB %00001111,%00111011,%00000000
EQUB %00001111,%10111111,%00000000
EQUB %00000111,%11011110,%00000000
EQUB %00000001,%11011100,%00000000
.frame25
EQUB 18,06
EQUB %00000000,%00000000,%00000000
EQUB %00001111,%10000000,%00000000
EQUB %00011111,%11110000,%00000000
EQUB %00111111,%11111100,%00000000
EQUB %00111111,%11111110,%00000000
EQUB %00111111,%11111110,%00000000
EQUB %00110000,%11111111,%00000000
EQUB %00110010,%10001111,%00000000
EQUB %00011000,%01110111,%00000000
EQUB %00011111,%01111011,%00000000
EQUB %00001110,%11111010,%00000000
EQUB %00001110,%00110100,%01000000
EQUB %00000100,%11001000,%11100000
EQUB %00000001,%11100000,%11110000
EQUB %00000000,%00000010,%11100000
EQUB %00000000,%00000011,%11000000
EQUB %00000000,%00000111,%00000000
EQUB %00000000,%00000111,%00000000
.frame26
EQUB 15,07
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11110000,%00000000
EQUB %00000111,%11111100,%00000000
EQUB %00011111,%11111100,%00000000
EQUB %00111111,%11111110,%01111000
EQUB %01111111,%11000110,%01111000
EQUB %01111111,%10111010,%00111000
EQUB %01111111,%01111100,%01011000
EQUB %01111000,%01111100,%01011000
EQUB %01110010,%10111010,%00100000
EQUB %00110000,%11000110,%00111000
EQUB %00011111,%11101100,%00011000
EQUB %00000111,%11101100,%00000000
EQUB %00000000,%11100000,%00000000
EQUB %00000000,%00000000,%00000000
.frame27
EQUB 20,04
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00000001,%00000000
EQUB %00000000,%00000011,%10000000
EQUB %00000000,%00000111,%11000000
EQUB %00000000,%00000111,%11000000
EQUB %00000000,%00000001,%00010000
EQUB %00000001,%11110000,%11111000
EQUB %00000111,%11001000,%00110000
EQUB %00001111,%10110100,%00000000
EQUB %00011111,%01111010,%00000000
EQUB %00011111,%01111011,%00000000
EQUB %00011111,%01111011,%00000000
EQUB %00111111,%10110001,%00000000
EQUB %00111111,%00001100,%00000000
EQUB %00111110,%01111110,%00000000
EQUB %00111110,%00111100,%00000000
EQUB %00011110,%00111000,%00000000
EQUB %00011111,%01100000,%00000000
EQUB %00001111,%10000000,%00000000
EQUB %00000000,%00000000,%00000000
.frame28
EQUB 21,03
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%11110110,%00000000
EQUB %00000001,%11110110,%00000000
EQUB %00000001,%11001000,%00000000
EQUB %00000001,%10110000,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%11001100,%00000000
EQUB %00000111,%10110111,%00000000
EQUB %00000111,%01111011,%00000000
EQUB %00001111,%01111000,%00000000
EQUB %00001111,%01111011,%10000000
EQUB %00001111,%10110111,%10000000
EQUB %00001111,%11001111,%10000000
EQUB %00000111,%11100011,%00000000
EQUB %00000111,%11101011,%00000000
EQUB %00000111,%11100011,%00000000
EQUB %00000011,%11110010,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000000,%00000000,%00000000
.frame29
EQUB 20,04
EQUB %00000000,%00000000,%00000000
EQUB %00000110,%00000000,%00000000
EQUB %00001111,%00000000,%00000000
EQUB %00000110,%00000000,%00000000
EQUB %00111010,%00000000,%00000000
EQUB %01111010,%01111000,%00000000
EQUB %01110000,%11010010,%00000000
EQUB %00111001,%00100111,%00000000
EQUB %00000010,%11100111,%00000000
EQUB %00000010,%11111011,%10000000
EQUB %00000110,%11110111,%11000000
EQUB %00000111,%01110000,%11000000
EQUB %00001111,%10001010,%01100000
EQUB %00000111,%11111000,%01100000
EQUB %00000111,%11111111,%11100000
EQUB %00000011,%11111111,%11000000
EQUB %00000001,%11111111,%11000000
EQUB %00000000,%01111111,%10000000
EQUB %00000000,%00001100,%00000000
EQUB %00000000,%00000000,%00000000
.frame30
EQUB 15,05
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00111000,%00000000
EQUB %00000001,%10111111,%00000000
EQUB %11000001,%10111111,%11000000
EQUB %11100011,%00011000,%01100000
EQUB %00100010,%10101010,%01110000
EQUB %11010001,%11110000,%11110000
EQUB %11010001,%11110111,%11110000
EQUB %11100010,%11101111,%11110000
EQUB %11110011,%00011111,%11110000
EQUB %11110011,%11111111,%11100000
EQUB %00000001,%11111111,%11000000
EQUB %00000001,%11111111,%00000000
EQUB %00000000,%01111000,%00000000
EQUB %00000000,%00000000,%00000000
.frame31
EQUB 20,04
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00111110,%00000000
EQUB %00000000,%11111111,%00000000
EQUB %00000001,%11001111,%10000000
EQUB %00000011,%10001111,%10000000
EQUB %00000111,%10101111,%11000000
EQUB %00000111,%10001111,%11000000
EQUB %00000011,%00011111,%11000000
EQUB %00001000,%11101111,%10000000
EQUB %00001101,%11101111,%10000000
EQUB %00000101,%11101111,%10000000
EQUB %00000110,%11101111,%00000000
EQUB %00000011,%00011111,%00000000
EQUB %00000000,%11111110,%00000000
EQUB %00000000,%01111000,%00000000
EQUB %00011010,%00000000,%00000000
EQUB %00111000,%10000000,%00000000
EQUB %00010111,%11000000,%00000000
EQUB %00000111,%10000000,%00000000
EQUB %00000011,%10000000,%00000000
.frame32
EQUB 20,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00001111,%10000000
EQUB %00000000,%01111111,%11000000
EQUB %00000001,%11111111,%11100000
EQUB %00000011,%11111111,%11100000
EQUB %00000011,%11111111,%11100000
EQUB %00000111,%11111000,%01100000
EQUB %00000111,%10001010,%01100000
EQUB %00000111,%01110000,%11000000
EQUB %00000110,%11110111,%11000000
EQUB %00000010,%11110111,%10000000
EQUB %00010001,%01101011,%10000000
EQUB %00111000,%10011001,%00000000
EQUB %01110000,%00111100,%00000000
EQUB %00111010,%00000000,%00000000
EQUB %00011010,%00000000,%00000000
EQUB %00000110,%00000000,%00000000
EQUB %00000111,%00000000,%00000000
EQUB %00000010,%00000000,%00000000
EQUB %00000000,%00000000,%00000000
.frame33
EQUB 15,06
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%01111000,%00000000
EQUB %00000001,%11111111,%00000000
EQUB %00000001,%11111111,%11000000
EQUB %11110011,%11111111,%11100000
EQUB %11110011,%00011111,%11110000
EQUB %11100010,%11101111,%11110000
EQUB %11010001,%11110111,%11110000
EQUB %11010001,%11110000,%11110000
EQUB %00100010,%10101010,%01110000
EQUB %11000011,%00011000,%01100000
EQUB %11000001,%10111111,%11000000
EQUB %00000001,%10111111,%00000000
EQUB %00000000,%00111000,%00000000
EQUB %00000000,%00000000,%00000000
.frame34
EQUB 20,02
EQUB %00000000,%00000000,%00000000
EQUB %00000100,%00000000,%00000000
EQUB %00001110,%00000000,%00000000
EQUB %00011111,%00000000,%00000000
EQUB %00011111,%00000000,%00000000
EQUB %01101000,%00000000,%00000000
EQUB %11100000,%01111100,%00000000
EQUB %01000000,%10011111,%00000000
EQUB %00000000,%01101111,%10000000
EQUB %00000001,%11110111,%11000000
EQUB %00000110,%11110111,%11000000
EQUB %00000110,%11110111,%11000000
EQUB %00000100,%01101111,%11100000
EQUB %00000001,%10000111,%11100000
EQUB %00000011,%11110011,%11100000
EQUB %00000001,%11100011,%11100000
EQUB %00000000,%11100011,%11000000
EQUB %00000000,%00111111,%11000000
EQUB %00000000,%00001111,%10000000
EQUB %00000000,%00000000,%00000000
.frame35
EQUB 21,01
EQUB %00000000,%00000000,%00000000
EQUB %00000011,%01111100,%00000000
EQUB %00000011,%01111100,%00000000
EQUB %00000001,%10011100,%00000000
EQUB %00000000,%01101100,%00000000
EQUB %00000000,%00000000,%00000000
EQUB %00000001,%10011100,%00000000
EQUB %00000111,%01101111,%00000000
EQUB %00000110,%11110111,%00000000
EQUB %00000000,%01110111,%10000000
EQUB %00001110,%11110111,%10000000
EQUB %00001111,%01101111,%10000000
EQUB %00001111,%10011111,%10000000
EQUB %00000110,%00111111,%00000000
EQUB %00000110,%10111111,%00000000
EQUB %00000110,%00111111,%00000000
EQUB %00000010,%01111110,%00000000
EQUB %00000011,%11111110,%00000000
EQUB %00000001,%11111100,%00000000
EQUB %00000000,%11111000,%00000000
EQUB %00000000,%00000000,%00000000
.frame36
EQUB 20,03
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%00000011,%00000000
EQUB %00000000,%00000111,%10000000
EQUB %00000000,%00000011,%01000000
EQUB %00000000,%00000010,%11100000
EQUB %00000000,%11110011,%01110000
EQUB %00000010,%01111000,%11110000
EQUB %00000111,%01001100,%11100000
EQUB %00000111,%00110110,%00000000
EQUB %00001110,%11111010,%00000000
EQUB %00011111,%01111011,%00000000
EQUB %00011000,%01110111,%00000000
EQUB %00110010,%10001111,%10000000
EQUB %00110001,%11111111,%00000000
EQUB %00111111,%11111111,%00000000
EQUB %00011111,%11111110,%00000000
EQUB %00011111,%11111100,%00000000
EQUB %00001111,%11110000,%00000000
EQUB %00000001,%10000000,%00000000
EQUB %00000000,%00000000,%00000000
.frame37
EQUB 15,06
EQUB %00000000,%00000000,%00000000
EQUB %00000000,%11100000,%00000000
EQUB %00000111,%11101100,%00000000
EQUB %00011111,%11101100,%00011000
EQUB %00110000,%11000110,%00011000
EQUB %01110010,%10111010,%00100000
EQUB %01111000,%01111100,%01011000
EQUB %01111111,%01111100,%01011000
EQUB %01111111,%10111010,%00111000
EQUB %01111111,%11000110,%01111000
EQUB %00111111,%11111110,%01111000
EQUB %00011111,%11111100,%00000000
EQUB %00000111,%11111100,%00000000
EQUB %00000000,%11110000,%00000000
EQUB %00000000,%00000000,%00000000
.frame38
EQUB 21,02
EQUB %00000000,%00000000,%00000000
EQUB %00000011,%11100000,%00000000
EQUB %00000111,%11111000,%00000000
EQUB %00001111,%10011100,%00000000
EQUB %00001111,%10001110,%00000000
EQUB %00011111,%10101111,%00000000
EQUB %00011111,%10001111,%00000000
EQUB %00011111,%11000110,%00000000
EQUB %00001111,%10111000,%10000000
EQUB %00001111,%10111101,%10000000
EQUB %00001111,%10111101,%00000000
EQUB %00000111,%10111001,%00000000
EQUB %00000111,%11000110,%00000000
EQUB %00000011,%11111000,%00000000
EQUB %00000000,%11110000,%00000000
EQUB %00000000,%00000010,%11100000
EQUB %00000000,%00001001,%01100000
EQUB %00000000,%00011111,%10000000
EQUB %00000000,%00001111,%00000000
EQUB %00000000,%00001110,%00000000
EQUB %00000000,%00000000,%00000000