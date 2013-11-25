$package = 'jivkok.Shell1'

try {
  $toolsPath = 'C:\Tools\jivkok'
  Remove-Item $toolsPath -recurse -force
  Remove-Item "$Home\Desktop\JConsole.lnk" -force

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
