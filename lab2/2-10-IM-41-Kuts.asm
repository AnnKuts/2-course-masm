.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\msvcrt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib
includelib \masm32\lib\msvcrt.lib

add_int_line PROTO :DWORD, :DWORD
add_float_line PROTO :DWORD, :REAL8

.data
    ; Константи
    a_byte          db 3            ; Byte
    a_byte_neg      db -3
    a_word          dw 3            ; Word
    a_word_neg      dw -3
    a_dword         dd 3            ; Dword
    a_dword_neg     dd -3
    a_qword         dq 3            ; Qword
    a_qword_neg     dq -3

    b_word          dw 312          ; Word
    b_word_neg      dw -312
    b_dword         dd 312          ; Dword
    b_dword_neg     dd -312
    b_qword         dq 312          ; Qword
    b_qword_neg     dq -312

    c_dword         dd 3122007      ; Dword
    c_dword_neg     dd -3122007
    c_qword         dq 3122007      ; Qword
    c_qword_neg     dq -3122007

    d_single        dd 0.001        ; Single
    d_single_neg    dd -0.001
    e_double        dq 0.076        ; Double
    e_double_neg    dq -0.076
    f_extended      dt 759.612      ; Extended
    f_extended_neg  dt -759.612

    ; Вихідні значення
    a_val           dd 3            ; Dword
    b_val           dd 312          ; Dword
    c_val           dd 3122007      ; Dword
    d_val           dq 0.001        ; Qword
    e_val           dq 0.076        ; Qword
    f_val           dq 759.612      ; Qword

    fmt_int         db "%s %d", 13, 10, 0
    fmt_float       db "%s %.3f", 13, 10, 0
    str_title       db "Лабораторна 2", 0
    
    str_line_1      db "ПІБ: Куц Анна Василівна", 13, 10, 0
    str_line_2      db " Варіант: 10:", 13, 10, 0
    str_line_3      db "Дата народження: 03.12.2007", 13, 10, 0
    str_line_4      db " Номер залікової книжки: 4110:", 13, 10, 0
    str_line_5      db " Константи:", 13, 10, 0
    
    label_a_pos     db " +A:", 0
    label_a_neg     db " -A:", 0
    label_b_pos     db " +B:", 0
    label_c_pos     db " +C:", 0
    label_c_neg     db " -C:", 0
    label_d_pos     db " +D:", 0
    label_d_neg     db " -D:", 0
    label_e_pos     db " +E:", 0
    label_e_neg     db " -E:", 0
    label_f_pos     db " +F:", 0
    label_f_neg     db " -F:", 0

.data?
    buffer_main     db 2048 dup(?)
    buffer_temp     db 128 dup(?)

.code
main:
    invoke crt_strcpy, addr buffer_main, addr str_line_1
    invoke crt_strcat, addr buffer_main, addr str_line_2
    invoke crt_strcat, addr buffer_main, addr str_line_3
    invoke crt_strcat, addr buffer_main, addr str_line_4
    invoke crt_strcat, addr buffer_main, addr str_line_5

    invoke add_int_line, addr label_a_pos, a_val
    
    mov eax, a_val
    neg eax
    invoke add_int_line, addr label_a_neg, eax
    
    invoke add_int_line, addr label_b_pos, b_val
    invoke add_int_line, addr label_c_pos, c_val
    
    mov eax, c_val
    neg eax
    invoke add_int_line, addr label_c_neg, eax

    invoke add_float_line, addr label_d_pos, d_val
    
    fld d_val
    fchs             
    sub esp, 8
    fstp qword ptr [esp]
    invoke add_float_line, addr label_d_neg, qword ptr [esp]
    add esp, 8

    invoke add_float_line, addr label_e_pos, e_val
    
    fld e_val
    fchs             
    sub esp, 8
    fstp qword ptr [esp]
    invoke add_float_line, addr label_e_neg, qword ptr [esp]
    add esp, 8

    invoke add_float_line, addr label_f_pos, f_val
    
    fld f_val
    fchs             
    sub esp, 8
    fstp qword ptr [esp]
    invoke add_float_line, addr label_f_neg, qword ptr [esp]
    add esp, 8

    invoke MessageBoxA, NULL, addr buffer_main, addr str_title, MB_OK
    invoke ExitProcess, 0

add_int_line proc lbl_ptr:DWORD, val_int:DWORD
    invoke crt_sprintf, addr buffer_temp, addr fmt_int, lbl_ptr, val_int
    invoke crt_strcat, addr buffer_main, addr buffer_temp
    ret
add_int_line endp

add_float_line proc lbl_ptr:DWORD, val_float:REAL8
    invoke crt_sprintf, addr buffer_temp, addr fmt_float, lbl_ptr, val_float
    invoke crt_strcat, addr buffer_main, addr buffer_temp
    ret
add_float_line endp

end main