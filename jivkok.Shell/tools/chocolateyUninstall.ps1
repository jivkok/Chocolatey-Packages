$package = 'jivkok.Shell'

Write-Output "Deleting desktop shortcut (and taskbar pin): $Home\Desktop\Shell.lnk"
if (Test-Path "$Home\Desktop\Shell.lnk") {
  $shellApp = New-Object -c Shell.Application
  $folderItem = $shellApp.Namespace("$Home\Desktop").ParseName('Shell.lnk')
  $folderItem.InvokeVerb('taskbarunpin')

  Remove-Item "$Home\Desktop\Shell.lnk" -Force
}

Write-Output 'Deleting directory symlinks'
'.vim' |
  % {
    if (Test-Path "$Home\$_.BACKUP") { cmd /c "rd $Home\$_.BACKUP" }
    Rename-Item "$Home\$_" "$Home\$_.BACKUP" -Force
  }

Write-Output 'Deleting file symlinks'
'.aliases',
'.bash_profile',
'.bash_prompt',
'.bashrc',
'.curlrc',
'.exports',
'.functions',
'.tmux.conf',
'.vimrc',
'.wgetrc' |
  % {
    if (Test-Path "$Home\$_.BACKUP") { Remove-Item "$Home\$_.BACKUP" -Force }
    Rename-Item "$Home\$_" "$Home\$_.BACKUP" -Force
  }

Write-Output 'NOTE: repo is left in-place'
