; Scripts for dealing with locking and sleeping computer, windows is shit and ignores sleep settings often so this is used to when windows + L is pressed (standard lock keycombo)
;


#l:: ;Win+L
  CloseOBS() ; this is due to for some reason on my system sleeping pc causes a memory leak in obs, so this closes it
  RunOBSOpenerIfNotRunning() ; due to said above memory leak this runs another script to open a shortcut .lnk file to it with the params(for some reason it doesnt liek running directly from ahk)
  Sleep, 3000
  DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0);
  Return


CloseOBS() {
    Process, Exist, obs64.exe
    if (ErrorLevel != 0) {
        Process, Close, obs64.exe
        OutputDebug, Force closed obs64.exe (PID: %ErrorLevel%)
    }

    Process, Exist, obs32.exe
    if (ErrorLevel != 0) {
        Process, Close, obs32.exe
        OutputDebug, Force closed obs32.exe (PID: %ErrorLevel%)
    }

    Process, Exist, obs.exe
    if (ErrorLevel != 0) {
        Process, Close, obs.exe
        OutputDebug, Force closed obs.exe (PID: %ErrorLevel%)
    }
    Return
}


; Pretty self explanitory, checks if its running already from the auto runs path and if it isnt opens it, shouldnt need to adjust path per user unless you dont want it to auto run on first login
RunOBSOpenerIfNotRunning() {
    Process, Exist, AutoHotkey.exe
    if !ErrorLevel {
        Run, %appdata%\Microsoft\Windows\Start Menu\Programs\Startup\OBSOpener.ahk
    } else {
        WinGet, List, List, ahk_exe AutoHotkey.exe
        Loop, %List% {
            WinGet, PID, PID, % "ahk_id" List%A_Index%
            WinGet, ProcessPath, ProcessPath, ahk_pid%PID%
            if InStr(ProcessPath, "OBSOpener.ahk") {
                return ; Already running
            }
        }
        Run, %appdata%\Microsoft\Windows\Start Menu\Programs\Startup\OBSOpener.ahk
    }

}
