param (
    [string]$InputPath,
    [string]$OutputPath
)

if (!(Test-Path $InputPath)) {
    Write-Warning "Input file not found: $InputPath"
    return
}

$content = Get-Content $InputPath -Raw
$transformed = $content.ToUpper()
$transformed | Out-File $OutputPath

Write-Host "Transformation complete: $OutputPath"
