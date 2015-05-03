Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'VisualStudioCommunity2015' 'Microsoft Visual Studio Community 2015' 'vs_community.exe'
