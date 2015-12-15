$packageName = 'jivkok.vsextensions.2015'

function RunBatchfileAndUseItsEnvironmentVariables ($file) {
  $cmd = """$file"" & set"
  cmd /c $cmd | Foreach-Object {
    $p, $v = $_.split('=')
    Set-Item -path env:$p -value $v
  }
}

function curlex($url, $filename) {
  $path = [IO.Path]::GetTempPath() + "\" + $filename

  if ( Test-Path $path ) { rm -force $path }

  (New-Object Net.WebClient).DownloadFile($url, $path)

  return New-Object IO.FileInfo $path
}

function Install-Extension($url, $name) {
  echo "Installing $name"

  $extension = (curlex $url $name).FullName

  $result = Start-Process -FilePath "VSIXInstaller.exe" -ArgumentList "/q $extension" -Wait -PassThru;
}

$BatchFile = Join-Path $env:VS140COMNTOOLS "vsvars32.bat"
RunBatchfileAndUseItsEnvironmentVariables $BatchFile

# Common
Install-Extension https://visualstudiogallery.msdn.microsoft.com/76293c4d-8c16-4f4a-aee6-21f83a571496/file/9356/33/CodeMaid_v0.9.0.vsix CodeMaid.vsix # v0.9.0
# no Dev14 yet Install-Extension http://visualstudiogallery.msdn.microsoft.com/86548753-2b00-42e0-a40c-185f93e37a4f/file/136953/3/EasyMotion.vsix EasyMotion.vsix # v1.0
Install-Extension https://visualstudiogallery.msdn.microsoft.com/c8bccfe2-650c-4b42-bc5c-845e21f96328/file/75539/12/EditorConfigPlugin.vsix EditorConfig.vsix # v0.5.0
# no Dev14 yet Install-Extension http://visualstudiogallery.msdn.microsoft.com/b31916b0-c026-4c27-9d6b-ba831093f6b2/file/62080/3/Gister.vsix Gister.vsix # v1.5
Install-Extension https://visualstudiogallery.msdn.microsoft.com/0855e23e-4c4c-4c82-8b39-24ab5c5a7f79/file/15725/6/MarkdownMode.vsix MarkdownMode.vsix # v2.7
Install-Extension https://visualstudiogallery.msdn.microsoft.com/f301cf82-e80b-4b92-9e5c-ef7985ae6702/file/147188/10/MixEdit.vsix MixEdit.vsix # v1.1.59
Install-Extension https://visualstudiogallery.msdn.microsoft.com/5d345edc-2e2d-4a9c-b73b-d53956dc458d/file/146283/9/NuGet.Tools.vsix NuGet.Tools.vsix # v3.3.0.167
# It is exe now Install-Extension https://visualstudiogallery.msdn.microsoft.com/a058d5d3-e654-43f8-a308-c3bdfdd0be4a/file/89212/73/PostSharp-4.2.15.exe
Install-Extension https://visualstudiogallery.msdn.microsoft.com/c9eb3ba8-0c59-4944-9a62-6eee37294597/file/156893/12/PowerShellTools.14.0.vsix PowerShellTools.vsix # v3.0.299
Install-Extension https://visualstudiogallery.msdn.microsoft.com/34ebc6a2-2777-421d-8914-e29c1dfa7f5d/file/169971/1/ProPowerTools.vsix ProPowerTools.vsix # v14.0.23120.0
Install-Extension https://visualstudiogallery.msdn.microsoft.com/b08b0375-139e-41d7-af9b-faee50f68392/file/5131/12/SnippetDesigner.vsix SnippetDesigner.vsix # v1.6.2
Install-Extension https://visualstudiogallery.msdn.microsoft.com/c74211e7-cb6e-4dfa-855d-df0ad4a37dd6/file/160542/7/TechTalk.SpecFlow.Vs2015Integration.v2015.1.2.vsix SpecFlow.vsix # v2015.1.2
Install-Extension https://visualstudiogallery.msdn.microsoft.com/f4d9c2b5-d6d7-4543-a7a5-2d7ebabc2496/file/63103/9/VSColorOutput.vsix VSColorOutput.vsix # v1.4.8
Install-Extension https://visualstudiogallery.msdn.microsoft.com/c84be782-b1f1-4f6b-85bb-945ebc852aa1/file/189507/2/SquaredInfinity.VSCommands.VscPackage.vsix.vs14.vsix VSCommands.vsix # v14.4.0.2

# Web
# no Dev14 yet Install-Extension https://visualstudiogallery.msdn.microsoft.com/f0589156-a8e6-47db-8bac-90f01ca6b8a3/file/80662/4/Cobisi.RoutingAssistant-v1.8.vsix RoutingAssistant.vsix # v1.8
Install-Extension https://visualstudiogallery.msdn.microsoft.com/ee6e6d8c-c837-41fb-886a-6b50ae2d06a2/file/146119/33/Web%20Essentials%202015.1%20v1.0.198.vsix WebEssentials.vsix # v1.0.198
Install-Extension https://visualstudiogallery.msdn.microsoft.com/9ec27da7-e24b-4d56-8064-fd7e88ac1c40/file/164487/23/Bundler%20%26%20Minifier%20v1.5.134.vsix Bundler-Minifier.vsix # v1.5.134
Install-Extension https://visualstudiogallery.msdn.microsoft.com/a56eddd3-d79b-48ac-8c8f-2db06ade77c3/file/38601/29/Image%20Optimizer%20v3.2.41.vsix ImageOptimizer.vsix # v3.2.41
Install-Extension https://visualstudiogallery.msdn.microsoft.com/3b329021-cd7a-4a01-86fc-714c2d05bb6c/file/164873/30/Web%20Compiler%20v1.8.270.vsix WebCompiler.vsix # v1.8.270
Install-Extension https://visualstudiogallery.msdn.microsoft.com/2b96d16a-c986-4501-8f97-8008f9db141a/file/53962/62/Mindscape.WebWorkbench.Integration.10.vsix WebWorkbench.vsix # v3.4.1837

# Extra
# Install-Extension https://visualstudiogallery.msdn.microsoft.com/fb5badda-4ea3-4314-a723-a1975cbdabb4/file/100523/7/Microsoft.CodeDigger.vsix CodeDigger.vsix # v.0.95.4
# Install-Extension https://visualstudiogallery.msdn.microsoft.com/ad0897b3-7537-4c92-a38c-104b0e005206/file/75983/6/PerfWatsonMonitor.vsix PerfWatsonMonitor.vsix # v11.15.1103.1
# Install-Extension https://visualstudiogallery.msdn.microsoft.com/59ca71b3-a4a3-46ca-8fe1-0e90e3f79329/file/6390/57/VsVim.vsix VsVim.vsix # v2.0.1.0
