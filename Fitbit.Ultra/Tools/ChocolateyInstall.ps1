$package = 'Fitbit.Ultra';

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'Fitbit.Uploader.au3';

    $installerPackage = Join-Path $scriptDir "Fitbit-Uploader-For-Windows-2.1.0.8.exe";
    Get-ChocolateyWebFile $package $installerPackage 'http://cache.fitbit.com/uploader/Fitbit-Uploader-For-Windows-2.1.0.8.exe';
  
    Write-Host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"

    Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw 
}