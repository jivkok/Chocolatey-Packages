$package = 'bginfo'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $package 'http://download.sysinternals.com/files/BGInfo.zip' $drop
