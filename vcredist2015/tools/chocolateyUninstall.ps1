$packageName = 'vcredist2015'
$packageSearch = 'Microsoft Visual C++ 2015 Redistributable'
$installerType = 'exe'
$silentArgs = '/uninstall /quiet'
$validExitCodes = @(
    0, # success
    3010, # success, restart required
    2147781575, # pending restart required
    -2147185721 # pending restart required
)

try {
  Get-ItemProperty -Path @( 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                            'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' ) `
                   -ErrorAction:SilentlyContinue `
  | Where-Object { $_.DisplayName -Like "$packageSearch*" } `
  | Select-Object BundleCachePath -Unique `
  | ForEach-Object {
    $file = $_.BundleCachePath
    Uninstall-ChocolateyPackage -PackageName "$packageName" `
                                -FileType "$installerType" `
                                -SilentArgs "$silentArgs" `
                                -File "$file" `
                                -ValidExitCodes $validExitCodes
  }
} catch {
  throw $_.Exception
}
