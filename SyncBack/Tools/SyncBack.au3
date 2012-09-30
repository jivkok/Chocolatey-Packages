;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "", @SW_HIDE)
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="Setup - SyncBack"
;Wait for the installation to complete and the Dropbox account entry dialog to appear, close the window
WinWaitActive($title, "Welcome to the SyncBack Setup Wizard")
Send("!n")
WinWaitActive("Setup - SyncBack", "License Agreement")
Send("!a")
Send("!n")
WinWaitActive("Setup - SyncBack", "Please read the following important information before continuing")
Send("!n")
WinWaitActive("Setup - SyncBack", "Select Destination Location")
Send("!n")
WinWaitActive("Setup - SyncBack", "Select Start Menu Folder")
Send("!n")
WinWaitActive("Setup - SyncBack", "Select Additional Tasks")
Send("!n")
WinWaitActive("Setup - SyncBack", "Ready to Install")
Send("!i")
WinWaitActive("Setup - SyncBack", "Introducing SyncBackSE")
Send("!n")
WinWaitActive("Setup - SyncBack", "Completing the SyncBack Setup Wizard")
Send("{SPACE}")
Send("{DOWN}")
Send("{DOWN}")
Send("{SPACE}")
Send("!F")

;Installation complete
Exit