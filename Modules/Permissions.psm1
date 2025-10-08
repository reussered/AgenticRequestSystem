function Request-Permissions {
    param (
        [string[]]$Requested
    )

    $granted = @()
    foreach ($perm in $Requested) {
        $response = Read-Host "Grant permission '$perm'? (y/n)"
        if ($response -eq 'y') {
            $granted += $perm
        }
    }

    return $granted
}
Export-ModuleMember -Function Request-Permissions
