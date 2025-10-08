param (
    [string]$Action,
    [string]$FilePath
)

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$sessionID = [guid]::NewGuid().ToString()
$log = "[${timestamp}] [$sessionID] $Action: $FilePath"

$log | Out-File -Append "$PSScriptRoot\..\Logs\FileActions.log"
Write-Host "Logged: $log"
