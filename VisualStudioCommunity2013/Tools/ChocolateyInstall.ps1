. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'functions.ps1')

$packageParameters = Parse-Parameters $env:chocolateyPackageParameters
Write-Output $packageParameters
$adminFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'AdminDeployment.xml')
Update-Admin-File $packageParameters $adminFile
$silentArgs = Generate-Install-Arguments-String $packageParameters $adminFile

$packageName = 'VisualStudioCommunity2013'
$installerType = 'exe'
$32BitUrl  = 'http://download.microsoft.com/download/7/1/B/71BA74D8-B9A0-4E6C-9159-A8335D54437E/vs_community.exe'
$validExitCodes = @(
    0, # success
    3010 # success, restart required
)

Write-Output "Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes"
Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" -validExitCodes $validExitCodes
