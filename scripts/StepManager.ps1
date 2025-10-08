<#
.SYNOPSIS
    StepManager – Handles recursive execution and step chaining

.DESCRIPTION
    Increments step index, loads next AI-generated code block, and invokes AgenticRequest.ps1.
    Supports chaining, logging, and optional validation.

.NOTES
    Author: Edward J. Reusser
#>

param (
    [int]$StartIndex = 1,
    [int]$MaxSteps = 10
)

$CurrentStep = $StartIndex
$WorkflowID = "FPW-2025-DesignLoop-001"

while ($CurrentStep -le $MaxSteps) {
    Write-Host "`n=== Executing Step $CurrentStep ==="

    # Simulate hash generation (replace with actual logic later)
    $CodeBaseHash = "step-$CurrentStep-hash"
    $ValidationStatus = "Pending"

    # Call AgenticRequest.ps1
    & "$PSScriptRoot\AgenticRequest.ps1" `
        -StepIndex $CurrentStep `
        -WorkflowID $WorkflowID `
        -CodeBaseHash $CodeBaseHash `
        -ValidationStatus $ValidationStatus

    # Optional: Validate output
    & "$PSScriptRoot\Validate-Output.ps1" -StepIndex $CurrentStep

    $CurrentStep++
}
