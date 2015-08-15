$package = 'jivkok.SublimeText3.Packages'

function Get-CurrentDirectory
{
  $thisName = $MyInvocation.MyCommand.Name
  [IO.Path]::GetDirectoryName((Get-Content function:$thisName).File)
}

try {
  $current = Get-CurrentDirectory

  . (Join-Path $current 'JsonHelpers.ps1')
  . (Join-Path $current 'SublimeHelpers.ps1')

  # settings & key bindings
  $sublimeUserDataPath = Get-SublimeUserPath
  Get-ChildItem $current -filter '*.sublime-settings' |
    % {
      $params = @{
        Path = Join-Path $current $_;
        Destination = Join-Path $sublimeUserDataPath $_;
        Force = $true
      }
      Copy-Item @params
    }
  Get-ChildItem $current -filter '*.sublime-keymap' |
    % {
      $params = @{
        Path = Join-Path $current $_;
        Destination = Join-Path $sublimeUserDataPath $_;
        Force = $true
      }
      Copy-Item @params
    }

  # color schemes
  $sublimeColorSchemePath = Get-SublimeColorSchemePath
  Get-ChildItem $current -filter '*.tmTheme' |
    % {
      $params = @{
        Path = Join-Path $current $_;
        Destination = Join-Path $sublimeColorSchemePath $_;
        Force = $true
      }
      Copy-Item @params
    }

  Install-SublimePackageControl -Version 3

  if (Get-Process -Name sublime_text -ErrorAction SilentlyContinue)
  {
    Write-Warning 'Please close and re-open Sublime Text to force packages to update'
  }
} catch {
  Write-ChocolateyFailure $package "$_"
  throw
}
