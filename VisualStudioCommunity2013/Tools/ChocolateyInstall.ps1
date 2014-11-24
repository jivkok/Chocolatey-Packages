$adminFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'AdminDeployment.xml')

$packageName = 'VisualStudioCommunity2013'
$installerType = 'exe'
$32BitUrl  = 'http://download.microsoft.com/download/7/1/B/71BA74D8-B9A0-4E6C-9159-A8335D54437E/vs_community.exe'
$silentArgs = "/Passive /NoRestart /AdminFile $adminFile /Log $env:temp\vs.log"
$validExitCodes = @(
    0, # success
    3010 # success, restart required
)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" -validExitCodes $validExitCodes
