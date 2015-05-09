Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'VisualStudio2015Enterprise' 'Microsoft Visual Studio Enterprise 2015' 'vs_enterprise.exe'
