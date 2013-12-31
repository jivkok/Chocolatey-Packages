$packageName = 'jivkok.vsextensions.2013'

function Get-Batchfile ($file) {
  $cmd = "`"$file`" & set"
    cmd /c $cmd | Foreach-Object {
      $p, $v = $_.split('=')
        Set-Item -path env:$p -value $v
    }
}

function VsVars32()
{
    $BatchFile = join-path $env:VS120COMNTOOLS "vsvars32.bat"
    Get-Batchfile `"$BatchFile`"
}

function curlex($url, $filename) {
  $path = [io.path]::gettemppath() + "\" + $filename

    if( test-path $path ) { rm -force $path }

  (new-object net.webclient).DownloadFile($url, $path)

    return new-object io.fileinfo $path
}

function installsilently($url, $name) {
  echo "Installing $name"

  $extension = (curlex $url $name).FullName

  $result = Start-Process -FilePath "VSIXInstaller.exe" -ArgumentList "/q $extension" -Wait -PassThru;
}

try {
    vsvars32

    installsilently http://visualstudiogallery.msdn.microsoft.com/fb5badda-4ea3-4314-a723-a1975cbdabb4/file/100523/7/Microsoft.CodeDigger.vsix CodeDigger.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/76293c4d-8c16-4f4a-aee6-21f83a571496/file/9356/23/CodeMaid_v0.7.0.vsix CodeMaid.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/c8bccfe2-650c-4b42-bc5c-845e21f96328/file/75539/10/EditorConfigPlugin.vsix EditorConfig.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/b31916b0-c026-4c27-9d6b-ba831093f6b2/file/62080/3/Gister.vsix Gister.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/0855e23e-4c4c-4c82-8b39-24ab5c5a7f79/file/15725/4/MarkdownMode.vsix MarkdownMode.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/2beb9705-b568-45d1-8550-751e181e3aef/file/93630/8/MultiEdit.vsix MultiEdit.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/4ec1526c-4a8c-4a84-b702-b21a8f5293ca/file/105933/4/NuGet.Tools.2013.vsix NuGet.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/ad0897b3-7537-4c92-a38c-104b0e005206/file/75983/4/PerfWatsonMonitor.vsix PerfWatsonMonitor.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/a058d5d3-e654-43f8-a308-c3bdfdd0be4a/file/89212/35/PostSharp-3.1.27.vsix PostSharp.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/dbcb8670-889e-4a54-a226-a48a15e4cace/file/117115/1/ProPowerTools.vsix ProPowerTools.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/f0589156-a8e6-47db-8bac-90f01ca6b8a3/file/80662/4/Cobisi.RoutingAssistant-v1.8.vsix RoutingAssistant.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/90ac3587-7466-4155-b591-2cd4cc4401bc/file/112721/3/TechTalk.SpecFlow.Vs2013Integration.vsix SpecFlow.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/f4d9c2b5-d6d7-4543-a7a5-2d7ebabc2496/file/63103/7/VSColorOutput.vsix VSColorOutput.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/59ca71b3-a4a3-46ca-8fe1-0e90e3f79329/file/6390/45/VsVim.vsix VsVim.vsix
    installsilently http://visualstudiogallery.msdn.microsoft.com/56633663-6799-41d7-9df7-0f2a504ca361/file/105627/23/WebEssentials2013.vsix WebEssentials.vsix

    Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName "$($_.Exception.Message)"
    throw
}
