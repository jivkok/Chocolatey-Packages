$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$msi = "$drop\Project2010SDK.msi"
Install-ChocolateyZipPackage 'project.2010.sdk' 'http://download.microsoft.com/download/A/3/B/A3BBD4C5-A4C8-489B-BBE1-C167AAD808E2/Project2010SDK.exe' $drop
Install-ChocolateyInstallPackage "project.2010.sdk" 'msi' "/passive" $msi
