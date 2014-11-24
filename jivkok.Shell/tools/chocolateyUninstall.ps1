$package = 'jivkok.Shell'

try {
  Remove-Item "$Home\.shell" -recurse -force
  Remove-Item "$Home\Desktop\JConsole.lnk" -force

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
