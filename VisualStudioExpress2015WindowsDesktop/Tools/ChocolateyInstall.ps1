$packageName = 'VisualStudioExpress2015WindowsDesktop'
$installerType = 'exe'
$silentArgs = "/Passive /NoRestart /Log $env:temp\VisualStudioExpress2015WindowsDesktop.log"
$url = 'http://download.microsoft.com/download/D/E/5/DE5263E9-A58D-469A-BA16-14786E2E2B1C/wdexpress_full.exe'
$validExitCodes = @(
    0, # success
    3010, # success, restart required
    2147781575, # pending restart required
    -2147185721 # pending restart required
)

Write-Output "Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes"
Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
