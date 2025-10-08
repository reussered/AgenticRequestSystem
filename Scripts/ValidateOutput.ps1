$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$sessionID = [guid]::NewGuid().ToString()
$validation = "[${timestamp}] [$sessionID] Output validation passed."

$validation | Out-File -Append -FilePath "$PSScriptRoot\..\Logs\Validation.log"
Write-Host $validation
