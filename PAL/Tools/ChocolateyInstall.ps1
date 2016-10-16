$package = 'pal';
$url = 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pal&DownloadId=1567797&FileTime=131069520255930000&Build=21031'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$checkSum = '5A032BAF0B3986E7706E7CCE2AE3587D02B04FD223BDCE2E278F3CC34E14CE21'
$checkSumType = 'sha256'

Install-ChocolateyZipPackage $package $url $drop -Checksum $checkSum -ChecksumType $checkSumType
