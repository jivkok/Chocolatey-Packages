try {
  $processor = Get-WmiObject Win32_Processor
  $is64bit = $processor.AddressWidth -eq 64
  if ($is64bit) {
    $unpath = "${Env:ProgramFiles(x86)}\XMind\uninstall.exe"
  } else {
    $unpath = "${Env:ProgramFiles}\XMind\uninstall.exe"
  }
  Uninstall-ChocolateyPackage 'xmind' 'EXE' '/S' "$unpath" -validExitCodes @(0)
  
  Write-ChocolateySuccess 'xmind'
} catch {
  Write-ChocolateyFailure 'xmind' "$($_.Exception.Message)"
  throw 
}
