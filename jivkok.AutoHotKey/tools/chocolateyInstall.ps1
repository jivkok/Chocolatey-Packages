$package = 'jivkok.AutoHotkey'

try {
  $ahkName = "AutoHotkey.ahk"
  $currentPath = (Split-Path -parent $MyInvocation.MyCommand.path)
  $destFile = Join-Path $env:USERPROFILE $ahkName
  $shortcutFile = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk'

  echo "Creating $destFile"
  Copy-Item -Path (Join-Path $currentPath $ahkName) -Destination $destFile -Force

  echo "Creating $shortcutFile"
  if (Test-Path $shortcutFile) {
    Remove-Item $shortcutFile -force
  }
  $WshShell = New-Object -comObject WScript.Shell
  $shortcut = $WshShell.CreateShortcut($shortcutFile)
  $shortcut.TargetPath = $destFile
  $shortcut.Save()

  AutoHotkey $destFile

  Write-ChocolateySuccess $package
} catch {
  Write-ChocolateyFailure $package "$($_.Exception.Message)"
  throw
}
