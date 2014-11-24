@echo off

set COPYCMD=/y

DOSKEY cd=cd $*$Tdir
DOSKEY ..=pushd ..
DOSKEY ...=pushd ..\..
DOSKEY n=notepad.exe $*
DOSKEY ds=dir /s/b $*
DOSKEY fs=findstr /spin $1 $2
DOSKEY b=msbuild $*

rem Apps
if exist "%ProgramW6432%\Sublime Text 3\sublime_text.exe" (
    DOSKEY nn=start "" /B "%ProgramW6432%\Sublime Text 3\sublime_text.exe" $*
)
if exist "%ProgramFiles(x86)%\Git\bin\git.exe" (
    DOSKEY git="%ProgramFiles(x86)%\Git\bin\git.exe" $*
)

rem VS
if exist "%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat" (
    echo Setting VS 2015 ...
    call "%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"
) else if exist "%ProgramFiles(x86)%\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat" (
    echo Setting VS 2013 ...
    call "%ProgramFiles(x86)%\Microsoft Visual Studio 12.0\Common7\Tools\VsDevCmd.bat"
) else if exist "%ProgramFiles(x86)%\Microsoft Visual Studio 11.0\Common7\Tools\VsDevCmd.bat" (
    echo Setting VS 2012 ...
    call "%ProgramFiles(x86)%\Microsoft Visual Studio 11.0\Common7\Tools\VsDevCmd.bat"
)

cd /d %USERPROFILE%

if exist "%USERPROFILE%\cmd_profile.cmd" (
    call "%USERPROFILE%\cmd_profile.cmd"
)
