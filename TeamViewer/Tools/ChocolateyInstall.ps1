$packageName = 'teamviewer'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://download.teamviewer.com/download/TeamViewer_Setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url