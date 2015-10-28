$packageName = 'VisualStudioCode'
$installerType = 'exe'
$silentArgs = "/silent /log=""$env:temp\vscode.log"""
$32BitUrl  = 'https://az764295.vo.msecnd.net/public/0.9.1/VSCodeSetup.exe'
$checksum = 'a5bd872c5c428536951af963eacf80afe5a88e76'
$checksumType = 'sha1'
$validExitCodes = @(
    0 # success
)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$32BitUrl" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
