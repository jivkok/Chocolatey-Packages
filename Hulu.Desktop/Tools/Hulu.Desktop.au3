;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "")
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="Hulu Desktop Setup"

WinWaitActive($title, "Welcome to Hulu Desktop")
Send("!n")
WinWaitActive($title, "End User License Agreement")
Send("!h")
Send("!n")
WinWaitActive($title, "Click Install to start the installation")
Send("!i")
WinWaitActive($title, "Completing the Hulu Desktop")
Send("!r")
Send("!a")
Send("!f")

;Installation complete
Exit
