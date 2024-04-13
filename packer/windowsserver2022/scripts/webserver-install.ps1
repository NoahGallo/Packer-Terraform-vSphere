# Check if IIS is already installed
if (-not (Get-WindowsFeature -Name Web-Server | Where-Object {$_.Installed})) {
    # Install IIS
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
}
else {
    Write-Host "IIS is already installed."
}