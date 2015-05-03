# Parse input argument string into a hashtable
# Format: Features:WebTools,Win8SDK ProductKey:AB-D1
function Parse-Parameters ($s)
{
    $MATCH_PATTERN = '([a-zA-Z]+):([a-zA-Z0-9-_,]+)'
    $NAME_INDEX = 1
    $VALUE_INDEX = 2

    $parameters = @{ }
    $results = $s | Select-String $MATCH_PATTERN -AllMatches
    foreach ($match in $results.matches)
    {
        $parameters.Add($match.Groups[$NAME_INDEX].Value.Trim(), $match.Groups[$VALUE_INDEX].Value.Trim())
    }

    return $parameters
}

# Turns on features in the customizations file
function Update-Admin-File($parameters, $adminFile)
{
    $s = $parameters['Features']
    if (!$s) { return }

    $features = $s.Split(',')
    [xml]$xml = Get-Content $adminFile

    foreach ($feature in $features)
    {
        $node = $xml.DocumentElement.SelectableItemCustomizations.ChildNodes | ? {$_.Id -eq "$feature"}
        if ($node -ne $null)
        {
            $node.Selected = "yes"
        }
    }
    $xml.Save($adminFile)
}

function Generate-Install-Arguments-String($parameters, $adminFile)
{
    $s = "/Passive /NoRestart /Log $env:temp\vs.log"

    $f = $parameters['Features']
    if ($f)
    {
        $s = $s + " /AdminFile $adminFile"
    }

    $pk = $parameters['ProductKey']
    if ($pk)
    {
        $s = $s + " /ProductKey $pk"
    }

    return $s
}
