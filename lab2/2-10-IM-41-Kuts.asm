.386

.model flat, stdcall

option casemap:none

include \masm32\include\windows.inc

include \masm32\include\kernel32.inc

include \masm32\include\user32.inc

includelib \masm32\lib\kernel32.lib

includelib \masm32\lib\user32.lib

.data
    msgText  db "ПІБ: Куц Анна Василівна",13,10
             db "Дата народження: 03.12.2007",13,10
             db " Константи:",13,10
             db " +A: 3",13,10
             db " -A: -3",13,10
             db " +B: 312",13,10
             db " +C: 3122007",13,10
             db " -C: -3122007",13,10
             db " +D: 0.001",13,10
             db " -D: -0.001",13,10
             db " +E: 0.076",13,10
             db " -E: -0.076",13,10
             db " +F: 759.612",13,10
             db " -F: -759.612",0
    msgTitle db "Лабораторна 1",0

.code
main:
    invoke MessageBoxA, NULL, addr msgText, addr msgTitle, MB_OK
    
    invoke ExitProcess, 0
end main