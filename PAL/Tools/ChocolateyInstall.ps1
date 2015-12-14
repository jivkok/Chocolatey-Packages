$package = 'pal';

$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Install-ChocolateyZipPackage $package 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pal&DownloadId=1504714&FileTime=130906343935170000&Build=21031' $drop
