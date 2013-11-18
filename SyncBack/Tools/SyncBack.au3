;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "", @SW_HIDE)
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="Setup - SyncBackFree"
WinWaitActive($title, "License Agreement")
Send("!a")
Send("!n")
WinWaitActive($title, "Please read the following important information before continuing")
Send("!n")
WinWaitActive($title, "Select Destination Location")
Send("!n")
WinWaitActive($title, "Completing the")
Send("{SPACE}")
Send("{DOWN}")
Send("{DOWN}")
Send("{SPACE}")
Send("!F")

;Installation complete
Exit
