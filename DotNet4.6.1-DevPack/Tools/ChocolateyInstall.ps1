$packageName = 'DotNet4.6.1-DevPack'
$installerType = 'exe'
$32BitUrl  = 'https://download.microsoft.com/download/F/1/D/F1DEB8DB-D277-4EF9-9F48-3A65D4D8F965/NDP461-DevPack-KB3105179-ENU.exe'
$silentArgs = "/Passive /NoRestart /Log ""$env:temp\dotnet461-devpack.log"""
$validExitCodes = @(
    0, # success
    3010 # success, restart required
)

Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes
