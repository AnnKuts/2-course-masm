OPTION DOTNAME
option casemap:none

extern MessageBoxA:proc
extern ExitProcess:proc

MB_YESNO equ 4
MB_ICONQUESTION equ 32

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
main proc
sub rsp, 28h
xor rcx, rcx
lea rdx, msgText
lea r8,  msgTitle
mov r9d, MB_YESNO or MB_ICONQUESTION
call MessageBoxA
xor ecx, ecx
call ExitProcess

main endp
end
