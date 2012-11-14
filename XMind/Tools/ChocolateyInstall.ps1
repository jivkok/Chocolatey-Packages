$package = 'XMind';

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'XMind.au3';

    $installerPackage = Join-Path $scriptDir "xmind-windows-3.3.0.201208102038.exe";
    Get-ChocolateyWebFile $package $installerPackage 'http://www.xmind.net/xmind/downloads/xmind-windows-3.3.0.201208102038.exe';
  
    Write-Host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"

    Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw 
}
