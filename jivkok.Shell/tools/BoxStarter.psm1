function Is64Bit{  [IntPtr]::Size -eq 8  }

function Disable-InternetExplorerESC {
    Write-Output "Disabling IE Enhanced Security Configuration (ESC) ..."

    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    if (-not (Test-Path $AdminKey)) {
        New-Item -Path $AdminKey
    }
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0

    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    if (-not (Test-Path $UserKey)) {
        New-Item -Path $UserKey
    }
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0

    Write-Output "IE Enhanced Security Configuration (ESC) has been disabled."
}

function Disable-ShutdownTracker
{
    Write-Output "Disabling Windows shutdown event tracker ..."

    $key = 'HKLM:\Software\Policies\Microsoft\Windows NT\Reliability'
    if (-not (Test-Path $key)) {
        New-Item -Path $key
    }
    Set-ItemProperty -Path $key -Name ShutdownReasonOn -Value 0
    Set-ItemProperty -Path $key -Name ShutdownReasonUI -Value 0

    Write-Output "Disabling Windows shutdown event tracker done."
    Write-Output ""
}

function Disable-UAC {
    Write-Output "Disabling UAC ..."

    $key = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
    if (-not (Test-Path $key)) {
        New-Item -Path $key
    }
    Set-ItemProperty -Path $key -Name EnableLUA -Value 0

    Write-Output "Disabling UAC done."
    Write-Output ""
}

function Enable-RemoteDesktop
{
    Write-Output "Enabling Remote Desktop ..."
    $obj = Get-WmiObject -Class "Win32_TerminalServiceSetting" -Namespace root\cimv2\terminalservices
    if ($obj -eq $null) {
        Write-Output "Unable to locate TerminalServices namespace. Remote Desktop is not enabled"
        return
    }
    $obj.SetAllowTsConnections(1,1) | out-null

    Write-Output "Enabling Remote Desktop done."
    Write-Output ""
}

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

function Set-ExplorerOptions([switch]$showHidenFilesFoldersDrives, [switch]$showProtectedOSFiles, [switch]$showFileExtensions)
{
    Write-Output "Setting Explorer options ..."

    $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    if (-not (Test-Path $key)) {
        New-Item -Path $key
    }

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
}

function Set-TaskbarSmall
{
    Write-Output "Setting Taskbar to Small Icons ..."

    $key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    if (-not (Test-Path $key)) {
        New-Item -Path $key
    }
    Set-ItemProperty $key TaskbarSmallIcons 1
    Set-ItemProperty $key TaskbarGlomLevel 2

    Write-Output "Setting Taskbar to Small Icons done."
}

Export-ModuleMember Disable-InternetExplorerESC, Disable-ShutdownTracker, Disable-UAC, Enable-RemoteDesktop, Restart-Explorer, Set-ExplorerOptions, Set-TaskbarSmall
