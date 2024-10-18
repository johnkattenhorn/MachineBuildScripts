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

# Install Git with additional parameters
choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"

# Verify Git installation
if (Get-Command git -ErrorAction SilentlyContinue) {
    git --version
    Write-Host "Git installed successfully." -ForegroundColor Green
    
    # Set Git user name and email (replace with actual name and email)
    git config --global user.name "John Kattenhorn"
    git config --global user.email "john.kattenhorn@applicita.com"

    # Verify Git configuration
    Write-Host "Git configuration:"
    git config --global --list
} else {
    Write-Host "Git installation failed." -ForegroundColor Red
}

# Install required packages
choco install docker-desktop jetbrainstoolbox vscode dotnet-sdk microsoft-windows-terminal oh-my-posh nerd-fonts-hack azure-cli microsoftazurestoragexplorer devtoys -y

# Restart the shell to ensure all changes take effect
Write-Host "Chocolatey setup complete. Please restart the shell to continue with further configurations." -ForegroundColor Green

# Configure Docker to start at login
try {
    Start-Process -Wait -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    Write-Host "Docker started successfully." -ForegroundColor Green
} catch {
    Write-Host "Failed to start Docker. Please check the installation and try again." -ForegroundColor Red
}

# Show hidden files and file extensions
Write-Host "Configuring system to show hidden files and file extensions..." -ForegroundColor Yellow
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name Hidden -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name HideFileExt -Value 0

# Configure Oh My Posh in PowerShell profile
# Check if PowerShell profile exists; create it if not
if (-not (Test-Path -Path $PROFILE)) {
    New-Item -Type File -Force -Path $PROFILE
}

# Add Oh My Posh line to profile if not already present
$profileContent = Get-Content -Path $PROFILE
if (-not ($profileContent -contains 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression')) {
    Add-Content -Path $PROFILE -Value 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression'
    Write-Host "Added Oh My Posh configuration to PowerShell profile." -ForegroundColor Green
} else {
    Write-Host "Oh My Posh configuration already present in PowerShell profile." -ForegroundColor Yellow
}

Write-Host "Setup complete. Please restart your computer to apply all changes." -ForegroundColor Green