Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'VisualStudioExpress2015Web' 'Microsoft Visual Studio 2015 Express' 'vns_full.exe'
