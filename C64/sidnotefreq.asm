; SID note frequencies hi (C64 manual)
.sid_note_freq_hi ; [1]
{
  EQUB &00 ; mute

  EQUB &01 ; C-0
  EQUB &01 ; C#0
  EQUB &01 ; D-0
  EQUB &01 ; D#0
  EQUB &01 ; E-0
  EQUB &01 ; F-0
  EQUB &01 ; F#0
  EQUB &01 ; G-0
  EQUB &01 ; G#0
  EQUB &01 ; A-0
  EQUB &01 ; A#0
  EQUB &01 ; B-0

  EQUB &02 ; C-1
  EQUB &02 ; C#1
  EQUB &02 ; D-1
  EQUB &02 ; D#1
  EQUB &02 ; E-1
  EQUB &02 ; F-1
  EQUB &02 ; F#1
  EQUB &03 ; G-1
  EQUB &03 ; G#1
  EQUB &03 ; A-1
  EQUB &03 ; A#1
  EQUB &03 ; B-1

  EQUB &04 ; C-2
  EQUB &04 ; C#2
  EQUB &04 ; D-2
  EQUB &04 ; D#2
  EQUB &05 ; E-2
  EQUB &05 ; F-2
  EQUB &05 ; F#2
  EQUB &06 ; G-2
  EQUB &06 ; G#2
  EQUB &07 ; A-2
  EQUB &07 ; A#2
  EQUB &07 ; B-2

  EQUB &08 ; C-3
  EQUB &08 ; C#3
  EQUB &09 ; D-3
  EQUB &09 ; D#3
  EQUB &0a ; E-3
  EQUB &0b ; F-3
  EQUB &0b ; F#3
  EQUB &0c ; G-3
  EQUB &0d ; G#3
  EQUB &0e ; A-3
  EQUB &0e ; A#3
  EQUB &0f ; B-3

  EQUB &10 ; C-4
  EQUB &11 ; C#4
  EQUB &12 ; D-4
  EQUB &13 ; D=4
  EQUB &15 ; E-4
  EQUB &16 ; F-4
  EQUB &17 ; F#4
  EQUB &19 ; G-4
  EQUB &1a ; G#4
  EQUB &1c ; A-4
  EQUB &1d ; A#4
  EQUB &1f ; B-4

  EQUB &21 ; C-5
  EQUB &23 ; C#5
  EQUB &25 ; D-5
  EQUB &27 ; D#5
  EQUB &2a ; E-5
  EQUB &2c ; F-5
  EQUB &2f ; F#5
  EQUB &32 ; G-5
  EQUB &35 ; G#5
  EQUB &38 ; A-5
  EQUB &3b ; A#5
  EQUB &3f ; B-5

  EQUB &43 ; C-6
  EQUB &47 ; C#6
  EQUB &4b ; D-6
  EQUB &4f ; D#6
  EQUB &54 ; E-6
  EQUB &59 ; F-6
  EQUB &5e ; F#6
  EQUB &64 ; G-6
  EQUB &6a ; G#6
  EQUB &70 ; A-6
  EQUB &77 ; A#6
  EQUB &7e ; B-6

  EQUB &86 ; C-7
  EQUB &8e ; C#7
  EQUB &96 ; D-7
  EQUB &9f ; D#7
  EQUB &a8 ; E-7
  EQUB &b3 ; F-7
  EQUB &bd ; F#7
  EQUB &c8 ; G-7
  EQUB &d4 ; G#7
  EQUB &e1 ; A-7
  EQUB &ee ; A#7
  EQUB &fd ; B-7
}

; SID note frequencies lo (C64 manual)
.sid_note_freq_lo ; [1]
{
  EQUB &00 ; mute

  EQUB &0c ; C-0
  EQUB &1c ; C#0
  EQUB &2d ; D-0
  EQUB &3e ; D#0
  EQUB &51 ; E-0
  EQUB &66 ; F-0
  EQUB &7b ; F#0
  EQUB &91 ; G-0
  EQUB &a9 ; G#0
  EQUB &c3 ; A-0
  EQUB &dd ; A#0
  EQUB &fa ; B-0

  EQUB &18 ; C-1
  EQUB &38 ; C#1
  EQUB &5a ; D-1
  EQUB &7d ; D#1
  EQUB &a3 ; E-1
  EQUB &cc ; F-1
  EQUB &f6 ; F#1
  EQUB &23 ; G-1
  EQUB &5d ; G#1
  EQUB &86 ; A-1
  EQUB &bb ; A#1
  EQUB &f4 ; B-1

  EQUB &30 ; C-2
  EQUB &70 ; C#2
  EQUB &b4 ; D-2
  EQUB &fb ; D#2
  EQUB &47 ; E-2
  EQUB &98 ; F-2
  EQUB &ed ; F#2
  EQUB &47 ; G-2
  EQUB &a7 ; G#2
  EQUB &0c ; A-2
  EQUB &77 ; A#2
  EQUB &e9 ; B-2

  EQUB &61 ; C-3
  EQUB &e1 ; C#3
  EQUB &68 ; D-3
  EQUB &f7 ; D#3
  EQUB &8f ; E-3
  EQUB &30 ; F-3
  EQUB &da ; F#3
  EQUB &8f ; G-3
  EQUB &4e ; G#3
  EQUB &18 ; A-3
  EQUB &ef ; A#3
  EQUB &d2 ; B-3

  EQUB &c3 ; C-4
  EQUB &c3 ; C#4
  EQUB &d1 ; D-4
  EQUB &ef ; D#4
  EQUB &1f ; E-4
  EQUB &60 ; F-4
  EQUB &b5 ; F#4
  EQUB &1e ; G-4
  EQUB &9c ; G#4
  EQUB &31 ; A-4
  EQUB &df ; A#4
  EQUB &a5 ; B-4

  EQUB &87 ; C-5
  EQUB &86 ; C#5
  EQUB &a2 ; D-5
  EQUB &df ; D#5
  EQUB &3e ; E-5
  EQUB &c1 ; F-5
  EQUB &6b ; F#5
  EQUB &3c ; G-5
  EQUB &39 ; G#5
  EQUB &63 ; A-5
  EQUB &be ; A#5
  EQUB &4b ; B-5

  EQUB &0f ; C-6
  EQUB &0c ; C#6
  EQUB &45 ; D-6
  EQUB &bf ; D#6
  EQUB &7d ; E-6
  EQUB &83 ; F-6
  EQUB &d6 ; F#6
  EQUB &79 ; G-6
  EQUB &73 ; G#6
  EQUB &c7 ; A-6
  EQUB &7c ; A#6
  EQUB &97 ; B-6

  EQUB &1e ; C-7
  EQUB &18 ; C#7
  EQUB &8b ; D-7
  EQUB &7e ; D#7
  EQUB &fa ; E-7
  EQUB &06 ; F-7
  EQUB &ac ; F#7
  EQUB &f3 ; G-7
  EQUB &e6 ; G#7
  EQUB &8f ; A-7
  EQUB &f8 ; A#7
  EQUB &2e ; B-7
}
