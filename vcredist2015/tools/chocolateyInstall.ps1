$packageName = 'vcredist2015'
$installerType = 'exe'
$url = 'http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x86.exe'
$url64 = 'http://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe'
$silentArgs = '/Q'
$validExitCodes = @(
    0, # success
    3010, # success, restart required
    2147781575, # pending restart required
    -2147185721 # pending restart required
)

Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -Url "$url" -Url64bit "$url64" -SilentArgs "$silentArgs" -ValidExitCodes $validExitCodes

if (Get-ProcessorBits 64) {
    Install-ChocolateyPackage -PackageName "$packageName" -FileType "$installerType" -Url "$url" -SilentArgs "$silentArgs" -ValidExitCodes $validExitCodes
}
