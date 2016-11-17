Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Install-VS `
    -PackageName 'VisualStudio2017Community' `
    -ApplicationName 'Microsoft Visual Studio Community 2017' `
    -Url 'https://aka.ms/vs/15/release/vs_Community.exe' `
    -ChecksumSha1 '183f56b2989020750f6f5c5c422284019c178c1d' `
    -AssumeNewVS2017Installer `
    -InstallerDisplayName 'Microsoft Visual Studio Installer'
