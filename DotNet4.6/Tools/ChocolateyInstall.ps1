$test = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full').Release
if (!($test -eq $null) -and ($test -ge 393295))
{
    Write-Host "Microsoft .NET Framework 4.6 is already installed on your machine."
}
else
{
    $packageName = 'DotNet46'
    $installerType = 'exe'
    $32BitUrl  = 'http://download.microsoft.com/download/1/4/A/14A6C422-0D3C-4811-A31F-5EF91A83C368/NDP46-KB3045560-Web.exe'
    $silentArgs = "/Passive /NoRestart /Log ""$env:temp\net46.log"""
    $validExitCodes = @(
        0, # success
        3010 # success, restart required
    )

    Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes
}
