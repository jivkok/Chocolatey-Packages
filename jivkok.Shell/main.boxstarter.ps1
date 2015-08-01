# Updates a Windows machine and installs a range of developer tools

# Show more info for files in Explorer
Set-WindowsExplorerOptions -EnableShowFileExtensions -EnableShowFullPathInTitleBar

# Default to the desktop rather than application launcher
Set-StartScreenOptions -EnableBootToDesktop -EnableDesktopBackgroundOnStart -EnableShowStartOnActiveScreen -EnableShowAppsViewOnStartScreen -EnableSearchEverywhereInAppsView -EnableListDesktopAppsFirst

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

# Allow unattended reboots
$Boxstarter.RebootOk=$true
$Boxstarter.AutoLogin=$true

# Update Windows and reboot if necessary
Install-WindowsUpdate -AcceptEula
if (Test-PendingReboot) { Invoke-Reboot }

Set-BoxstarterConfig -NugetSources "http://www.myget.org/F/jivkok-chocolatey/api/v2;http://chocolatey.org/api/v2;http://www.myget.org/F/boxstarter/api/v2"

# Shell
cinst -y jivkok.shell
cinst -y ansicon
cinst -y curl
cinst -y wget

# Browsers
cinst -y Firefox
cinst -y GoogleChrome

# Security
cinst -y ccleaner
cinst -y CloseTheDoor
cinst -y secunia.psi

# Apps
cinst -y calibre
cinst -y dropbox
cinst -y dmde
cinst -y evernote
cinst -y inssider
cinst -y Intel.SSD.Toolbox
cinst -y iTunes
cinst -y keepass
cinst -y ketarin
cinst -y ProduKey
cinst -y prototyper
cinst -y rdmfree
cinst -y Recuva
cinst -y Revo.Uninstaller
cinst -y skype
cinst -y speccy
cinst -y teamviewer
cinst -y terminals
cinst -y vlc

# Tools
cinst -y 7zip
cinst -y autohotkey
cinst -y autoit.commandline
cinst -y baretail
cinst -y bginfo
cinst -y ChocolateyPackageUpdater
cinst -y ffmpeg
cinst -y fiddler4
cinst -y filezilla
cinst -y httrack
cinst -y HxD
cinst -y jivkok.AutoHotKey
cinst -y ketarin
cinst -y logparser
cinst -y MobaXTerm
cinst -y netscan64
cinst -y nmap
cinst -y PreviewHandlerPack
cinst -y PsGet
cinst -y PsTools
cinst -y SourceCodePro
cinst -y SourcePreviewHandler
cinst -y sysinternals
cinst -y SyncBack
cinst -y Tunnelier
cinst -y windirstat
cinst -y winscp
# Dev Tools - optional
# cinst -y AquaSnap
# cinst -y MarkPad

# Dev Tools
cinst -y Compass
cinst -y DependencyWalker
cinst -y dotPeek
cinst -y expresso
cinst -y IcoFx
cinst -y Indihiang
cinst -y linqpad4
cinst -y kdiff3
cinst -y NimbleText
cinst -y Nuget.CommandLine
cinst -y NugetPackageExplorer
cinst -y OptiPng
cinst -y P4Merge
cinst -y paint.net
cinst -y pal
cinst -y perfview
cinst -y PEStudio
cinst -y python
cinst -y SourceTree
cinst -y SpecFlow
cinst -y StyleCop
cinst -y WinDbg
cinst -y WindowsAzurePowershell
# Dev Tools - optional
# cinst -y haskellplatform
# cinst -y MySql.Utilities
# cinst -y MySql.Workbench
# cinst -y nodejs.install
# cinst -y PhantomJS
# cinst -y QueryExPlus
# cinst -y SqlDiagManager
# cinst -y Sqlite.Analyzer
# cinst -y Sqlite.shell
# cinst -y SqlNexus
# cinst -y SqlDiagManager
# cinst -y YeoMan

# IDEs
cinst -y Atom
cinst -y VisualStudioCode
cinst -y VisualStudio2015Community
cinst -y jivkok.vsextensions.2013

if (Test-PendingReboot) { Invoke-Reboot }
