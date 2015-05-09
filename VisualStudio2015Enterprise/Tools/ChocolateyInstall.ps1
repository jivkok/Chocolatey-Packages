Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Install-VS 'VisualStudio2015Enterprise' 'http://download.microsoft.com/download/C/A/A/CAA39018-05E5-49BA-8B24-4FC056EEA392/vs_enterprise.exe'
