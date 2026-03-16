.386
.model flat, stdcall
option casemap:none

include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\user32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
ClassName db "InputBoxClass",0
AppName db "Введіть пароль",0
ButtonClassName db "BUTTON",0
ButtonText db "OK",0
EditClassName db "EDIT",0

wrong_pass_msg db "Пароль неправильний!",0
key db 23h,45h,12h,9Ah,0Fh,77h,31h,0ABh,55h,66h,10h,20h
real_password db 42h,2Bh,7Ch,0FBh,64h,02h,45h,0D8h,0

msgText db "ПІБ: Куц Анна Василівна",13,10
        db "Дата народження: 03.12.2007",13,10
        db "Номер залікової книжки: 4110",0

msgTitle db "Лабораторна 3",0
msgErrTitle db "Помилка",0

.data?
hInstance HINSTANCE ?
hwndEdit HWND ?
user_password db 256 dup(?)

.code
start:
    invoke GetModuleHandle, NULL
    mov hInstance, eax
    call WinMain
    invoke ExitProcess, eax

WinMain proc
    LOCAL wc:WNDCLASSEX
    LOCAL msg:MSG
    LOCAL hwnd:HWND

    mov wc.cbSize, SIZEOF WNDCLASSEX
    mov wc.style, CS_HREDRAW or CS_VREDRAW
    mov wc.lpfnWndProc, OFFSET WndProc
    mov wc.cbClsExtra, 0
    mov wc.cbWndExtra, 0
    push hInstance
    pop wc.hInstance
    mov wc.hbrBackground, COLOR_BTNFACE+1
    mov wc.lpszMenuName, NULL
    mov wc.lpszClassName, OFFSET ClassName
    invoke LoadIcon, NULL, IDI_APPLICATION
    mov wc.hIcon, eax
    mov wc.hIconSm, eax
    invoke LoadCursor, NULL, IDC_ARROW
    mov wc.hCursor, eax
    invoke RegisterClassEx, addr wc

    invoke CreateWindowEx, WS_EX_CLIENTEDGE, addr ClassName, addr AppName, \
           WS_OVERLAPPEDWINDOW - WS_MAXIMIZEBOX - WS_SIZEBOX, \
           CW_USEDEFAULT, CW_USEDEFAULT, 300, 150, NULL, NULL, hInstance, NULL
    mov hwnd, eax

    invoke ShowWindow, hwnd, SW_SHOWNORMAL
    invoke UpdateWindow, hwnd

    MessageLoop:
        invoke GetMessage, addr msg, NULL, 0, 0
        cmp eax, 0
        je ExitLoop
        invoke TranslateMessage, addr msg
        invoke DispatchMessage, addr msg
        jmp MessageLoop
    ExitLoop:
        mov eax, msg.wParam
        ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
    .if uMsg == WM_CREATE
        invoke CreateWindowEx, WS_EX_CLIENTEDGE, addr EditClassName, NULL, \
               WS_CHILD or WS_VISIBLE or WS_BORDER or ES_AUTOHSCROLL, \
               20, 20, 240, 25, hWnd, 1001, hInstance, NULL
        mov hwndEdit, eax
        
        invoke CreateWindowEx, 0, addr ButtonClassName, addr ButtonText, \
               WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON, \
               100, 60, 80, 30, hWnd, 1002, hInstance, NULL

    .elseif uMsg == WM_COMMAND
        mov eax, wParam
        .if ax == 1002
            invoke GetWindowText, hwndEdit, addr user_password, 256
            
            lea esi, user_password
            lea edi, real_password
            xor ecx, ecx
            
        check_loop:
            mov al, [esi+ecx]
            mov bl, [edi+ecx]
            cmp al, 0
            je check_end
            
            xor al, byte ptr [key+ecx]
            cmp al, bl
            jne wrong_password
            
            inc ecx
            cmp ecx, 12
            je check_end
            jmp check_loop
            
        check_end:
            mov bl, [edi+ecx]
            cmp bl, 0
            je password_correct
            jmp wrong_password
            
        password_correct:
            invoke MessageBoxA, hWnd, addr msgText, addr msgTitle, MB_OK
            invoke PostQuitMessage, 0
            jmp finish_cmd
            
        wrong_password:
            invoke MessageBoxA, hWnd, addr wrong_pass_msg, addr msgErrTitle, MB_ICONERROR
            invoke PostQuitMessage, 0
            
        finish_cmd:
        .endif

    .elseif uMsg == WM_DESTROY
        invoke PostQuitMessage, 0
    .else
        invoke DefWindowProc, hWnd, uMsg, wParam, lParam
        ret
    .endif
    xor eax, eax
    ret
WndProc endp

end start