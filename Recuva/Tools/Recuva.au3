;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage)
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="Recuva v"

WinWaitActive($title, "Welcome to the Recuva")
Send("!n")
WinWaitActive($title, "Install Options")
Send("!i")
WinWaitActive($title, "Completing the Recuva")
Send("!r")
Send("{TAB}")
Send("{SPACE}")
Send("!f")

;Installation complete
Exit
