$package = 'NimbleText'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $package 'http://nimbletext.com/download/NimbleText.zip' $drop
