$packageName = 'VisualStudioCommunity2013'
$installerType = 'exe'
$silentArgs = '/Uninstall /force /Passive /NoRestart'
$appName = 'Microsoft Visual Studio Community 2013'

$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq $appName }
if ($app -ne $null)
{
    $uninstaller = Get-Childitem "$env:ProgramData\Package Cache\" -Recurse -Filter vs_community.exe | ? { $_.VersionInfo.ProductVersion.StartsWith($app.Version)}
    if ($uninstaller -ne $null)
    {
        Uninstall-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" $uninstaller.FullName
    }
}
