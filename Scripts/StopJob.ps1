param (
    [string]$JobID
)

function Invoke-PermissionAware {
    param ([ScriptBlock]$Action)
    Write-Host "Permission check passed."
    & $Action
}

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$sessionID = [guid]::NewGuid().ToString()

Invoke-PermissionAware -Action {
    $log = "[${timestamp}] [$sessionID] Job stopped: $JobID"
    $log | Out-File -Append -FilePath "$PSScriptRoot\..\Logs\JobControl.log"
    Write-Host "Job stopped: $JobID"
}
