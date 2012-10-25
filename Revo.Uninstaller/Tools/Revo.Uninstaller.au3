;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "", @SW_HIDE)
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="Revo Uninstaller 1.94 Setup"

WinWaitActive("Installer Language", "Please select a language")
Send("{ENTER}")
WinWaitActive($title, "Welcome to the Revo Uninstaller")
Send("!n")
WinWaitActive($title, "License Agreement")
Send("!a")
Send("!n")
WinWaitActive($title, "Install Location")
Send("!i")
WinWaitActive($title, "Completing the Revo Uninstaller")
Send("!r")
Send("!f")

;Installation complete
Exit
