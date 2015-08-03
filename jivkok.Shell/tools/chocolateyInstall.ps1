$package = 'jivkok.Shell'

try {
  # dotfiles repo
  if (Test-Path "$Home\dotfiles\.git") {
    . "${Env:ProgramFiles(x86)}\Git\bin\git.exe" -C "$Home\dotfiles" pull --prune --recurse-submodules
    . "${Env:ProgramFiles(x86)}\Git\bin\git.exe" -C "$Home\dotfiles" submodule init
    . "${Env:ProgramFiles(x86)}\Git\bin\git.exe" -C "$Home\dotfiles" submodule update --remote --recursive
  } else {
    if (Test-Path "$Home\dotfiles") {
      if (Test-Path "$Home\dotfiles.BACKUP") { Remove-Item "$Home\dotfiles.BACKUP" -Recurse -Force }
      Rename-Item "$Home\dotfiles" "$Home\dotfiles.BACKUP" -Force
    }
    . "${Env:ProgramFiles(x86)}\Git\bin\git.exe" clone --recursive https://github.com/jivkok/dotfiles.git "$Home\dotfiles"
  }

  . "$Home\dotfiles\setup_windows.ps1"
} catch {
  Write-ChocolateyFailure $package "$_"
  throw
}
