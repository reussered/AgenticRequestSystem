$tasks = @("ValidateOutput", "Sweep-And-Verify", "Generate-TestReport")
foreach ($task in $tasks) {
    $scriptPath = "$PSScriptRoot\$task.ps1"
    if (Test-Path $scriptPath) {
        Write-Host "Running: $task"
        & $scriptPath
    } else {
        Write-Warning "$task script not found."
    }
}
