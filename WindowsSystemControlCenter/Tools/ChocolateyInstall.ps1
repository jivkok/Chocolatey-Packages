$packageName = 'WindowsSystemControlCenter'
$url = 'http://www.kls-soft.com/downloads/wscc.zip'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $drop
