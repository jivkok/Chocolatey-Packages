$packageName = 'TeamFoundationServerExpress2015'
$installerType = 'exe'
$silentArgs = "/Passive /NoRestart /Log $env:temp\TeamFoundationServerExpress2015.log"
$url = 'http://download.microsoft.com/download/C/A/F/CAF8D1B5-3065-4FEB-B9F0-3E6DAD0C03C8/tfs_express.exe'
$validExitCodes = @(
    0, # success
    3010, # success, restart required
    2147781575, # pending restart required
    -2147185721 # pending restart required
)

Write-Output "Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes"
Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
