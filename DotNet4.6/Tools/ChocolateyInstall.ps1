$test = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq 'Microsoft .NET Framework 4.6 RC Multi-Targeting Pack' } | Select-Object -First 1
if (!$test)
{
    $packageName = 'DotNet46'
    $installerType = 'exe'
    $32BitUrl  = 'http://download.microsoft.com/download/9/E/E/9EEF3485-8C04-47D0-93AF-7E0591AFED10/NDP46-KB3033092-Web.exe'
    $silentArgs = "/Passive /NoRestart /Log $env:temp\net46.log"
    $validExitCodes = @(
        0, # success
        3010 # success, restart required
    )

    Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes
}
else
{
    Write-Host "Microsoft .Net 4.6 Framework is already installed on your machine."
}
