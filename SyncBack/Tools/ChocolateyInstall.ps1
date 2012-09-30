try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'SyncBack.au3';

    Install-ChocolateyZipPackage 'syncback' 'http://www.2brightsparks.com/assets/software/SyncBack_Setup.zip' $scriptDir;
    $installerPackage = Join-Path $scriptDir "SyncBack_Setup.exe";
  
    write-host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"

    Write-ChocolateySuccess 'syncback'
} catch {
  Write-ChocolateyFailure 'syncback' "$($_.Exception.Message)"
  throw 
}