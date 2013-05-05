;Path and filename of the installer executable
$InstallPackage="""" & $CmdLine[1] & """"

; Run installer
Run($InstallPackage, "", @SW_HIDE)
If @error <> 0  Then 
    MsgBox(0, "Run failed", "The ""Run"" command failed with error " & Hex(@error, 8) & " for " & $InstallPackage & " - exiting")
    Exit
EndIf

$title="Recuva v1.43 Setup"

WinWaitActive("Application Install", "SourceTree")
Send("!i")

;Installation complete
Exit
