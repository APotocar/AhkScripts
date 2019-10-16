#SingleInstance force
#InstallKeybdHook
#InstallMouseHook
#Persistent
GroupAdd, Games, ahk_exe csgo.exe
GroupAdd, Games, ahk_exe SaintsRowIV.exe
GroupAdd, Games, ahk_exe javaw.exe
GroupAdd, Games, ahk_exe destiny2.exe
SetCapsLockState, Off
width := A_ScreenWidth - 202
height := A_ScreenHeight - 70
PC := 1

CoordMode, Mouse, Relative
TrayTip, , Script Launched, 16
SetTimer, HideTrayTip, -3000
SetTitleMatchMode, 2
SetTimer, Playlist, 180000
onTop := 0
volume := 0

send {F22}        ;Uporabljaš samo če uporabljaš Volume UP/DOWN keye!

Playlist:
    If WinExist("VLC media player")
    {
        if WinExist("AltrPlaylist")
            WinClose
        WinGetTitle, Song, VLC media player
        StringTrimRight, Song, Song, 19
        FormatTime, FormatedTime, , 
        FileAppend, %FormatedTime% - %song%`n, AltrPlaylist.txt
        Playlist := 0
        Return
    }

>^Insert::
    Run, nircmd.exe muteappvolume GTA5.exe 2, C:\ ; Mute GTAV
    Run, nircmd.exe muteappvolume GTAVLauncher.exe 2, C:\ ; Mute GTAV
    Return

#IfWinActive ahk_exe explorer.exe
^Backspace::
    Send ^+{Left} {Backspace}
    Return
#IfWinActive


#IfWinNotActive, ahk_group Games
^Space::
        Winset, Alwaysontop, , A
        onTop := !onTop
        if (onTop = 1)
        {
            TrayTip, , Window now on top %onTop%
            SetTimer, HideTrayTip, -1000
            return
        }
        else
        {
            TrayTip, , Window not on top %onTop%
            SetTimer, HideTrayTip, -1000
            return
        }
#IfWinActive

HideTrayTip:
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
    Return

>^Home::
    SendMessage 0x112, 0xF170, 2, , Program Manager  ; Monitor off
    Return

#IfWinNotActive, ahk_group Games
F4::
    if WinActive("ahk_exe Explorer.exe")
    {
        Run, "shell:startup"
        Return
    }
    Else
    {
        TrayTip, ,Explorer must be active
        Return
    }

F3::
    Run, WindowSpy.ahk, C:\Program Files\AutoHotkey
    return
#IfWinActive

>^Numpad0::
    Run, Test script.ahk, %A_Desktop%
    return

>^End::
    Reload
    return

>^Numpad3::
    if WinExist("ahk_exe vlc.exe")
    {
        WinGetTitle, songname, VLC media player
        StringTrimRight, songname, songname, 19
        TrayTip, Now playing, %songname%, , 17
        FormatTime, FormatedTime, , 
        FileAppend, %FormatedTime% - %songname% [CHECKED]`n, AltrPlaylist.txt
        return
    }
    else
        return

<^+Home::
    Run shutdown.exe /s /t 0, %windir%\System32\

>^NumpadDot::
    if !WinExist("ahk_exe vlc.exe")
    {
        Run, Altr.pls, %A_Desktop%, Min
        return
    }
    else 
    {   
        WinKill, VLC media player
        return
    }
/*
~*Volume_Up::
    if (volume >= 12)
        return
    else
    {
        volume := volume + 2
        TrayTip,, %volume%, , 17
        ;Send {Volume_Up}
        return
    }

~*Volume_Down::
    if (volume <= -60)
        return
    else
    {
        volume := volume - 2
        TrayTip,, %volume%, , 17
        ;Send {Volume_Down}
        return
    }
*/
~>+N::
    Send {Media_Next}
    return

#if PC = 1
~<^NumpadIns::
    Send {Media_Play_Pause}
    return

~<^Left::
    Send {Media_Prev}
    return


~<^Down::
if (volume <= -60)
        return
    else
    {
        volume := volume - 2
        TrayTip,, %volume%, , 17
        Send {Volume_Down}
        return
    }

~<^Up::
    if (volume >= 12)
        return
    else
    {
        volume := volume + 2
        TrayTip,, %volume%, , 17
        Send {Volume_Up}
        return
    }
#If

~*CapsLock::
    Sleep, 100
    if GetKeyState("CapsLock", "T")
        {
            Progress, B1 W200 H28 ZH0 FS11 WS900 x%width% y%height% CTFF0000, CAPS LOCK ON
            return
        }
    else
        {
            Progress, off
            return
        }
