$package = 'procdump'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $package 'http://download.sysinternals.com/files/Procdump.zip' $drop
