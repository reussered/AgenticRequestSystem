<#
.SYNOPSIS
    Logs file actions with metadata.
.DESCRIPTION
    Appends structured JSON entries to log file.
#>

param (
    [string]$Action,
    [string]$FilePath,
    [string]$Status,
    [string]$LogPath,
    [string]$Message = ""
)

$entry = @{
    timestamp = (Get-Date -Format 's')
    action    = $Action
    file      = $FilePath
    status    = $Status
    message   = $Message
}

$entry | ConvertTo-Json -Depth 3 | Add-Content -Path $LogPath
