<#
.SYNOPSIS
    Validates JSON output files for structure and required fields.
.DESCRIPTION
    Scans one or more JSON files, checks for required keys, and logs results.
    Designed for reproducible audit logging and integration with agentic workflows.
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$Path,

    [string[]]$RequiredKeys = @("requestId", "timestamp", "status", "payload"),

    [switch]$Recurse,

    [string]$LogFile = "$PSScriptRoot\validation.log"
)

function Validate-JsonFile {
    param (
        [string]$FilePath,
        [string[]]$Keys
    )

    try {
        $json = Get-Content $FilePath -Raw | ConvertFrom-Json
        $missingKeys = $Keys | Where-Object { -not $json.PSObject.Properties.Name -contains $_ }

        if ($missingKeys.Count -eq 0) {
            Write-Output "✅ $FilePath passed validation."
            Add-Content -Path $LogFile -Value "$(Get-Date -Format 's') PASS $FilePath"
        } else {
            Write-Output "❌ $FilePath missing keys: $($missingKeys -join ', ')"
            Add-Content -Path $LogFile -Value "$(Get-Date -Format 's') FAIL $FilePath missing: $($missingKeys -join ', ')"
        }
    } catch {
        Write-Output "⚠️ $FilePath could not be parsed as JSON."
        Add-Content -Path $LogFile -Value "$(Get-Date -Format 's') ERROR $FilePath parse failure"
    }
}

# Main execution
$files = if (Test-Path $Path -PathType Container) {
    Get-ChildItem -Path $Path -Filter *.json -Recurse:$Recurse
} elseif (Test-Path $Path -PathType Leaf) {
    Get-Item $Path
} else {
    throw "Invalid path: $Path"
}

foreach ($file in $files) {
    Validate-JsonFile -FilePath $file.FullName -Keys $RequiredKeys
}
