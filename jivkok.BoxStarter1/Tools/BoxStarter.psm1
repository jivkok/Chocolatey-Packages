function Restart-Explorer {
    if (Get-Process -Name Explorer -ea 0) {
        Write-Output "Stopping Explorer process ..."
        Stop-Process -Name Explorer -Force
        Start-Sleep -s 2
    }

    if (-not (Get-Process -Name Explorer -ea 0)) {
        Write-Output "Starting Explorer process ..."
        Start-Process Explorer
    }
}

function Is64Bit{  [IntPtr]::Size -eq 8  }

function Disable-UAC {
    Write-Output "Disabling UAC ..."

    # TODO: check whether value is already set
    Set-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name EnableLUA  -Value 0

    Write-Output "Disabling UAC done."
    Write-Output ""
}

function Move-LibraryDirectory ([string]$libraryName, [string]$newPath) {
    #why name the key downloads when you can name it {374DE290-123F-4565-9164-39C4925E467B}? duh.
    if($libraryName.ToLower() -eq "downloads") {$libraryName="{374DE290-123F-4565-9164-39C4925E467B}"}
    $shells = (Get-Item 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders')
    if(-not $shells.Property.Contains($libraryName)) {
        throw "$libraryName is not a valid Library"
    }
    $oldPath =  (Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' -name "$libraryName")."$libraryName"
    if(-not (test-path "$newPath")){
        New-Item $newPath -type directory
    }
    if((resolve-path $oldPath).Path -eq (resolve-path $newPath).Path) {return}
    Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders' $libraryName $newPath
    Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' $libraryName $newPath
    Stop-Process -processname explorer -Force
    Move-Item -Force $oldPath/* $newPath
}

function Enable-Net40 {
    if(Is64Bit) {$fx="framework64"} else {$fx="framework"}
    if(!(test-path "$env:windir\Microsoft.Net\$fx\v4.0.30319")) {
        Install-ChocolateyZipPackage 'webcmd' 'http://www.iis.net/community/files/webpi/webpicmdline_anycpu.zip' $env:temp
        .$env:temp\WebpiCmdLine.exe /products: NetFramework4 /accepteula
    }
}
function Disable-InternetExplorerESC {
    Write-Output "Disabling IE Enhanced Security Configuration (ESC) ..."

    #TODO: test for reg keys presence and whether values are already set

    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    if (Test-Path $AdminKey) {
        Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    }
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    if (Test-Path $UserKey) {
        Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    }

    Write-Output "IE Enhanced Security Configuration (ESC) has been disabled."
    Write-Output ""
}

function Install-WindowsUpdateWhenDone([switch]$getUpdatesFromMS)
{
    $global:InstallWindowsUpdateWhenDone = $true
    $global:GetUpdatesFromMSWhenDone = $getUpdatesFromMS
}

function Install-WindowsUpdate([switch]$getUpdatesFromMS)
{
    Write-Output "Checking for Windows updates ..."

    if($getUpdatesFromMS) {
        Remove-Item -Path HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate -Force -Recurse -ErrorAction SilentlyContinue
        Stop-Service -Name wuauserv
        Start-Service -Name wuauserv
    }

    $updateSession =new-object -comobject "Microsoft.Update.Session"
    $updatesToDownload =new-Object -com "Microsoft.Update.UpdateColl"
    $updatesToInstall =new-object -com "Microsoft.Update.UpdateColl"
    $Downloader =$updateSession.CreateUpdateDownloader()
    $Installer =$updateSession.CreateUpdateInstaller()
    $Searcher =$updatesession.CreateUpdateSearcher()
    $Result = $Searcher.Search("IsInstalled=0 and Type='Software'")

    If ($Result.updates.count -ne 0)
    {
        Write-Output $Result.updates.count " Updates found"
        foreach($update in $result.updates) {
            if ($update.isDownloaded -ne "true") {
                Write-Output " * Adding " $update.title " to list of updates to download"
                $updatesToDownload.add($update) | Out-Null
            }
            else {Write-Output " * " $update.title " already downloaded"}
        }

        If ($updatesToDownload.Count -gt 0) {
            Write-Output "Beginning to download " $updatesToDownload.Count " updates"
            $Downloader.Updates = $updatesToDownload
            $Downloader.Download()
        }

        Write-Output "Downloading complete"
        foreach($update in $result.updates) {
            $updatesToinstall.add($update) | Out-Null
        }

        Write-Output "Beginning to install"
        $Installer.updates = $UpdatesToInstall
        $result = $Installer.Install()

        if($result.rebootRequired) {
            if($global:InstallWindowsUpdateWhenDone) {
                New-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\bootstrap-post-restart.bat" -type file -force -value "powershell -NonInteractive -NoProfile -ExecutionPolicy bypass -Command `"Import-Module '$PSScriptRoot\BoxStarter.psm1';Install-WindowsUpdate`""
            }
            Write-Output "Restart Required. Restarting now..."
            Restart-Computer -force
        }
        Write-Output "All updates installed"
    }
    else {
        Write-Output "There is no update applicable to this machine"
    }

    Write-Output ""
}

function Set-ExplorerOptions([switch]$showHidenFilesFoldersDrives, [switch]$showProtectedOSFiles, [switch]$showFileExtensions)
{
    Write-Output "Setting Explorer options ..."

    $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    if($showHidenFilesFoldersDrives) {
        Write-Output "Show Hidden Files"
        Set-ItemProperty $key Hidden 1
    }
    if($showFileExtensions) {
        Write-Output "Show File Extensions"
        Set-ItemProperty $key HideFileExt 0
    }
    if($showProtectedOSFiles) {
        Write-Output "Show Protected OS Files"
        Set-ItemProperty $key ShowSuperHidden 1
    }

    Write-Output "Setting Explorer options done."
    Write-Output ""
}

function Set-TaskbarSmall
{
    Write-Output "Setting Taskbar to Small Icons ..."

    $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Set-ItemProperty $key TaskbarSmallIcons 1
    Set-ItemProperty $key TaskbarGlomLevel 2

    Write-Output "Setting Taskbar to Small Icons done."
    Write-Output ""
}

function Check-Chocolatey
{
    if(-not $env:ChocolateyInstall -or -not (Test-Path "$env:ChocolateyInstall")){
        $env:ChocolateyInstall = "$env:systemdrive\chocolatey"
        New-Item $env:ChocolateyInstall -Force -type directory
        $url=$config.ChocolateyPackage
        iex ((new-object net.webclient).DownloadString($config.ChocolateyRepo))
        Enable-Net40
    }

    Import-Module $env:ChocolateyInstall\chocolateyinstall\helpers\chocolateyInstaller.psm1
}

function Enable-RemoteDesktop
{
    Write-Output "Enabling Remote Desktop ..."

    (Get-WmiObject -Class "Win32_TerminalServiceSetting" -Namespace root\cimv2\terminalservices).SetAllowTsConnections(1)
    netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes

    Write-Output "Enabling Remote Desktop done."
    Write-Output ""
}

function Disable-ShutdownTracker
{
    Write-Output "Disabling Windows shutdown event tracker ..."

    $key = 'HKLM:\Software\Policies\Microsoft\Windows NT\Reliability'
    if (-not (Test-Path $key)) {
        New-Item -Path $key
    }

    Set-ItemProperty $key ShutdownReasonOn 0
    Set-ItemProperty $key ShutdownReasonUI 0

    Write-Output "Disabling Windows shutdown event tracker done."
    Write-Output ""
}

Export-ModuleMember Disable-UAC, Disable-InternetExplorerESC, Install-WindowsUpdateWhenDone, Set-ExplorerOptions, Set-TaskbarSmall, Install-WindowsUpdate, Install-VsixSilently, Move-LibraryDirectory, Enable-RemoteDesktop, Restart-Explorer, Disable-ShutdownTracker
