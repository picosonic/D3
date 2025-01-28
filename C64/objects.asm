.movingdata

; static set of objects
.orig_rooms ; rooms
  EQUB &37, &65, &3a, &65, &53 ; 0
  EQUB &64, &3a, &4d, &57, &5d ; 5
  EQUB &48, &28, &55, &18, &3c ; 10
  EQUB &30, &65, &65, &04, &35 ; 15
  EQUB &24, &24, &59, &35, &23 ; 20
  EQUB &32, &16, &18, &1f, &28 ; 25
  EQUB &29, &2e, &31, &33, &39 ; 30
  EQUB &3f, &43, &44, &45, &4b ; 35
  EQUB &4c, &4d, &54, &56, &57 ; 40
  EQUB &59, &5c, &5e, &65, &65 ; 45
  EQUB &65, &65, &65, &65, &65 ; 50
  EQUB &65, &34, &37, &37, &38 ; 55
  EQUB &48, &49, &3b, &65, &65 ; 60
  EQUB &16, &24, &24, &24, &24 ; 65
  EQUB &28, &28, &29, &29, &2d ; 70
  EQUB &30, &30, &30, &30, &30 ; 75
  EQUB &31, &32, &32, &33, &33 ; 80
  EQUB &34, &35, &37, &38, &38 ; 85
  EQUB &38, &38, &3b, &3c, &44 ; 90
  EQUB &45, &47, &47, &54, &58 ; 95
  EQUB &5e, &5e, &5e, &5e, &5e ; 100
  EQUB &5e, &65, &65, &36, &36 ; 105
  EQUB &36, &36, &36, &36, &36 ; 110
  EQUB &47, &47, &28, &28, &58 ; 115
  EQUB &58, &38, &38, &43, &45 ; 120
  EQUB &48, &59, &3b, &2f, &57 ; 125
  EQUB &49, &65, &23, &58      ; 130
.orig_xlocs ; Xs
  EQUB &30, &40, &48, &36, &50 ; 0
  EQUB &34, &3c, &38, &54, &50 ; 5
  EQUB &3c, &34, &2a, &50, &3c ; 10
  EQUB &28, &46, &56, &00, &30 ; 15
  EQUB &44, &48, &32, &5a, &3a ; 20
  EQUB &56, &24, &2a, &26, &32 ; 25
  EQUB &2c, &56, &3c, &58, &48 ; 30
  EQUB &3c, &3e, &54, &28, &36 ; 35
  EQUB &46, &34, &3c, &52, &58 ; 40
  EQUB &2c, &40, &3c, &56, &3a ; 45
  EQUB &4c, &54, &4c, &38, &34 ; 50
  EQUB &52, &56, &3a, &4c, &54 ; 55
  EQUB &4c, &38, &34, &42, &46 ; 60
  EQUB &40, &4e, &50, &28, &50 ; 65
  EQUB &3c, &36, &24, &2a, &4a ; 70
  EQUB &34, &3c, &44, &3c, &4a ; 75
  EQUB &2c, &36, &52, &42, &4c ; 80
  EQUB &40, &46, &2e, &32, &48 ; 85
  EQUB &34, &46, &48, &2f, &50 ; 90
  EQUB &28, &34, &3c, &22, &2a ; 95
  EQUB &3e, &4a, &4a, &4a, &2a ; 100
  EQUB &32, &28, &2e, &4c, &4b ; 105
  EQUB &4a, &49, &48, &47, &44 ; 110
  EQUB &34, &34, &28, &28, &3a ; 115
  EQUB &3a, &3c, &3c, &54, &2e ; 120
  EQUB &22, &3e, &40, &44, &3c ; 125
  EQUB &3e, &43, &5a, &3a      ; 130
.orig_ylocs ; Ys
  EQUB &90, &90, &aa, &50, &90 ; 0
  EQUB &a0, &98, &70, &50, &98 ; 5
  EQUB &80, &70, &70, &88, &78 ; 10
  EQUB &60, &84, &68, &00, &88 ; 15
  EQUB &90, &90, &88, &90, &88 ; 20
  EQUB &a0, &68, &98, &78, &48 ; 25
  EQUB &40, &80, &a0, &98, &a0 ; 30
  EQUB &96, &70, &70, &a0, &50 ; 35
  EQUB &38, &70, &60, &96, &a0 ; 40
  EQUB &60, &50, &98, &58, &88 ; 45
  EQUB &80, &80, &50, &48, &68 ; 50
  EQUB &a0, &58, &88, &80, &80 ; 55
  EQUB &50, &48, &68, &88, &88 ; 60
  EQUB &98, &88, &a0, &a0, &49 ; 65
  EQUB &98, &a0, &65, &68, &74 ; 70
  EQUB &ac, &ac, &ac, &a3, &68 ; 75
  EQUB &38, &9c, &a0, &4e, &88 ; 80
  EQUB &68, &98, &a0, &74, &74 ; 85
  EQUB &9c, &9c, &93, &90, &9b ; 90
  EQUB &70, &30, &30, &90, &4c ; 95
  EQUB &46, &30, &54, &40, &98 ; 100
  EQUB &98, &98, &98, &98, &98 ; 105
  EQUB &98, &98, &98, &98, &96 ; 110
  EQUB &38, &60, &38, &58, &30 ; 115
  EQUB &60, &68, &88, &70, &b0 ; 120
  EQUB &60, &48, &80, &50, &40 ; 125
  EQUB &40, &72, &80, &b0      ; 130
