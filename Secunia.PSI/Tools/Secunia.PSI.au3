;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "")
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="PSI Setup"

WinWaitActive("Installer Language", "Please select a language")
Send("{ENTER}")
WinWaitActive($title, "Welcome to the PSI Setup")
Send("!n")
WinWaitActive($title, "License Agreement")
Send("!a")
Send("!n")
WinWaitActive($title, "Automatic Update Configuration")
Send("{DOWN}")
Send("{DOWN}")
Send("!n")
WinWaitActive($title, "Completing the PSI Setup")
Send("{ENTER}")
WinWaitActive($title, "Would you like to launch Secunia PSI now")
Send("!n")

;Installation complete
Exit
