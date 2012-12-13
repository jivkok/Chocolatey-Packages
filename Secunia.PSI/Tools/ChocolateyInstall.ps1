$package = 'Secunia.PSI';

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'Secunia.PSI.au3';
    Write-Host $scriptDir
    Write-Host $installerAuto

    $installerPackage = Join-Path $scriptDir 'PSISetup.exe';
    Write-Host $installerPackage
    Get-ChocolateyWebFile $package $installerPackage 'ftp://ftp.secunia.com/PSISetup.exe';

    Write-Host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"

    Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw 
}
