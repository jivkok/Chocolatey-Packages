$packageName = 'VisualStudio2015Ultimate'
$installerType = 'exe'
$32BitUrl  = 'http://download.microsoft.com/download/4/A/0/4A0D63BC-0F59-45E3-A0FF-9019285B3BC5/vs_ultimate.exe'
$silentArgs = "/Passive /NoRestart /Log $env:temp\vs.log"
$validExitCodes = @(
    0, # success
    3010 # success, restart required
)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" -validExitCodes $validExitCodes
