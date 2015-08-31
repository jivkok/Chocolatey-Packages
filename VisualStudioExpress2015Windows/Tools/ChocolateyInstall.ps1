if ([Environment]::OSVersion.Version.Major -lt 10) {
    throw "Windows 10 is required for this package."
}

$packageName = 'VisualStudioExpress2015Windows'
$installerType = 'exe'
$silentArgs = "/Passive /NoRestart /Log $env:temp\VisualStudioExpress2015Windows.log"
$url = 'http://download.microsoft.com/download/5/1/2/51272291-B7C9-49C1-A562-7DEB693F0EE7/winexpress_full.exe'
$validExitCodes = @(
    0, # success
    3010, # success, restart required
    2147781575, # pending restart required
    -2147185721 # pending restart required
)

Write-Output "Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes"
Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
