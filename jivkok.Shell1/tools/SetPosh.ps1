<#
.SYNOPSIS
    Sets up the GitHub Git Shell Environment
.DESCRIPTION
    Sets up the proper PATH and ENV to use GitHub for Window's shell environment
    Don't edit this file directly, it is generated on install.
    Generally you would run this from your Powershell Profile like this:

    . (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")

.PARAMETER SkipSSHSetup
    If true, skips calling GitHub.exe to autoset and upload ssh-keys
#>
[CmdletBinding()]
Param(
    [switch]
    $SkipSSHSetup = $false
)

  Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$env:PLINK_PROTOCOL = "ssh"
$env:TERM = "msys"
$env:HOME = resolve-path (join-path ([environment]::getfolderpath("mydocuments")) "..\")
$env:TMP = $env:TEMP = [system.io.path]::gettemppath()
$env:EDITOR = "Notepad"

# Setup PATH
$GitPath = "${Env:ProgramFiles}\Git"
$msBuildPath = "$env:SystemRoot\Microsoft.NET\Framework\v4.0.30319"
$env:Path = "$env:Path;$GitPath\cmd;$GitPath\bin;$msbuildPath"

# Aliases
function nn { &"${Env:ProgramW6432}\Sublime Text 3\sublime_text.exe" $args }

Pop-Location
