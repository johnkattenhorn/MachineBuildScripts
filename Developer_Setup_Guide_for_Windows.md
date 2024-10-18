# Windows Developer Setup Guide

This guide provides the steps to set up a full development environment on **Windows 11 Professional** using **Chocolatey** as the package manager. The setup includes Docker, JetBrains Toolbox, Visual Studio Code, .NET SDK, and terminal customization.

## Table of Contents

1. [Install Chocolatey (Windows Package Manager)](#install-chocolatey-windows-package-manager)
2. [Install Docker Desktop](#install-docker-desktop)
3. [Install JetBrains Toolbox](#install-jetbrains-toolbox)
4. [Install Visual Studio Code](#install-visual-studio-code)
5. [Install .NET SDK](#install-net-sdk)
6. [Customize Terminal (Oh My Posh)](#customize-terminal-oh-my-posh)
7. [Automation Script with Chocolatey](#automation-script-with-chocolatey)
8. [Conclusion](#conclusion)

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
}

# Install required packages
choco install docker-desktop jetbrainstoolbox vscode dotnet-sdk microsoft-windows-terminal oh-my-posh nerd-fonts-hack -y

# Restart the shell to ensure all changes take effect
Write-Host "Chocolatey setup complete. Please restart the shell to continue with further configurations." -ForegroundColor Green

# Configure Docker to start at login
Start-Process -Wait -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe"
# Wait for Docker to start and configure settings manually in Docker Desktop UI

# Configure Oh My Posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression

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

Your Windows 11 environment should now be set up for .NET development, Docker, and other tasks. All steps have been automated with Chocolatey to streamline the process. If you encounter any issues, check for common solutions or consult the relevant documentation.