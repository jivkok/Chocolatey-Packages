$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
#$url = 'http://download.teamviewer.com/download/TeamViewer_Setup.exe'
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
