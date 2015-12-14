$packageName = 'cwrsync'
$url = 'https://www.itefix.net/dl/cwRsync_5.4.1_x86_Free.zip'
$version = '5.4.1'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageFilesDir = Join-Path $toolsDir "cwRsync_${version}_x86_Free"

Install-ChocolateyZipPackage $packageName $url $toolsDir

Move-Item "$packageFilesDir\*.*" $toolsDir

Remove-Item $packageFilesDir