.orig_attrs ; attribs
  EQUB PAL_RED,                 PAL_GREEN,               PAL_RED,                 PAL_CYAN,                PAL_CYAN                ; 0
  EQUB PAL_WHITE,               PAL_WHITE,               PAL_MAGENTA,             PAL_RED,                 PAL_YELLOW              ; 5
  EQUB PAL_WHITE,               PAL_RED,                 PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 10
  EQUB PAL_YELLOW,              PAL_WHITE,               PAL_GREEN,               PAL_GREEN,               PAL_YELLOW              ; 15
  EQUB PAL_CYAN,                PAL_YELLOW,              PAL_YELLOW,              PAL_RED,                 PAL_RED                 ; 20
  EQUB PAL_RED,                 PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 25
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 30
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 35
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 40
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 45
  EQUB PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW,              PAL_YELLOW              ; 50
  EQUB PAL_YELLOW,              PAL_WHITE,               PAL_GREEN,               PAL_RED,                 PAL_RED                 ; 55
  EQUB PAL_RED,                 PAL_GREEN,               PAL_GREEN,               PAL_WHITE,               ATTR_REVERSE+PAL_WHITE  ; 60
  EQUB &20,                     PAL_GREEN,               &20,                     PAL_BLACK,               PAL_WHITE               ; 65
  EQUB PAL_YELLOW,              PAL_BLACK,               PLOT_XOR+ATTR_NOTSOLID+PAL_RED, &10,              PAL_WHITE               ; 70
  EQUB PAL_WHITE,               PAL_WHITE,               PAL_WHITE,               ATTR_NOTSOLID+PAL_RED,   PAL_BLACK               ; 75
  EQUB PAL_WHITE,               PAL_RED,                 PAL_BLACK,               PAL_CYAN,                ATTR_NOTSOLID+PAL_WHITE ; 80
  EQUB PAL_BLACK,               ATTR_NOTSOLID+PAL_GREEN, ATTR_NOTSOLID+PAL_RED,   PAL_CYAN,                PAL_CYAN                ; 85
  EQUB PAL_CYAN,                PAL_CYAN,                PAL_WHITE,               PAL_BLACK,               PAL_WHITE               ; 90
  EQUB PAL_WHITE,               PAL_RED,                 PAL_RED,                 ATTR_NOTSOLID+PAL_RED,   PAL_WHITE               ; 95
  EQUB PAL_CYAN,                PAL_WHITE,               ATTR_NOTSOLID+PAL_WHITE, PAL_WHITE,               PLOT_XOR+PAL_WHITE      ; 100
  EQUB PLOT_XOR+PAL_WHITE,      ATTR_NOTSOLID+PAL_RED,   ATTR_NOTSOLID+PAL_RED,   ATTR_GRID+PAL_RED,       ATTR_GRID+PAL_RED       ; 105
  EQUB ATTR_GRID+PAL_RED,       ATTR_GRID+PAL_RED,       ATTR_GRID+PAL_RED,       ATTR_GRID+PAL_RED,       PAL_RED                 ; 110
  EQUB PAL_WHITE,               ATTR_NOTSOLID+PAL_WHITE, PAL_WHITE,               ATTR_NOTSOLID+PAL_WHITE, PAL_WHITE               ; 115
  EQUB ATTR_NOTSOLID+PAL_WHITE, PAL_WHITE,               ATTR_NOTSOLID+PAL_WHITE, PAL_BLACK,               ATTR_NOTSOLID+PAL_RED   ; 120
  EQUB ATTR_NOTSOLID+PAL_GREEN, ATTR_NOTSOLID+PLOT_XOR+PAL_GREEN, ATTR_NOTSOLID+PLOT_XOR+PAL_RED, ATTR_NOTSOLID+PLOT_XOR+PAL_RED, ATTR_NOTSOLID+PAL_GREEN ; 125
  EQUB ATTR_NOTSOLID+PLOT_XOR+PAL_GREEN, ATTR_REVERSE+ATTR_NOTSOLID+PAL_GREEN,         ATTR_NOTSOLID+PAL_RED,   ATTR_NOTSOLID+PAL_RED   ; 130
