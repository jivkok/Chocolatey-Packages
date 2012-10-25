$package = 'Hulu.Desktop';

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'Hulu.Desktop.au3';

    $installerPackage = Join-Path $scriptDir "HuluDesktopSetup.exe";
    Get-ChocolateyWebFile $package $installerPackage 'http://download.hulu.com/HuluDesktopSetup.exe';
  
    Write-Host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"

    Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw 
}