$packageName = 'VisualStudioCode'
$installerType = 'exe'
$silentArgs = "/silent /log=""$env:temp\vscode.log"""
$32BitUrl  = 'https://az764295.vo.msecnd.net/public/0.8.0/VSCodeSetup.exe'
$validExitCodes = @(
    0 # success
)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" -validExitCodes $validExitCodes
