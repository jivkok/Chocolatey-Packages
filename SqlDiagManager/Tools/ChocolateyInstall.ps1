$package = 'sqldiagmanager';

$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$msi = "$drop\SetupX86.msi"
Install-ChocolateyZipPackage $package 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=diagmanager&DownloadId=246133&FileTime=129514200362570000&Build=19471' $drop
Install-ChocolateyInstallPackage $package 'msi' "/passive" $msi
