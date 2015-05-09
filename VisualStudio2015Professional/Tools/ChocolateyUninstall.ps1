Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'VisualStudio2015Professional' 'Microsoft Visual Studio Professional 2015' 'vs_professional.exe'
