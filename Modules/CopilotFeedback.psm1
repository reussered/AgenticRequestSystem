function Format-ForCopilot {
    param (
        [string]$UID,
        [string]$Status,
        [string]$Details
    )

    return @"
### Agent Execution Report
- **UID**: $UID
- **Status**: $Status
- **Details**: $Details
"@
}
Export-ModuleMember -Function Format-ForCopilot
