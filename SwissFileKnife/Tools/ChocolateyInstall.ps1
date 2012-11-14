$package = 'SwissFileKnife';

try {
    $scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition);

    $installerPackage = Join-Path $scriptDir "sfk.exe";
    Get-ChocolateyWebFile $package $installerPackage 'http://stahlworks.com/dev/sfk/sfk.exe';

    Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw 
}