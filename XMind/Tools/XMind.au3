;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "")
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="Setup - XMind"

WinWaitActive($title, "Welcome to the XMind Setup Wizard")
Send("!n")
WinWaitActive($title, "License Agreement")
Send("!a")
Send("!n")
WinWaitActive($title, "Select Destination Location")
Send("!n")
WinWaitActive($title, "Select Additional Tasks")
Send("!d")
Send("!q")
Send("!n")
WinWaitActive($title, "Ready to Install")
Send("!i")
WinWaitActive($title, "Completing the XMind Setup Wizard")
Send("{SPACE}")
Send("{DOWN}")
Send("{SPACE}")
Send("!f")

;Installation complete
Exit
