#SingleInstance force
DetectHiddenWindows, off 
SetControlDelay -1
SetTitleMatchMode, 2
if A_Args.Length() != 5
{
    MsgBox % "This script requires 5 parameters but it received " A_Args.Length() "."
    ExitApp
}
if WinExist("ahk_exe TGA2AVI.exe")
    WinActivate
Else
    Run, TGA2AVI, C:\
WinWaitActive, TGA2AVI
if ErrorLevel
{
    MsgBox, "TGA2AVI not opened, try again"
    ExitApp
}

If WinExist("ahk_exe TGA2AVI.exe")
    WinActivate
Else
    ExitApp

ControlClick, Button2, TGA2AVI
Send {Enter}
WinWaitActive, Add Image Files Sequence

filepath := A_Args[1]
Targetframe := A_Args[2]
framenum := A_Args[2]
CurrentFrame := A_Args[2]
framelength := A_Args[3]
targetFile := A_Args[4]
targetName := A_Args [5]

Send %filepath%
Send {Enter}

if WinExist("ahk_exe TGA2AVI.exe")
    WinActivate
Else
    ExitApp

timeout := 10
While(timeout != 0)
{
    SetTimer, UpdateTimeout, 10
    Sleep, 1000
    timeout--
}
SetTimer, UpdateTimeout, Delete
ToolTip
if WinExist("ahk_exe TGA2AVI.exe")
    WinActivate
Else
    ExitApp

ToolTip,Current Frame is: %framenum%`nTarget Frame is: %Targetframe%`nSelected Frame Legth is: %framelength%`nMade by Anže Potočar
While(framenum != 1)
{
    SetTimer, UpdateInfo, 25
    Send {Down}
    sleep, 50
    framenum--
}
SetTimer, UpdateInfo, Delete
ToolTip
ControlClick, Edit..., TGA2AVI
WinWaitActive, Edit Duration, , 5
if ErrorLevel
{  
    Send {Enter}
    Sleep, 50
    Return
}
ControlClick, Edit1, Edit Duration
Send {BackSpace}
Send %framelength%
Send {Enter}
ControlClick, Generate, TGA2AVI
WinWaitActive, Select *.avi file, , 5
if ErrorLevel
{  
    Send {Enter}
    Sleep, 50
    Return
}
Send %targetFile%\%targetName%
Send {Enter}
ExitApp
Esc::ExitApp

;   D:\Google Drive\Multimedija\Grafike\ICF Grafike\Credits - After Effects\Main Comp\Main Comp_00000.png..245..456

UpdateTimeout:
ToolTip, Prooceeding in %timeout%s
return

UpdateInfo:
CurrentFrame := Targetframe - framenum + 1
ToolTip,Current Frame is: %CurrentFrame%`nTarget Frame is: %Targetframe%`nSelected Frame Legth is: %framelength%`nMade by Anže Potočar
return