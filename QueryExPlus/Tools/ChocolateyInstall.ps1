$packageName = 'queryexplus'

$drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exe = "$drop\QueryExPlus.exe"
Install-ChocolateyZipPackage $packageName 'http://downloads.sourceforge.net/project/queryexplus/Query%20ExPlus%202/2.0.3.1/QueryExPlus.exe_2_0_3_1.zip?use_mirror=iweb' $drop
