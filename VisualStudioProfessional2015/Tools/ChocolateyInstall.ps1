Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Install-VS 'VisualStudioProfessional2015' 'http://download.microsoft.com/download/F/D/9/FD972332-71E9-4310-82B8-7D4987DCD147/vs_professional.exe'
