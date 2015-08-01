$packageName = 'syncback'
$url = 'http://www.2brightsparks.com/assets/software/SyncBack_Setup.exe'

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'SyncBack.au3';

    $installerPackage = Join-Path $scriptDir "SyncBack_Setup.exe";
    Get-ChocolateyWebFile $packageName $installerPackage $url;

    Write-Host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
  throw
}
