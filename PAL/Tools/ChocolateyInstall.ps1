$package = 'pal';

try {
    $drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
    $msi = "$drop\PAL_Setup.msi"
    Install-ChocolateyZipPackage $package 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pal&DownloadId=1458063&FileTime=130766179509630000&Build=21024' $drop
    Install-ChocolateyInstallPackage $package 'msi' "/passive" $msi
} catch {
    Write-ChocolateyFailure $package $($_.Exception.Message)
    throw
}
