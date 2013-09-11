$package = 'ResophNotes';

try {
    $drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
    $msi = "$drop\ResophNotes.msi"
    Install-ChocolateyZipPackage $package 'http://resoph.com/ResophNotes/Welcome_files/ResophNotes155.zip' $drop
    Install-ChocolateyInstallPackage $package 'msi' "/passive" $msi

    Write-ChocolateySuccess $package
} catch {
    Write-ChocolateyFailure $package $($_.Exception.Message)
    throw
}
