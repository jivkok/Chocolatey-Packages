$package = 'pal';

try {
    $drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
    $msi = "$drop\PAL_Setup.msi"
    Install-ChocolateyZipPackage $package 'http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=pal&DownloadId=453991&FileTime=129870355259100000&Build=74' $drop
    Install-ChocolateyInstallPackage $package 'msi' "/passive" $msi
} catch {
    Write-ChocolateyFailure $package $($_.Exception.Message)
    throw
}
