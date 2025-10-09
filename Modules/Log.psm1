function Write-LogEntry {
    <#
    .SYNOPSIS
        Writes a timestamped log entry to a specified log file.
    .DESCRIPTION
        Used for runtime logging, audit trails, and session summaries.
    .PARAMETER Message
        The log message to record.
    .PARAMETER LogPath
        Optional path to the log file. Defaults to Logs\RuntimeLog.txt.
    .EXAMPLE
        Write-LogEntry -Message "Agent cycle started."
    #>
    param (
        [Parameter(Mandatory)]
        [string]$Message,
        [string]$LogPath = "F:\GitHub\AgenticRequestSystem\Logs\RuntimeLog.txt"
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "$timestamp | $Message"
    Add-Content -Path $LogPath -Value $entry
}

function Export-SessionSummary {
    <#
    .SYNOPSIS
        Generates a print-ready summary of the current session.
    .DESCRIPTION
        Includes modules loaded, recent actions, and timestamp.
    .PARAMETER OutputPath
        Path to save the summary file.
    .EXAMPLE
        Export-SessionSummary -OutputPath "F:\GitHub\AgenticRequestSystem\Logs\SessionSummary.txt"
    #>
    param (
        [string]$OutputPath = "F:\GitHub\AgenticRequestSystem\Logs\SessionSummary.txt"
    )

    $summary = @"
AgenticRequestSystem – Session Summary
Date: $(Get-Date