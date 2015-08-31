Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'VisualStudioExpress2015WindowsDesktop' 'Microsoft Visual Studio Express 2015 for Windows Desktop' 'wdexpress_full.exe'
