. (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'common.ps1')

$adminFile = (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'AdminDeployment.xml')
$customArgs = $env:chocolateyInstallArguments
$env:chocolateyInstallArguments=""

$settings = Initialize-VS-Settings $customArgs $adminFile
$installerArgs = Get-VS-Installer-Args $settings.ProductKey

$packageName = 'VisualStudio2015Ultimate'
$installerType = 'exe'
$32BitUrl  = 'http://download.microsoft.com/download/4/A/0/4A0D63BC-0F59-45E3-A0FF-9019285B3BC5/vs_ultimate.exe'
$validExitCodes = @(
    0, # success
    3010 # success, restart required
)

Install-ChocolateyPackage "$packageName" "$installerType" "$installerArgs" "$32BitUrl" -validExitCodes $validExitCodes
