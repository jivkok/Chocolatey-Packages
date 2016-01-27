Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Install-VS 'VisualStudio2015Enterprise' 'http://download.microsoft.com/download/C/7/8/C789377D-7D49-4331-8728-6CED518956A0/vs_enterprise_ENU.exe'
