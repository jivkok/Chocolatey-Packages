Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'VisualStudioCommunity2013' 'Microsoft Visual Studio Community 2013' 'vs_community.exe'
