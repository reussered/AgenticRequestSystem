<#
.SYNOPSIS
    Reorders JSON keys to ensure 'nameId' is first.
.DESCRIPTION
    Accepts raw JSON string, returns modified JSON string.
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$JsonText
)

try {
    $json = $JsonText | ConvertFrom-Json
    $props = $json.PSObject.Properties.Name

    if ($props[0] -ne "nameId") {
        $ordered = [ordered]@{ nameId = $json.nameId }
        foreach ($key in $props) {
            if ($key -ne "nameId") {
                $ordered[$key] = $json.$key
            }
        }
        return ($ordered | ConvertTo-Json -Depth 5)
    } else {
        return $JsonText
    }
} catch {
    throw "Transformation failed: $($_.Exception.Message)"
}
