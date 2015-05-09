Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'VisualStudio2015Community' 'Microsoft Visual Studio Community 2015' 'vs_community.exe'
