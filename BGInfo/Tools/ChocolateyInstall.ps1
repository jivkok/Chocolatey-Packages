$package = 'bginfo'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $package 'https://live.sysinternals.com/Files/BGInfo.zip' $drop
