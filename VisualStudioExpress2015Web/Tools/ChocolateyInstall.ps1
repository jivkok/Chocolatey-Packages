$packageName = 'VisualStudioExpress2015Web'
$installerType = 'exe'
$silentArgs = "/Passive /NoRestart /Log $env:temp\VisualStudioExpress2015Web.log"
$url = 'http://download.microsoft.com/download/3/A/2/3A21E166-8760-4595-A421-622706FD892F/vns_full.exe'
$validExitCodes = @(
    0, # success
    3010, # success, restart required
    2147781575, # pending restart required
    -2147185721 # pending restart required
)

Write-Output "Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes"
Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
