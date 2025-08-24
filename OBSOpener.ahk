; I barely undrestand how this script works due to it just being alot of copy pasting from stack overflow, but it does, might be a better way of doing it but idk or care

#NoEnv
#SingleInstance Force
#Persistent

; Register for Windows session change notifications
DllCall("wtsapi32\WTSRegisterSessionNotification", "Ptr", A_ScriptHwnd, "UInt", 0)

; Handle session change messages
OnMessage(0x02B1, "OnSessionChange")

OnSessionChange(wParam, lParam) {
    if (wParam = 0x8) { ; Session unlock event
        OnUnlock()
    }
}

OnUnlock() {
    Run, %appdata%\Microsoft\Windows\Start Menu\Programs\Startup\OBSStudio(64bit)
}

; Clean up on exit
OnExit("Cleanup")

Cleanup() {
    DllCall("wtsapi32\WTSUnRegisterSessionNotification", "Ptr", A_ScriptHwnd)
}