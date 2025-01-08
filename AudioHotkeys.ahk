#Requires AutoHotkey v2+
#SingleInstance Force

MediaAudio := ["spotify.exe", "chrome.exe", "firefox.exe"]
ChatAudio := ["discord.exe, zoom.exe"]

AudioStep := 0.05
ToggleMute := 2 ; Argument for switching mute status to opposite one

DiscordDisconnectKeybind := "^!{F9}"
DiscordToggleDeafenKeybind := "^!{F10}"
DiscordToggleMuteKeybind := "^!{F11}"
InstantReplayKeybind := "^!{F12}"


; Alt + FXX is used rather than F13-F24 as otherwise, Ctrl + FXX would cause these to run
!F13::AdjustTargetVolumes(MediaAudio, -AudioStep)
!F14::AdjustTargetVolumes(MediaAudio, +AudioStep)
!F15::MuteTargetVolumes(MediaAudio)
!F16::AdjustTargetVolumes(ChatAudio, -AudioStep)


!F17::AdjustTargetVolumes(ChatAudio, +AudioStep)

; AHK has 'focused' as an option but it doesn't seem to work on most apps, such as chrome.exe
; Currently does not work for games, investigating why
!F18:: {
    ProcessName := WinGetProcessName("A")
    Run("nircmd.exe changeappvolume " ProcessName " " . -AudioStep, , "Hide") 
}

!F19:: {
    ProcessName := WinGetProcessName("A")
    Run("nircmd.exe changeappvolume " ProcessName " " . +AudioStep, , "Hide")
}

!F20:: {
    ProcessName := WinGetProcessName("A")
    MsgBox(ProcessName)
    Run("nircmd.exe muteappvolume " ProcessName " " ToggleMute, , "Hide")
}

!F21:: {
    
}
!F22::Run "code.exe"
!F23::Run "explorer"
!F24::Run "chrome.exe https://www.google.com --new-window"



^F13:: {
}

^F14:: {
}

^F15:: {
}

^F16:: {
}


^F17::SendInput("{Volume_Mute}")
^F18::SendInput("{Media_Prev}")
^F19::SendInput("{Media_Next}")
^F20::SendInput("{Media_Play_Pause}")

^F21::SendInput(DiscordDisconnectKeybind)
^F22::SendInput(DiscordToggleDeafenKeybind)
^F23::SendInput(DiscordToggleMuteKeybind)
^F24::SendInput(InstantReplayKeybind)


AdjustTargetVolumes(appList, change) {
    for _, app in appList {
        Run("nircmd.exe changeappvolume " app " " change, , "Hide")
    }
}

MuteTargetVolumes(appList) {
    for _, app in appList {
        Run("nircmd.exe muteappvolume " app " " ToggleMute, , "Hide")
    }
}