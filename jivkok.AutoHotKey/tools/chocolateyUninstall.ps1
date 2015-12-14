$package = 'jivkok.AutoHotkey'

$ahkName = "AutoHotkey.ahk"
$destFile = Join-Path $env:USERPROFILE $ahkName
$shortcutFile = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk'

if (Test-Path $shortcutFile) {
  echo "Removing $shortcutFile"
  Remove-Item $shortcutFile -force
}
if (Test-Path $destFile) {
  echo "Removing $destFile"
  Remove-Item $destFile -force
}
