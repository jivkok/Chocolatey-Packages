$packageName = 'DotNet46-TargetPack'
$installerType = 'exe'
$32BitUrl  = 'http://download.microsoft.com/download/8/2/F/82FF2034-83E6-4F93-900D-F88C7AD9F3EE/NDP46-TargetingPack-KB3045566.exe'
$silentArgs = "/Passive /NoRestart /Log $env:temp\net46-targetpack.log"
$validExitCodes = @(
    0, # success
    3010 # success, restart required
)

Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes

# ENU language pack
$packageName = 'DotNet46-TargetPack-enu'
$32BitUrl  = 'http://download.microsoft.com/download/8/2/F/82FF2034-83E6-4F93-900D-F88C7AD9F3EE/NDP46-TargetingPack-KB3045566-ENU.exe'
$silentArgs = "/Passive /NoRestart /Log $env:temp\net46-targetpackenu.log"

Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes
