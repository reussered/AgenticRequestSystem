function Validate-AgentMetadata {
    <#
    .SYNOPSIS
        Validates embedded metadata block in a script file.
    .DESCRIPTION
        Checks for presence of metadata block and required fields.
        Also validates UID format and timestamp integrity.
    .PARAMETER ScriptPath
        Path to the script file to validate.
    .EXAMPLE
        Validate-AgentMetadata -ScriptPath "Scripts\RunBatchAgenticCycle.ps1"
    #>
    param (
        [Parameter(Mandatory)]
        [string]$ScriptPath
    )

    if (-not (Test-Path $ScriptPath)) {
        Write-Warning "Script not found: $ScriptPath"
        return $false
    }

    $metadata = Get-Content $ScriptPath | Select-String -Pattern '^<#(.|\s)*?#>' -AllMatches | ForEach-Object { $_.ToString() }
    if (-not $metadata) {
        Write-Warning "No metadata block found in $ScriptPath"
        return $false
    }

    $requiredFields = @("Author", "Created", "Permissions", "Dependencies", "UID")
    $valid = $true

    foreach ($field in $requiredFields) {
        if ($metadata -notmatch "$field:") {
            Write-Warning "Missing metadata field: $field"
            $valid = $false
        }
    }

    # Validate UID format (e.g., GUID)
    if ($metadata -match "UID:\s*([a-fA-F0-9\-]{36})") {
        Write-Verbose "Valid UID format detected."
    } else {
        Write-Warning "Invalid or missing UID format."
        $valid = $false
    }

    # Validate Created timestamp format
    if ($metadata -match "Created:\s*(\d{4}-\d{2}-\d{2})") {
        $date = $matches[1]
        try {
            [datetime]::ParseExact($date, 'yyyy-MM-dd', $null) | Out-Null
        } catch {
            Write-Warning "Invalid Created date format: $date"
            $valid = $false
        }
    } else {
        Write-Warning "Missing Created date."
        $valid = $false
    }

    return $valid
}

function Validate-ScriptStructure {
    <#
    .SYNOPSIS
        Validates basic structure of a PowerShell script.
    .DESCRIPTION
        Checks for presence of param block, function definitions, and export statements.
    .PARAMETER ScriptPath
        Path to the script file to validate.
    .EXAMPLE
        Validate-ScriptStructure -ScriptPath "Scripts\RunBatchAgenticCycle.ps1"
    #>
    param (
        [Parameter(Mandatory)]
        [string]$ScriptPath
    )

    $content = Get-Content $ScriptPath -Raw
    $valid = $true

    if ($content -notmatch 'param\s*\(') {
        Write-Warning "Missing param block in $ScriptPath"
        $valid = $false
    }

    if ($content -notmatch 'function\s+\w+') {
        Write-Warning "No function definitions found in $ScriptPath"
        $valid = $false
    }

    if ($content -notmatch 'Export-ModuleMember') {
        Write-Warning "Missing Export-ModuleMember statement in $ScriptPath"
        $valid = $false
    }

    return $valid
}

Export-ModuleMember -Function Validate-AgentMetadata, Validate-ScriptStructure
