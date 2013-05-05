$package = 'SourceTree';

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);
    $installerAuto = Join-Path $scriptDir 'SourceTree.au3';

    $installerPackage = Join-Path $scriptDir "SourceTreeSetup.exe";
    Get-ChocolateyWebFile $package $installerPackage 'http://downloads.atlassian.com/software/sourcetree/windows/SourceTreeSetup.exe';
  
    Write-Host "Installing `'$installerPackage`' with AutoIt3 using `'$installerAuto`'"
    $installArgs = "/c autoit3 `"$installerAuto`" `"$installerPackage`""
    Start-ChocolateyProcessAsAdmin "$installArgs" "cmd.exe"

    Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw 
}