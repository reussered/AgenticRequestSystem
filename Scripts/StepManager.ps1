param (
    [string]$StepName
)

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$sessionID = [guid]::NewGuid().ToString()
$log = "[${timestamp}] [$sessionID] Step executed: $StepName"

$log | Out-File -Append -FilePath "$PSScriptRoot\..\Logs\StepManager.log"
Write-Host "Step logged: $StepName"
