try {
    $drop = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
    $exe = "$drop\SyncBack_Setup.exe"
    Install-ChocolateyZipPackage 'syncback' 'http://www.2brightsparks.com/assets/software/SyncBack_Setup.zip' $drop
    Install-ChocolateyInstallPackage "syncback" 'exe' "/quiet" $exe

    Write-ChocolateySuccess 'syncback'
} catch {
    Write-ChocolateyFailure 'syncback' $($_.Exception.Message)
    throw 
}