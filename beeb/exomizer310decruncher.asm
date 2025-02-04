;
; Copyright (c) 2002 - 2020 Magnus Lind.
;
; This software is provided 'as-is', without any express or implied warranty.
; In no event will the authors be held liable for any damages arising from
; the use of this software.
;
; Permission is granted to anyone to use this software for any purpose,
; including commercial applications, and to alter it and redistribute it
; freely, subject to the following restrictions:
;
;   1. The origin of this software must not be misrepresented; you must not
;   claim that you wrote the original software. If you use this software in a
;   product, an acknowledgment in the product documentation would be
;   appreciated but is not required.
;
;   2. Altered source versions must be plainly marked as such, and must not
;   be misrepresented as being the original software.
;
;   3. This notice may not be removed or altered from any distribution.
;
;   4. The names of this software and/or it's copyright holders may not be
;   used to endorse or promote products derived from this software without
;   specific prior written permission.
;
; -------------------------------------------------------------------
; Known quirks:
;  Can't handle a sequence reference that ends at $ffff. It is left in
;  since it is a corner case and fixing it impacts negatively on
;  performance or backwards compatibility.
;  A simple way to work around this is to not decrunch to address $ffff.

.get_crunched_byte_copy
{
        inc INPOS
        bne s0a
        inc INPOS+1

.s0a    rts
}
.get_crunched_byte_copy_end

IF get_crunched_byte_copy_end-get_crunched_byte_copy <> get_crunched_byte_code_end-get_crunched_byte_code
        ERROR "get_crunched_byte function size mismatch."
ENDIF

;; refill bits is always inlined
MACRO mac_refill_bits
        pha
        jsr get_crunched_byte
        rol a
        sta zp_bitbuf
        pla
ENDMACRO

IF INLINE_GET_BITS=1
MACRO mac_get_bits
{
        adc #$80                ; needs c=0, affects v
        asl a
        bpl gb_skip
.gb_next
        asl zp_bitbuf
        bne gb_ok
        mac_refill_bits
.gb_ok
        rol a
        bmi gb_next
.gb_skip
        bvc skip
.gb_get_hi
        sec
        sta zp_bits_hi
        jsr get_crunched_byte
.skip
}
ENDMACRO
ELSE
MACRO mac_get_bits
        jsr get_bits
ENDMACRO
ENDIF

MACRO mac_init_zp
{
; -------------------------------------------------------------------
; init zeropage and x reg. (8 bytes)
;
.init_zp
        jsr get_crunched_byte
        sta zp_bitbuf - 1,x
        dex
        bne init_zp
}
ENDMACRO

IF INLINE_GET_BITS = 0
.get_bits
        adc #$80                ; needs c=0, affects v
        asl a
        bpl gb_skip
.gb_next
        asl zp_bitbuf
        bne gb_ok
        mac_refill_bits
.gb_ok
        rol a
        bmi gb_next
.gb_skip
        bvs gb_get_hi
        rts
.gb_get_hi
        sec
        sta zp_bits_hi
        jmp get_crunched_byte
ENDIF
; -------------------------------------------------------------------
; no code below this comment has to be modified in order to generate
; a working decruncher of this source file.
; However, you may want to relocate the tables last in the file to a
; more suitable address.
; -------------------------------------------------------------------

