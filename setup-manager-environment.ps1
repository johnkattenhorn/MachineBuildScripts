# Install Chocolatey if not already installed
if (-Not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    # Set package manager to Chocolately
    #--- Install NuGet library and mark it as trusted ---
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

    #--- Set up choco as a package provider ---
    Write-Host "Bootstrapping Chocolatey provider" -ForegroundColor Yellow
    Get-PackageProvider -Name Chocolatey -ForceBootstrap | Out-Null
    Write-Host "Trusting Chocolatey provider" -ForegroundColor Yellow
    Set-PackageSource -Name chocolatey -Trusted -Force
}

# Install Office 365 and Microsoft Teams
choco install office365proplus microsoft-teams -y

# Install Communication Tools
choco install slack discord reddit-browser flow -y

# Install Browsers
choco install firefox googlechrome -y

# Install Additional Productivity Tools
choco install enpass zoom microsoft-todo -y

# Restart the shell to ensure all changes take effect
Write-Host "Chocolatey setup complete. Please restart the shell to continue with further configurations." -ForegroundColor Green