<#
.SYNOPSIS
    Signals the batch system to stop after current file.
#>

New-Item -Path ".\stop.flag" -ItemType File -Force | Out-Null
Write-Host "🛑 Stop flag created. Batch will halt after current file."
