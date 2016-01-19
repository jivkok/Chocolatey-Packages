; Windows-Shift-T: launches new SublimeText instance or activates existing one
#+t::
If WinExist("ahk_class PX_WINDOW_CLASS")
{
	ifWinNotActive,ahk_class PX_WINDOW_CLASS
	{
		WinActivate,ahk_class PX_WINDOW_CLASS
		WinWaitActive
	}
}
else
{
	Run "%ProgramW6432%\Sublime Text 3\sublime_text.exe"
	Sleep 100
	WinActivate
	WinWaitActive
}
return

; Windows-Shift-G: launches new Chrome instance or activates existing one
#+g::
SetTitleMatchMode, 2
If WinExist("ahk_class Chrome_WidgetWin_1")
{
	ifWinNotActive,ahk_class Chrome_WidgetWin_1
	{
		WinActivate,ahk_class Chrome_WidgetWin_1
		WinWaitActive
	}
}
else
{
	Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	Sleep 100
	WinActivate
	WinWaitActive
}
return

; Windows-Shift-S: launches new Chrome instance or activates existing one (and opens new tab)
#+s::
SetTitleMatchMode, 2
If WinExist("ahk_class Chrome_WidgetWin_1")
{
	ifWinNotActive,ahk_class Chrome_WidgetWin_1
	{
		WinActivate,ahk_class Chrome_WidgetWin_1
		WinWaitActive
	}
	Send, ^t ; shortcut for new tab
}
else
{
	Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
	Sleep 100
	WinActivate
	WinWaitActive
}
return

; Windows-Shift-Z: Babun's shell
#+z::
SetTitleMatchMode, 2
If WinExist("ahk_class mintty")
{
	ifWinNotActive,ahk_class mintty
	{
		WinActivate,ahk_class mintty
		WinWaitActive
	}
}
else
{
	Run "%USERPROFILE%\.babun\cygwin\bin\mintty.exe" -
	Sleep 100
	WinActivate
	WinWaitActive
}
return
