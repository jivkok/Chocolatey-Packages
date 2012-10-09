$package = 'sqlnexus'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $package 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=sqlnexus&DownloadId=80378&FileTime=128956000434400000&Build=19471' $drop
