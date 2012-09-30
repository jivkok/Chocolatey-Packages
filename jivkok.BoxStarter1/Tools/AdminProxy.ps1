$scriptPath = (Join-Path (Split-Path -parent $MyInvocation.MyCommand.path) "ChocolateyInstall.ps1");
$identity  = [System.Security.Principal.WindowsIdentity]::GetCurrent();
$principal = New-Object System.Security.Principal.WindowsPrincipal($identity);
$isAdmin = $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator);
if($isAdmin)
{
  & $scriptPath
}
else
{
  $command = "-ExecutionPolicy bypass -noexit -file " + $scriptPath
  Start-Process powershell -verb runas -argumentlist $command
}
