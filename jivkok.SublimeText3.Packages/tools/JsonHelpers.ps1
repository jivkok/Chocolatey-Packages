function ConvertFrom-UnicodeEscaped
{
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline=$true, Mandatory = $true)]
    [String]
    $Text
  )

  $regex = [regex]'\\[uU]([0-9A-Fa-f]{4})'
  $callback = {
    $match = $args[0]
    $hexStyle = [Globalization.NumberStyles]::HexNumber
    ([Char][Int32]::Parse($match.Value.Substring(2), $hexStyle)).ToString()
  }

  $regex.Replace($Text, $callback)
}

# HACK: this *must* be called after a file has been merged together to sanitize it
function ConvertTo-DoubleEscapedQuotes
{
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline=$true, Mandatory = $true)]
    [String]
    $Text,

    [Parameter(Mandatory = $false)]
    [String]
    $Name = ''
  )

  # HACK: stupid powershell has a bug and doesn't allow " in JSON values
  # So we're forced to double it up... which might not always work.. sigh
  # If we try to get sneaky it doesn't matter -> i.e. -replace '\"', '\u0022'
  # https://connect.microsoft.com/PowerShell/feedback/details/735978/convertto-json-in-psv3-beta-does-not-support-values-containing-double-quotes
  if ($Text -match '"')
  {
    $old = $Text
    $Text = $Text -replace '"', '""'
    Write-Warning "Circumventing Powershell bug - replacing $Name string $old with $Text"
  }

  return $Text
}

function Merge-JsonNamedValue
{
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [String]
    $Name,

    [Parameter(Mandatory = $true)]
    [PSCustomObject]
    $Destination,

    [Parameter(Mandatory = $true)]
    $Value
  )

  if (!($Destination | Get-Member -Name $Name))
  {
    $Destination |
      Add-Member -Name $Name -Value $Value -MemberType NoteProperty
  }
  else
  {
    $Destination.$Name = $Value
  }
}

function Merge-JsonArray
{
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [String]
    $Name,

    [Parameter(Mandatory = $true)]
    [PSCustomObject]
    $Destination,

    [Parameter(Mandatory = $true)]
    [Object[]]
    $Array
  )

  if (!$Destination.$Name)
  {
    $Destination |
      Add-Member -Name $Name -Value $Array -MemberType NoteProperty
  }
  else
  {
    $Destination.$Name = ($Destination.$Name + $Array | Sort-Object -Unique)
  }
}

function Merge-JsonSimpleMap
{
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [String]
    $Name,

    [Parameter(Mandatory = $true)]
    [PSCustomObject]
    $Destination,

    [Parameter(Mandatory = $true)]
    [PSCustomObject]
    $SimpleMap
  )

  if (!$Destination.$Name)
  {
    $Destination |
      Add-Member -Name $Name -Value ([PSCustomObject]@{}) -MemberType NoteProperty
  }

  $currentHash = $Destination.$Name
  $SimpleMap.PSObject.Properties |
    % {
      $key = $_.Name
      if (!$currentHash.$key)
      {
        $currentHash |
          Add-Member -Name $key -Value $_.Value -MemberType NoteProperty
      }
      else
      {
        $currentHash.$key = $_.Value
      }
    }
}

function Create-CustomObjectKey
{
 [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [PSCustomObject]
    $Object
  )

  $key = ''
  $Object.PSObject.Properties |
    % {
      $key += "{$($_.Name):$($_.Value)}"
    }

  return $key
}

function Merge-JsonArrayOfSimpleMap
{
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $true)]
    [String]
    $Name,

    [Parameter(Mandatory = $true)]
    [PSCustomObject]
    $Destination,

    [Parameter(Mandatory = $true)]
    [Object[]]
    $Array
  )

  if (!$Destination.$Name)
  {
    $Destination |
      Add-Member -Name $Name -Value $Array -MemberType NoteProperty
  }
  else
  {
    $merged = $Destination.$Name + $Array
    $seen = @()
    $Destination.$Name = $merged |
      ? { $seen -inotcontains (Create-CustomObjectKey $_) } |
      % {
        $seen += (Create-CustomObjectKey $_)
        $_
      }
  }
}
