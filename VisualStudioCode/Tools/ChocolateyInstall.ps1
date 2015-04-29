$packageName = 'VisualStudioCode'
$installerType = 'exe'
$silentArgs = '' #TODO
$32BitUrl  = 'http://download.microsoft.com/download/0/D/5/0D57186C-834B-463A-AECB-BC55A8E466AE/VSCodeSetup.exe'
$validExitCodes = @(
    0 # success
)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" -validExitCodes $validExitCodes
