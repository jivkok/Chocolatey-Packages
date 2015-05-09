Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Install-VS 'VisualStudio2015Community' 'http://download.microsoft.com/download/D/4/5/D4510E81-0900-425F-85F3-A09AFFADFA45/vs_community.exe'
