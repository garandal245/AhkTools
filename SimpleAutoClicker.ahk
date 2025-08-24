#NoEnv
#SingleInstance force
SetWorkingDir %A_ScriptDir%

; Configuration variables
global HoldTimeRequired := 200  ; Time to hold before starting to click (in milliseconds)
global ClickSpeed := 50         ; Click speed interval (in milliseconds)
global HoldCheckInterval := 10  ; How often to check if button is held (in milliseconds)

; 2 modes 1 for left 1 for right, both spamclick at the configured speed after holding for the required time
; to allow for actual computer use in the meantime, can be toggled on and off with win+ctrl+left/rightclick

global RightClickingEnabled := false
global LeftClickingEnabled := false
global RightClickingActive := false
global LeftClickingActive := false

;Win+Ctrl+right Click
#^RButton::
    RightClickingEnabled := !RightClickingEnabled

    if (RightClickingEnabled) {
        SetTimer, CheckRightButtonHold, %HoldCheckInterval%
        SoundPlay, *64
    } else {
        SetTimer, CheckRightButtonHold, Off
        SetTimer, RightClickSpam, Off
        RightClickingActive := false
        SoundPlay, *16
    }
return

;Win+Ctrl+left Click
#^LButton::
    LeftClickingEnabled := !LeftClickingEnabled

    if (LeftClickingEnabled) {
        SetTimer, CheckLeftButtonHold, %HoldCheckInterval%
        SoundPlay, *64
    } else {
        SetTimer, CheckLeftButtonHold, Off
        SetTimer, LeftClickSpam, Off
        LeftClickingActive := false
        SoundPlay, *16
    }
return

CheckRightButtonHold:
    if GetKeyState("RButton", "P") {
        if (RButtonPressTime = 0) {
            RButtonPressTime := A_TickCount
        }
        else if (A_TickCount - RButtonPressTime > HoldTimeRequired && !RightClickingActive) {
            ; Start the clicking timer
            RightClickingActive := true
            SetTimer, RightClickSpam, %ClickSpeed%
        }
    } else {
        RButtonPressTime := 0
        if (RightClickingActive) {
            RightClickingActive := false
            SetTimer, RightClickSpam, Off
        }
    }
return

CheckLeftButtonHold:
    if GetKeyState("LButton", "P") {
        if (LButtonPressTime = 0) {
            LButtonPressTime := A_TickCount
        }
        else if (A_TickCount - LButtonPressTime > HoldTimeRequired && !LeftClickingActive) {
            ; Start the clicking timer
            LeftClickingActive := true
            SetTimer, LeftClickSpam, %ClickSpeed%
        }
    } else {
        LButtonPressTime := 0
        if (LeftClickingActive) {
            LeftClickingActive := false
            SetTimer, LeftClickSpam, Off
        }
    }
return

RightClickSpam:
    if GetKeyState("RButton", "P") && RightClickingActive {
        Click, right
    }
return

LeftClickSpam:
    if GetKeyState("LButton", "P") && LeftClickingActive {
        Click, left
    }
return