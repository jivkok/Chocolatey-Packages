Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'TeamFoundationServer2015' 'Microsoft Team Foundation Server 2015' 'tfs_server.exe'
