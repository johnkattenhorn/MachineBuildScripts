# Windows Developer Setup Guide

This guide provides the steps to set up a full development environment on **Windows 11 Professional** using **Chocolatey** as the package manager. The setup includes Docker, JetBrains Toolbox, Visual Studio Code, Git, .NET SDK, Azure CLI, Microsoft Azure Storage Explorer, DevToys, and terminal customization.

## Table of Contents

1. [Install Chocolatey (Windows Package Manager)](#install-chocolatey-windows-package-manager)
2. [Set PowerShell Execution Policy](#set-powershell-execution-policy)
3. [Install Docker Desktop](#install-docker-desktop)
4. [Install Git](#install-git)
5. [Install JetBrains Toolbox](#install-jetbrains-toolbox)
6. [Install Visual Studio Code](#install-visual-studio-code)
7. [Install .NET SDK](#install-net-sdk)
8. [Install Azure CLI, Storage Explorer, and DevToys](#install-azure-cli-storage-explorer-and-devtoys)
9. [Customize Terminal (Oh My Posh)](#customize-terminal-oh-my-posh)
10. [Automation Script with Chocolatey](#automation-script-with-chocolatey)
11. [Conclusion](#conclusion)

---

## Install Chocolatey (Windows Package Manager)

1. **Open PowerShell as Administrator**:  
   Right-click the **Start** button and select **Windows Terminal (Admin)**. All subsequent steps should be run in an **administrative shell**.

2. **Run the following command to install Chocolatey**:

   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

3. **Restart the shell**:  
   Close and reopen the administrative PowerShell to ensure that Chocolatey is available in the new session.

4. **Verify Chocolatey installation**:

   ```powershell
   choco -v
   ```

---

## Set PowerShell Execution Policy

1. **Set PowerShell execution policy to allow scripts to run**:

   PowerShell may block scripts from running due to its security settings. To allow local scripts, such as the **Oh My Posh** configuration, to run, set the execution policy to **RemoteSigned**:

   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
   ```

   This allows locally created scripts to run without being signed but ensures scripts downloaded from the internet must be signed by a trusted publisher.

---

## Install Docker Desktop

1. **Install Docker Desktop using Chocolatey**:

   ```powershell
   choco install docker-desktop -y
   ```

2. **Enable Docker to start at login**:
   Open Docker Desktop and go to **Settings > General**, then enable **"Start Docker Desktop when you log in."**

3. **Verify Docker installation**:
   Open PowerShell and run:

   ```powershell
   docker run hello-world
   ```

---

## Install Git

1. **Install Git using Chocolatey** with additional parameters to ensure it's added to the system PATH:

   ```powershell
   choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
   ```

2. **Verify Git installation**:

   ```powershell
   git --version
   ```

---

## Install JetBrains Toolbox

1. **Install JetBrains Toolbox using Chocolatey**:

   ```powershell
   choco install jetbrainstoolbox -y
   ```

2. **Run JetBrains Toolbox from the Start Menu** and install any JetBrains IDEs (e.g., Rider) as needed.

---

## Install Visual Studio Code

1. **Install Visual Studio Code using Chocolatey**:

   ```powershell
   choco install vscode -y
   ```

2. **Install C# and Docker extensions**:
   - Open Visual Studio Code and go to the Extensions Marketplace.
   - Search for and install the **C#** and **Docker** extensions.

---

## Install .NET SDK

1. **Install the latest .NET SDK using Chocolatey**:

   ```powershell
   choco install dotnet-sdk -y
   ```

2. **Verify installation**:

   ```powershell
   dotnet --list-sdks
   ```

---

## Install Azure CLI, Storage Explorer, and DevToys

1. **Install Azure CLI, Microsoft Azure Storage Explorer, and DevToys using Chocolatey**:

   ```powershell
   choco install azure-cli microsoftazurestoragexplorer devtoys -y
   ```

2. **Verify Azure CLI installation**:

   ```powershell
   az --version
   ```

---

## Customize Terminal (Oh My Posh)

1. **Install Windows Terminal** (if not already installed):

   ```powershell
   choco install microsoft-windows-terminal -y
   ```

2. **Install Oh My Posh**:

   ```powershell
   choco install oh-my-posh -y
   ```

3. **Configure Oh My Posh in Windows Terminal**:
   - Open **Windows Terminal** and go to **Settings**.
   - In the **PowerShell** profile, add the following line to your profile script (usually located at `Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

     ```powershell
     oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
     ```

4. **Install a Nerd Font** (for better prompt appearance):

   ```powershell
   choco install nerd-fonts-hack -y
   ```

   Set this font in Windows Terminal's settings.

---

## Automation Script with Chocolatey

To automate the installation using Chocolatey, you can create a PowerShell script with the following content:

```powershell
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

# Set PowerShell execution policy to allow running scripts
Write-Host "Setting PowerShell execution policy to RemoteSigned..." -ForegroundColor Yellow
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

# Install Git with additional parameters
choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"

# Verify Git installation
if (Get-Command git -ErrorAction SilentlyContinue) {
    git --version
    Write-Host "Git installed successfully." -ForegroundColor Green
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
    Add-Content -Path $PROFILE -Value 'oh-my-posh init

 pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression'
    Write-Host "Added Oh My Posh configuration to PowerShell profile." -ForegroundColor Green
} else {
    Write-Host "Oh My Posh configuration already present in PowerShell profile." -ForegroundColor Yellow
}

Write-Host "Setup complete. Please restart your computer to apply all changes." -ForegroundColor Green
```

To run the script:

1. **Save the script** to a file, e.g., `setup-dev-environment.ps1`.
2. **Run the script in PowerShell as Administrator**:

   ```powershell
   .\setup-dev-environment.ps1
   ```

---

## Conclusion

Your Windows 11 environment should now be set up for .NET development, Docker, Azure, and other tasks. All steps have been automated with Chocolatey to streamline the process. If you encounter any issues, check for common solutions or consult the relevant documentation.