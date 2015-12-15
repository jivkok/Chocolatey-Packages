Function IsInstalled {
    $ver = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full').Release
    return (!($ver -eq $null) -and ($ver -ge 394254))
}

if (IsInstalled) {
    Write-Host "Microsoft .NET Framework 4.6 or later is already installed"
}
else {
    $packageName = 'DotNet46'
    $installerType = 'exe'
    $Url = 'https://download.microsoft.com/download/E/4/1/E4173890-A24A-4936-9FC9-AF930FE3FA40/NDP461-KB3102436-x86-x64-AllOS-ENU.exe'
    $silentArgs = "/Passive /NoRestart /Log ""$env:temp\net46.log"""
    $validExitCodes = @(
        0, # success
        3010 # success, restart required
    )

    Install-ChocolateyPackage $packageName $installerType $silentArgs $Url -validExitCodes $validExitCodes

    if (-Not (IsInstalled)) {
        Write-Host "A restart is required to finalise the Microsoft .NET Framework 4.6 installation"
    }
}
