Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')

Uninstall-VS 'TeamFoundationServerExpress2015' 'Microsoft Team Foundation Server 2015 Express' 'tfs_express.exe'
