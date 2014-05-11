$env:PLINK_PROTOCOL = "ssh"
$env:TERM = "msys"
$env:HOME = resolve-path (join-path ([environment]::getfolderpath("mydocuments")) "..\")
$env:TMP = $env:TEMP = [system.io.path]::gettemppath()
$env:EDITOR = "Notepad"

# Setup PATH
$GitPath = "${env:ProgramFiles}\Git"
$msBuildPath = "$env:SystemRoot\Microsoft.NET\Framework\v4.0.30319"
$env:Path = "$env:Path;$msbuildPath;$GitPath\cmd;$GitPath\bin"

# Aliases
function .. { Push-Location .. }
function ... { Push-Location ..\.. }
function n { notepad $args }
function nn { &"${Env:ProgramW6432}\Sublime Text 3\sublime_text.exe" $args }
function fs { findstr /spin $args }
function qg { start http://www.google.com/#q=$args }
function ds
{
    if (!$args) {
        Get-ChildItem -Recurse | Select Fullname
        return;
    }
    $path = Split-Path -Path $args[0] -Parent
    if ($path.length -eq 0) {
        $path = '.'
    }
    $filter = Split-Path -Path $args[0] -Leaf
    if ($filter.length -eq 0) {
        $filter = '*.*'
    }
    Get-ChildItem -Path $path -Filter $filter -Recurse | Select Fullname
}
