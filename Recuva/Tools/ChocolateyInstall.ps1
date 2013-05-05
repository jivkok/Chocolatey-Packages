$package = 'Recuva';

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'Recuva.au3';

    $installerPackage = Join-Path $scriptDir "rcsetup_slim.exe";
    Get-ChocolateyWebFile $package $installerPackage 'http://www.piriform.com/recuva/download/slim//downloadfile';

    Write-Host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"

    Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw 
}