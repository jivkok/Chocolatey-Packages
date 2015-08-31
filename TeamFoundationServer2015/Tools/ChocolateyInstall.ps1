$packageName = 'TeamFoundationServer2015'
$installerType = 'exe'
$silentArgs = "/Passive /NoRestart /Log $env:temp\TeamFoundationServer2015.log"
$url = 'http://download.microsoft.com/download/D/5/5/D55B3B8C-A270-495F-BEF9-846AB05F294B/tfs_server.exe'
$validExitCodes = @(
    0, # success
    3010, # success, restart required
    2147781575, # pending restart required
    -2147185721 # pending restart required
)

Write-Output "Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes"
Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