; -------------------------------------------------------------------
; jsr this label to decrunch, it will in turn init the tables and
; call the decruncher
; no constraints on register content, however the
; decimal flag has to be cleared (it almost always is, otherwise do a cld)
.decrunch_to_page_A
; -------------------------------------------------------------------
; init zeropage and x reg. (8 bytes)
{
        ; -------------------------------------------------------------------
        pha ; Store page to decompress to
        stx INPOS ; Store pointer to source data (lo)
        sty INPOS+1 ; Store pointer to source data (hi)

        lda #$AD ; LDA abs
        sta get_crunched_byte
        ldx #get_crunched_byte_copy_end-get_crunched_byte_copy-1 ; 210227 0xC0DE: -1!!
.copyloop
        lda get_crunched_byte_copy,X
        sta get_crunched_byte_code,X
        dex
        bpl copyloop
        ; -------------------------------------------------------------------

IF ENABLE_SPLIT_ENCODING = 1
        ldx #3
        jsr internal_gentable
        jmp normal_decrunch
.split_gentable
        ldx #1
.internal_gentable
        jsr split_init_zp
ELSE
        ldx #3
        mac_init_zp
ENDIF

        ; -------------------------------------------------------------------
        ; allow relocation of destination
        clc
        pla
IF DECRUNCH_FORWARDS = 0
        adc zp_dest_hi
ENDIF
        sta zp_dest_hi
        ; -------------------------------------------------------------------

; -------------------------------------------------------------------
; calculate tables (64 bytes) + get_bits macro
; x must be #0 when entering
;
        ldy #0
        clc
.table_gen
        tax
        tya
        and #$0f
        sta tabl_lo,y
        beq shortcut            ; start a new sequence
; -------------------------------------------------------------------
        txa
        adc tabl_lo - 1,y
        sta tabl_lo,y
        lda zp_len_hi
        adc tabl_hi - 1,y
.shortcut
        sta tabl_hi,y
; -------------------------------------------------------------------
        lda #$01
        sta <zp_len_hi
        lda #$78                ; %01111000
        mac_get_bits
; -------------------------------------------------------------------
        lsr a
        tax
        beq rolled
        php
.rolle
        asl zp_len_hi
        sec
        ror a
        dex
        bne rolle
        plp
.rolled
        ror a
        sta tabl_bi,y
        bmi no_fixup_lohi
        lda zp_len_hi
        stx zp_len_hi
        equb $24
.no_fixup_lohi
        txa
; -------------------------------------------------------------------
        iny
        cpy #encoded_entries
        bne table_gen
; -------------------------------------------------------------------
IF ENABLE_SPLIT_ENCODING = 1
        rts
.split_decrunch
        ldx #3
        jsr split_init_zp
; X reg must be 0 here
        sec
.normal_decrunch
ENDIF
; -------------------------------------------------------------------
; prepare for main decruncher
IF DONT_REUSE_OFFSET = 0
        ror zp_ro_state
        sec
ENDIF
        ldy zp_dest_lo
        stx zp_dest_lo
        stx zp_bits_hi
; -------------------------------------------------------------------
; copy one literal byte to destination (11 bytes)
;
.literal_start1
IF DECRUNCH_FORWARDS = 0
        tya
        bne no_hi_decr
        dec zp_dest_hi
IF DONT_REUSE_OFFSET = 0
        dec zp_src_hi
ENDIF
.no_hi_decr
        dey
ENDIF
        jsr get_crunched_byte
        sta (zp_dest_lo),y
IF DECRUNCH_FORWARDS = 1
        iny
        bne skip_hi_incr
        inc zp_dest_hi
IF DONT_REUSE_OFFSET = 0
        inc zp_src_hi
ENDIF
.skip_hi_incr
ENDIF
; -------------------------------------------------------------------
; fetch sequence length index (15 bytes)
; x must be #0 when entering and contains the length index + 1
; when exiting or 0 for literal byte
.next_round
IF DONT_REUSE_OFFSET = 0
        ror zp_ro_state
ENDIF
        dex
        lda zp_bitbuf
.no_literal1
        asl a
        bne nofetch8
        jsr get_crunched_byte
        rol a
.nofetch8
        inx
        bcc no_literal1
        sta zp_bitbuf
; -------------------------------------------------------------------
; check for literal byte (2 bytes)
;
        beq literal_start1
; -------------------------------------------------------------------
; check for decrunch done and literal sequences (4 bytes)
;
        cpx #$11
IF INLINE_GET_BITS = 1
        bcc skip_jmp
        jmp exit_or_lit_seq
.skip_jmp
ELSE
        bcs exit_or_lit_seq
ENDIF
; -------------------------------------------------------------------
; calulate length of sequence (zp_len) (18(11) bytes) + get_bits macro
;
        lda tabl_bi - 1,x
        mac_get_bits
        adc tabl_lo - 1,x       ; we have now calculated zp_len_lo
        sta zp_len_lo
IF MAX_SEQUENCE_LENGTH_256 = 0
        lda zp_bits_hi
        adc tabl_hi - 1,x       ; c = 0 after this.
        sta zp_len_hi
; -------------------------------------------------------------------
; here we decide what offset table to use (27(26) bytes) + get_bits_nc macro
; z-flag reflects zp_len_hi here
;
        ldx zp_len_lo
ELSE
        tax
ENDIF
IF MAX_SEQUENCE_LENGTH_256 = 0
        lda #0
ENDIF
IF DONT_REUSE_OFFSET = 0
; -------------------------------------------------------------------
; here we decide to reuse latest offset or not (13(15) bytes)
;
        bit <zp_ro_state
        bmi test_reuse
.no_reuse
ENDIF
; -------------------------------------------------------------------
; here we decide what offset table to use (17(15) bytes)
;
IF MAX_SEQUENCE_LENGTH_256 = 0
        sta <zp_bits_hi
ENDIF
        lda #$e1
IF EXTRA_TABLE_ENTRY_FOR_LENGTH_THREE = 1
        cpx #$04
ELSE
        cpx #$03
ENDIF
        bcs gbnc2_next
        lda tabl_bit - 1,x
.gbnc2_next
        asl zp_bitbuf
        bne gbnc2_ok
        tax
        jsr get_crunched_byte
        rol a
        sta zp_bitbuf
        txa
.gbnc2_ok
        rol a
        bcs gbnc2_next
        tax
; -------------------------------------------------------------------
; calulate absolute offset (zp_src) (17 bytes) + get_bits macro
;
        lda tabl_bi,x
        mac_get_bits
IF DECRUNCH_FORWARDS = 0
        adc tabl_lo,x
        sta zp_src_lo
        lda zp_bits_hi
        adc tabl_hi,x
        adc zp_dest_hi
        sta zp_src_hi
ELSE
        clc
        adc tabl_lo,x
        eor #$ff
        sta zp_src_lo
        lda zp_bits_hi
        adc tabl_hi,x
        eor #$ff
        adc zp_dest_hi
        sta zp_src_hi
        clc
ENDIF
; -------------------------------------------------------------------
; prepare for copy loop (2 bytes)
;
        ldx zp_len_lo
; -------------------------------------------------------------------
; main copy loop (30 bytes)
;
.copy_next
IF DECRUNCH_FORWARDS = 0
        tya
        bne copy_skip_hi
        dec zp_dest_hi
        dec zp_src_hi
.copy_skip_hi
        dey
ENDIF
IF LITERAL_SEQUENCES_NOT_USED = 0
        bcs get_literal_byte
ENDIF
        lda (zp_src_lo),y
.literal_byte_gotten
        sta (zp_dest_lo),y
IF DECRUNCH_FORWARDS = 1
        iny
        bne copy_skip_hi
        inc zp_dest_hi
        inc zp_src_hi
.copy_skip_hi
ENDIF
        dex
        bne copy_next
IF MAX_SEQUENCE_LENGTH_256 = 0
        lda zp_len_hi
IF INLINE_GET_BITS = 1
        bne copy_next_hi
ENDIF
ENDIF
        stx zp_bits_hi
IF INLINE_GET_BITS=0
        beq next_round
ELSE
        jmp next_round
ENDIF
IF MAX_SEQUENCE_LENGTH_256 = 0
.copy_next_hi
        dec zp_len_hi
        jmp copy_next
ENDIF
IF DONT_REUSE_OFFSET = 0
; -------------------------------------------------------------------
; test for offset reuse (11 bytes)
;
.test_reuse
        bvs no_reuse
IF MAX_SEQUENCE_LENGTH_256 = 1
        lda #$00                ; fetch one bit
ENDIF
        asl zp_bitbuf
        bne gbnc1_ok
        pha
        jsr get_crunched_byte
        rol a
        sta zp_bitbuf
        pla
.gbnc1_ok
        rol a
        beq no_reuse            ; bit == 0 => C=0, no reuse
        bne copy_next           ; bit != 0 => C=0, reuse previous offset
ENDIF
; -------------------------------------------------------------------
; exit or literal sequence handling (16(12) bytes)
;
.exit_or_lit_seq
IF LITERAL_SEQUENCES_NOT_USED = 0
        beq decr_exit
        jsr get_crunched_byte
IF MAX_SEQUENCE_LENGTH_256 = 0
        sta zp_len_hi
ENDIF
        jsr get_crunched_byte
        tax
        bcs copy_next
.decr_exit
ENDIF
        rts
IF LITERAL_SEQUENCES_NOT_USED = 0
.get_literal_byte
        jsr get_crunched_byte
        bcs literal_byte_gotten
ENDIF
IF EXTRA_TABLE_ENTRY_FOR_LENGTH_THREE = 1
; -------------------------------------------------------------------
; the static stable used for bits+offset for lengths 1, 2 and 3 (3 bytes)
; bits 2, 4, 4 and offsets 64, 48, 32 corresponding to
; %10010000, %11100011, %11100010
.tabl_bit
        equb $90, $e3, $e2
ELSE
; -------------------------------------------------------------------
; the static stable used for bits+offset for lengths 1 and 2 (2 bytes)
; bits 2, 4 and offsets 48, 32 corresponding to %10001100, %11100010
.tabl_bit
        equb $8c, $e2
ENDIF

IF ENABLE_SPLIT_ENCODING = 1
.split_init_zp
        mac_init_zp
        rts
ENDIF

IF EXTRA_TABLE_ENTRY_FOR_LENGTH_THREE = 1
encoded_entries = 68
.decrunch_table SKIP 156 + (16*3)
ELSE
encoded_entries = 52
decrunch_table = $101 ; yes! we have enough stack space to use page 1 here
ENDIF

tabl_bi = decrunch_table
tabl_lo = decrunch_table + encoded_entries
tabl_hi = decrunch_table + encoded_entries * 2

; -------------------------------------------------------------------
; end of decruncher
; -------------------------------------------------------------------
}
