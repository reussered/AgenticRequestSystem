function Validate-AgentMetadata {
    param (
        [string]$ScriptPath
    )

    $metadata = Get-Content $ScriptPath | Select-String -Pattern '^<#(.|\s)*?#>' -AllMatches | ForEach-Object { $_.ToString() }
    if (-not $metadata) {
        Write-Warning "No metadata block found in $ScriptPath"
        return $false
    }

    $requiredFields = @("Author", "Created", "Permissions", "Dependencies", "UID")
    foreach ($field in $requiredFields) {
        if ($metadata -notmatch "$field:") {
            Write-Warning "Missing metadata field: $field"
            return $false
        }
    }

    return $true
}
Export-ModuleMember -Function Validate-AgentMetadata
