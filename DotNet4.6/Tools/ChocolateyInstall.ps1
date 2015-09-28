Function IsInstalled {
    $ver = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full').Release
    return (!($ver -eq $null) -and ($ver -ge 393295))
}

if (IsInstalled) {
    Write-Host "Microsoft .NET Framework 4.6 or later is already installed"
}
else {
    $packageName = 'DotNet46'
    $installerType = 'exe'
    $Url = 'http://download.microsoft.com/download/C/3/A/C3A5200B-D33C-47E9-9D70-2F7C65DAAD94/NDP46-KB3045557-x86-x64-AllOS-ENU.exe'
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