.orig_frames ; frames
  EQUB SPR_BAG,         SPR_BEAN,       SPR_MANURE,         SPR_CROWBAR,     SPR_BUCKET           ; 0
  EQUB SPR_BONE,        SPR_COW,        SPR_HAPPYDUST,      SPR_PICKAXE,     SPR_GOLDENEGG        ; 5
  EQUB SPR_BLACKHOLE,   SPR_THICKRUG,   SPR_KEY,            SPR_KEY,         SPR_KEY              ; 10
  EQUB SPR_KEY,         SPR_ROPE,       SPR_SLEEPINGPOTION, SPR_APPLE,       SPR_BRANDYBOTTLE     ; 15
  EQUB SPR_JUGOFWATER,  SPR_BREAD,      SPR_DOORKNOCKER,    SPR_SMALLSTONE5, SPR_SMALLSTONE3      ; 20
  EQUB SPR_SMALLSTONE2 ; 25
.coinstart
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN                              ; 26
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 30
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 35
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 40
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 45
  EQUB SPR_COIN,        SPR_COIN,       SPR_COIN,           SPR_COIN,        SPR_COIN             ; 50
  EQUB SPR_COIN                                                                                   ; 55
.coinend
  EQUB SPR_WOODENRAIL,  SPR_LEAFYBIT1,  SPR_WOODENRAIL,     SPR_WOODENRAIL                        ; 56
  EQUB SPR_WOODENRAIL,  SPR_WINDOW,     SPR_LEAFYBIT1,      SPR_SHOPKEEPER,  SPR_SHOPKEEPER       ; 60
  EQUB SPR_EGG,         SPR_TROLL,      SPR_EGG,            SPR_EGG,         SPR_RAT              ; 65
  EQUB SPR_GOLDENEGG,   SPR_EGG,        SPR_LARGESTONE2,    SPR_EGG,         SPR_DOZY             ; 70
  EQUB SPR_WATER,       SPR_WATER,      SPR_WATER,          SPR_WOOD0,       SPR_EGG              ; 75
  EQUB SPR_HAWK0,       SPR_GRUNT0,     SPR_EGG,            SPR_SWITCH,      SPR_PORTCULLIS       ; 80
  EQUB SPR_EGG,         SPR_CROCCLOSED, SPR_WOOD0,          SPR_MACHINE,     SPR_MACHINE          ; 85
  EQUB SPR_MACHINE,     SPR_MACHINE,    SPR_DYLAN,          SPR_EGG,         SPR_DENZIL           ; 90
  EQUB SPR_DAGGERBLADE, SPR_WOOD0,      SPR_WOOD0,          SPR_PLANKOFWOOD, SPR_GRANDDIZZY       ; 95
  EQUB SPR_SWITCH,      SPR_LIFTTOP,    SPR_LIFTBOTTOM,     SPR_DAISY,       SPR_DAGGERBLADE      ; 100
  EQUB SPR_DAGGERBLADE, SPR_GROUND,     SPR_GROUND,         SPR_DRAGONNECK,  SPR_DRAGONNECK       ; 105
  EQUB SPR_DRAGONNECK,  SPR_DRAGONNECK, SPR_DRAGONNECK,     SPR_DRAGONNECK,  SPR_DRAGONHEADCLOSED ; 110
  EQUB SPR_LIFTTOP,     SPR_LIFTBOTTOM, SPR_LIFTTOP,        SPR_LIFTBOTTOM,  SPR_LIFTTOP          ; 115
  EQUB SPR_LIFTBOTTOM,  SPR_LIFTTOP,    SPR_LIFTBOTTOM,     SPR_FRAMERIGHT,  SPR_STONEBLOCK4      ; 120
  EQUB SPR_LEAFYBIT1
.vC696
  EQUB                  SPR_LEAFYBIT,   SPR_BRANCH2,        SPR_HYPHEN,      SPR_LEAFYBIT1        ; 125
  EQUB SPR_LEAFYBIT1,   SPR_LEAF0,      SPR_STONEBLOCK3,    SPR_WOOD0                             ; 130

.endofmovingdata

movingsize = 5
noofmoving = (((endofmovingdata-movingdata)/movingsize) AND &FF)

