Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Install-VS `
    -PackageName 'VisualStudio2017Professional' `
    -ApplicationName 'Microsoft Visual Studio Professional 2017' `
    -Url 'https://aka.ms/vs/15/release/vs_Professional.exe' `
    -ChecksumSha1 '2a8511d873e0f204c8357851749a245292bc0b4b' `
    -AssumeNewVS2017Installer `
    -InstallerDisplayName 'Microsoft Visual Studio Installer'
