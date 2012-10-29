;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "")
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="Setup"

WinWaitActive("Select Setup Language", "Select the language")
Send("{ENTER}")
WinWaitActive($title, "Welcome")
Send("!n")
WinWaitActive($title, "License Agreement")
Send("!a")
Send("!n")
WinWaitActive($title, "Select Destination Location")
Send("!n")
WinWaitActive($title, "Select Start Menu Folder")
Send("!n")
WinWaitActive($title, "Ready to Install")
Send("!i")
WinWaitActive($title, "Completing the Fitbit Data Uploader")
Send("!f")

;Installation complete
Exit
