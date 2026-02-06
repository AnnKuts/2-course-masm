.386
.model flat, stdcall

option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
msgText db "ПІБ: Куц Анна Василівна",13,10
db "Дата народження: 03.12.2007",13,10
db "Улюблена виконавиця: Sabrina Carpenter",13,10
db "Улюблена пісня: Espresso",13,10
db "Улюблений рядок з пісні:",13,10
db "I'm working late, cause I'm a singer",13,10
db "(actually I'm a software engineer)",13,10
db "Улюблений мем:",13,10
db "Нашу милу, ніжну, добру душею",13,10
db "і надзвичайно щиру",13,10
db "Любов Степанівну ПРИБИЛО",13,10
db "Було дуже весело виконувати лабу <3",13,10
db "Як гадаєте, достатньо особистої інформації?",0
msgTitle db "Лабораторна 1",0

.code
main:
invoke MessageBoxA, NULL, addr msgText, addr msgTitle, MB_YESNO or MB_ICONQUESTION
invoke ExitProcess, 0
end main
