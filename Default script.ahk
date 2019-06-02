#SingleInstance force

SetTitleMatchMode, 2
SetTimer, Playlist, 180000

Playlist:
If WinExist("VLC media player")
{
    WinGetTitle, Song, VLC media player
    StringTrimRight, Song, Song, 19
    FormatTime, FormatedTime, , 
    FileAppend, %FormatedTime% - %song%`n, AltrPlaylist.txt
    Return
}

>^Insert::
    Run, nircmd.exe muteappvolume GTA5.exe 2, C:\ ; Mute GTAV
    Return

^Space:: 
    Winset, Alwaysontop, , A 
    Return

>^Home::
    SendMessage 0x112, 0xF170, 2, , Program Manager  ; Monitor off
    Return

F4::
    if WinActive("ahk_exe Explorer.exe")
    {
        Run, "C:\Users\Anže\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
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

>^Numpad0::
    Run, Test script.ahk, A_Desktop

>^End::
    Reload
    return

>^NumpadDot::
    Run, Altr, A_Desktop
    return