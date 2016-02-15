; Shortcuts for:
; - Babun shell - Capslock + z
; - Chrome / new tab - Capslock + f / Capslock + t
; - Sublime Text - Capslock + e
; - Visual Studio - Capslock + v
; Note: use WinWaitActive after WinActivate if needed

#Persistent
SetCapsLockState, AlwaysOff

; Babun shell
Capslock & z up::
SetTitleMatchMode, 2
If WinExist("ahk_class mintty")
{
	ifWinNotActive,ahk_class mintty
	{
		WinActivate,ahk_class mintty
	}
}
else
{
	Run "%USERPROFILE%\.babun\cygwin\bin\mintty.exe" -
	Sleep 100
	WinActivate
}
return

; Chrome
Capslock & f up::
SetTitleMatchMode, 2
If WinExist("ahk_class Chrome_WidgetWin_1")
{
	ifWinNotActive,ahk_class Chrome_WidgetWin_1
	{
		WinActivate,ahk_class Chrome_WidgetWin_1
	}
}
else
{
	Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	Sleep 100
	WinActivate
}
return

; Chrome - new tab
Capslock & t up::
SetTitleMatchMode, 2
If WinExist("ahk_class Chrome_WidgetWin_1")
{
	ifWinNotActive,ahk_class Chrome_WidgetWin_1
	{
		WinActivate,ahk_class Chrome_WidgetWin_1
	}
	Send, ^t ; shortcut for new tab
}
else
{
	Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	Sleep 100
	WinActivate
}
return

; SublimeText
Capslock & e up::
SetTitleMatchMode, 2
If WinExist("ahk_class PX_WINDOW_CLASS")
{
	ifWinNotActive,ahk_class PX_WINDOW_CLASS
	{
		WinActivate,ahk_class PX_WINDOW_CLASS
	}
}
return

; VisualStudio
Capslock & v up::
SetTitleMatchMode, 2
If WinExist("ahk_exe devenv.exe")
{
	ifWinNotActive,ahk_exe devenv.exe
	{
		WinActivate,ahk_exe devenv.exe
	}
}
return