IF (endofmovingdata-movingdata) <> (noofmoving*movingsize)
  ERROR "moving data typed in wrong"
ENDIF

firstcoin = coinstart-orig_frames
lastcoin = coinend-orig_frames-1

; object arrays
objs_rooms  = &C69E
objs_xlocs  = &C724
objs_ylocs  = &C7AA
objs_attrs  = &C830
objs_frames = &C8B6

; object flags
collected = 4
maxcollectable = 62

; object offsets
obj_bag            = 0
obj_bean           = 1
obj_manure         = 2
obj_crowbar        = 3
obj_bucket         = 4
obj_bone           = 5
obj_cow            = 6
obj_pickaxe        = 8
obj_goldenegg      = 9
obj_blackhole      = 10
obj_rug            = 11
obj_rope           = 16
obj_sleepingpotion = 17
obj_apple          = 18
obj_brandy         = 19
obj_jugofwater     = 20
obj_bread          = 21
obj_doorknocker    = 22

; end of collectables

obj_shopkeeper     = 63
;= 65 ; egg
obj_troll          = 66
;= 67 ; egg
;= 68 ; egg
obj_rat            = 69
obj_goldenegg2     = 70
;= 71 ; egg
;= 73 ; egg
obj_dozy           = 74
obj_water          = 75
obj_pontoon        = 78
;= 79 ; egg
obj_hawk           = 80
obj_grunt          = 81
;= 82 ; egg
obj_switch         = 83
obj_portcullis     = 84
;= 85 ; egg
obj_croc           = 86
obj_wood           = 87
obj_machines       = 88
obj_dylan          = 92
;= 93 ; egg
obj_denzil         = 94
obj_plank          = 98
obj_granddizzy     = 99
obj_switch2        = 100
obj_lifttop        = 101
obj_liftbottom     = 102
obj_daisy          = 103
obj_dragonneck     = 113
obj_dragonhead     = 114

; Upper RAM area

; Live set of objects (copied from C400)
; room[] array
;.vC69E ; bag
;.vC69F ; bean
;.vC6A1 ; crowbar
;.vC6A2 ; bucket
;.vC6A3 ; bone
.vC6A5 ; happydust
;.vC6A8 ; blackhole
;.vC6A9 ; rug
;.vC6AE ; rope
;.vC6AF ; sleepingpotion
;.vC6B1 ; brandy
;.vC6B2 ; jugofwater
;.vC6B3 ; bread
;.vC6B4 ; doorknocker
.vC6D5 ; (last coin)
;.vC6DD ; shopkeeper
;.vC6DE ; shopkeeper
.vC6DF ; egg
;.vC6E0 ; troll
.vC6E1 ; egg
.vC6E2 ; egg
;.vC6E3 ; rat
;.vC6E4 ; goldenegg2
.vC6E6 ; largestone
.vC6F0 ; egg
;.vC6F5 ; wood
;.vC700 ; plank
;.vC705 ; daisy
.vC708 ; ground
.vC709 ; ground
.vC721 ; leaf

; X[] array
;.vC724 ; bag
;.vC735 ; sleepingpotion
;.vC739 ; bread
;.vC766 ; troll
.vC768 ; 68 ? egg
;.vC769 ; rat
;.vC76E ; dozy
;.vC774 ; hawk
;.vC775 ; grunt
;.vC78B ; daisy

; Y[] array
;.vC7AA ; bag
;.vC7BB ; sleepingpotion
;.vC7BF ; bread
;.vC7EC ; troll
;.vC7F4 ; dozy
;.vC7F5 ; 75 these 3 are "water" ?
;.vC7F6 ; 76
;.vC7F7 ; 77
;.vC7F8 ; wood2 (pontoon / bridge)
;.vC7FA ; hawk
;.vC7FE ; portcullis
;.vC80F ; lifttop
;.vC810 ; liftbottom
;.vC811 ; daisy
;.vC81B ; dragonneck

; attrib[] array
;.vC830 ; bag
;.vC831 ; bean
;.vC832 ; manure
;.vC834 ; bucket
;.vC835 ; bone
;.vC839 ; goldenegg
;.vC872 ; troll
;.vC875 ; rat
;.vC880 ; hawk
;.vC881 ; grunt
;.vC883 ; switch
;.vC884 ; portcullis
;.vC888 ; machines
;.vC88C ; dylan
;.vC894 ; switch2
;.vC897 ; daisy
.vC89C ; 108 ? dragonneck
;.vC8A2 ; dragonhead

; frame[] array
;.vC8B6 ; bag
;.vC906 ; hawk
;.vC907 ; grunt
;.vC90C ; croc
;.vC928 ; dragonhead

.vCFF8
