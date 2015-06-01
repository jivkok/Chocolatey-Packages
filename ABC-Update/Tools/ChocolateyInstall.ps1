$packageName = 'ABC-Update'
$url = 'http://abc-deploy.com/Files/ABC-Update.zip'
$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $drop
