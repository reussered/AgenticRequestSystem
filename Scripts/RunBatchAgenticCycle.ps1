<#
    Script Name: RunBatchAgenticCycle.ps1
    Purpose: Execute a full agentic cycle across modular scripts with logging and permission-aware dispatch
    Author: Edward J. Reusser
    Last Updated: 2025-10-07
#>

# Define paths
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$modules = Join-Path $root 'Modules'
$logFile = Join-Path $root 'Logs\AgenticCycle.log'

# Import modules
Import-Module "$modules\CopilotUsageTracker.psm1" -ErrorAction SilentlyContinue

# Start logging
Start-UsageLog -LogPath $logFile -Context "Agentic Cycle Start"

# Execute agentic steps
try {
    & "$root\Scripts\Monitor_AgentQueue.ps1"
    & "$root\OpenManus\monitor"
    # Add additional steps here
}
catch {
    Write-Error "Agentic cycle failed: $_"
    Add-UsageLog -LogPath $logFile -Message "Cycle error: $_"
}

# Finalize log
Stop-UsageLog -LogPath $logFile
