;A few functions for manipulating windows as needed

; Sets current window to always on top
^!SPACE::
Winset, Alwaysontop, , A
return

; Calls centerscreen twice due to sometimes some programs dont center the first time correctly and doing it again fixes it
#numpad5::                                  ; Windows+ Numpad5
    centerscreen()
    Sleep, 500
    centerscreen()
return

; Centers the window to the middle 16:9 of a 32:9 screen and then turns it borderless, mainly used for games that dont support custom resolutions for borderless
; (I use mainly for blazeblue centralfiction)
; In most cases setting the screen mode to windowed instead of borderless or fullscreen yeilds the best results
centerscreen(){
    WinRestore, A                           ; Restore the active window if minimized/maximized
    WinMove, A, , 1280, 0, 2560, 1440       ; movees window to center of 32:9 1440p screen, can modify for your own resolution
    WinSet, AlwaysOnTop, , A
    WinGet, id1, ID, A                      ; Get the window ID of active window
    WinSet, Style, -0xC00000, ahk_id %id1%  ; Remove title bar from window
    WinSet, Style, ^0x40000, ahk_id %id1%   ; Toggle border style
    WinMinimize, ahk_id %id1%               ; cycles activating to apply to trickier programs
    WinActivate, ahk_id %id1%               ; same as above
    }