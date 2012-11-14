;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "")
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="XMind Setup"

WinWaitActive($title, "Welcome to the XMind Setup Wizard")
Send("!n")
WinWaitActive($title, "Choose Install Location")
Send("!n")
WinWaitActive($title, "File Association")
Send("!i")
WinWaitActive($title, "Installation Complete")
Send("!r")
Send("!s")
Send("!f")

;Installation complete
Exit
