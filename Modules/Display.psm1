function Show-ProgressBar {
    param (
        [int]$Percent,
        [string]$Label
    )

    $bar = "#" * ($Percent / 5) + "-" * (20 - ($Percent / 5))
    Write-Host "$Label [$bar] $Percent%" -ForegroundColor Cyan
}

function Show-Summary {
    param (
        [string]$UID,
        [string]$Result
    )

    Write-Host "Execution Summary for $UID:" -ForegroundColor Green
    Write-Host "Result: $Result" -ForegroundColor Yellow
}
Export-ModuleMember -Function Show-ProgressBar, Show-Summary
