$packageName = 'VisualStudioCode'
$installerType = 'exe'
$silentArgs = '-s'
$32BitUrl  = 'https://az764295.vo.msecnd.net/public/0.5.0/VSCodeSetup.exe'
$validExitCodes = @(
    0 # success
)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" -validExitCodes $validExitCodes
