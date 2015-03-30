$package = 'jivkok.GitConfig'

try {
    Write-Host "Manually edit $ENV:USERPROFILE\.gitconfig to revert package changes"
} catch {
    Write-ChocolateyFailure $package "$($_.Exception.Message)"
    throw
}
