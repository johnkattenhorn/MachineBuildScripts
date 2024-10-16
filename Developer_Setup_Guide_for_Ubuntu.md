# Developer Setup Guide for Ubuntu

This guide provides the steps to set up a full development environment on **Ubuntu 24.04 LTS** for Docker-based development, along with other essential tools like JetBrains Toolbox, OneDrive sync, and Portainer for Docker management.

## Table of Contents

1. [System Update and Prerequisites](#system-update-and-prerequisites)
2. [Install Docker](#install-docker)
3. [Install Portainer (Docker GUI)](#install-portainer-docker-gui)
4. [Install JetBrains Toolbox](#install-jetbrains-toolbox)
5. [Install Visual Studio Code](#install-visual-studio-code)
6. [Install OneDrive Sync with GUI](#install-onedrive-sync-with-gui)
7. [Install .NET SDK](#install-net-sdk)
8. [Customize Zsh Shell](#customize-zsh-shell)
9. [Bash Script for Automation](#bash-script-for-automation)
10. [Known Issues](#known-issues)
11. [Conclusion](#conclusion)

---

## System Update and Prerequisites

### Prerequisites

1) This guide is tested on **Ubuntu 24.04 LTS**. Ensure you are using this version.
2) Ensure you have **root** or **sudo** access for the installation steps.
3) Start by updating the system and installing essential packages:

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential apt-transport-https ca-certificates curl gnupg lsb-release zsh git
```

---

## Install Docker

1. **Add Docker’s official GPG key**:

    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    ```

2. **Set up the stable Docker repository**:

    ```bash
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```

3. **Install Docker Engine**:

    ```bash
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io
    ```

4. **Add your user to the Docker group** (so you don't need `sudo`):

    ```bash
    sudo usermod -aG docker $USER
    newgrp docker
    ```

    **Note**: Log out and log back in to apply the group change, or run `newgrp docker` to activate the group change immediately in your current session.

5. **Restart Docker to ensure it's running**:

    ```bash
    sudo systemctl restart docker
    ```

6. **Verify Docker is installed and running**:

    ```bash
    docker run hello-world
    ```

---

## Install Portainer (Docker GUI)

1. **Create Portainer volume and start the container**:

    ```bash
    docker volume create portainer_data
    docker run -d -p 9000:9000 --name portainer --restart=always \
      -v /var/run/docker.sock:/var/run/docker.sock \
      -v portainer_data:/data portainer/portainer-ce
    ```

2. **Access Portainer**:

    Open a browser and go to `http://localhost:9000`. If you’re running this on a remote server, replace `localhost` with the server’s IP address.

    Set up the admin account and start managing your Docker environment through Portainer.

---

## Install JetBrains Toolbox

1. **Install FUSE (required for running AppImages)**:

    ```bash
    sudo apt install libfuse2
    ```

2. **Download and install JetBrains Toolbox**:

    ```bash
    # Create a permanent directory for JetBrains Toolbox
    mkdir -p ~/apps/jetbrains-toolbox

    # Download the JetBrains Toolbox tarball
    curl -L "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.25.12999.tar.gz" -o jetbrains-toolbox.tar.gz

    # Extract the tarball into the target directory without including version numbers
    tar -xvzf jetbrains-toolbox.tar.gz -C ~/apps/jetbrains-toolbox --strip-components=1

    # Execute the toolbox
    cd ~/apps/jetbrains-toolbox
    ./jetbrains-toolbox

    ```

---

## Install Visual Studio Code

### 1. **Add Microsoft GPG Key and Repository**

```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
```

### 2. **Install Visual Studio Code**

```bash
sudo apt update
sudo apt install code
```

### 3. **Install C# and Docker extensions**

Once VS Code is installed, open it and install the following extensions:

- **C#** (for .NET development)
- **Docker** (for managing Docker containers)

---

## Install OneDrive Sync with GUI

### 1. **Install OneDrive client using the latest instructions**

Follow the new installation method for OneDrive from the [abraunegg OneDrive GitHub repository](https://github.com/abraunegg/onedrive/blob/master/docs/ubuntu-package-install.md).

```bash
sudo apt update
sudo apt install -y curl gnupg2 lsb-release
curl -fsS https://download.opensuse.org/repositories/home:the_real_me/deb/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/onedrive.gpg > /dev/null
echo "deb http://download.opensuse.org/repositories/home:/the_real_me/xUbuntu_$(lsb_release -rs)/ /" | sudo tee /etc/apt/sources.list.d/onedrive.list
sudo apt update
sudo apt install onedrive
```

### 2. **Set up OneDrive Sync**

```bash
onedrive --synchronize
```

### 3. **Install OneDrive GUI**

Download the latest release of **OneDriveGUI** from [OneDriveGUI GitHub](https://github.com/bpozdena/OneDriveGUI).

Move OneDriveGUI to your apps folder:

```bash
mv ~/Downloads/OneDriveGUI-1.1.1-x86_64.AppImage ~/apps/OneDriveGUI
chmod +x ~/apps/OneDriveGUI
```

### 4. **Create a Gnome Desktop Shortcut**

```bash
nano ~/.local/share/applications/onedrivegui.desktop
```

Add the following content:

```ini
[Desktop Entry]
Version=1.0
Name=OneDriveGUI
Comment=Graphical interface for OneDrive synchronization
Exec=/home/$USER/apps/OneDriveGUI
Icon=folder-cloud
Terminal=false
Type=Application
Categories=Utility;Network;FileTransfer;
```

Save and close the file.

Finally, make the desktop entry executable:

```bash
chmod +x ~/.local/share/applications/onedrivegui.desktop
```

---

## Install .NET SDK

1. **Install .NET 8 LTS and 9 Preview**:

    ```bash
    wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt update
    sudo apt install -y dotnet-sdk-8.0 dotnet-sdk-9.0
    ```

2. **Verify installation**:

    ```bash
    dotnet --list-sdks
    ```

---

## Customize Zsh Shell

1. **Install Zsh**:

    ```bash
    sudo apt install zsh
    ```

2. **Set Zsh as the default shell**:

    ```bash
    chsh -s $(which zsh)
    ```

3. **Install Oh My Zsh**:

    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

4. **Install Powerlevel10k (Optional)**:

    ```bash
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    ```

    Edit `~/.zshrc`:

    ```bash
    ZSH_THEME="powerlevel10k/powerlevel10k"
    ```

5. **Add Useful Plugins**:

    Add the following plugins to the `plugins` array in your `.zshrc` file:

    ```bash
    plugins=(git docker vscode zsh-autosuggestions zsh-syntax-highlighting)
    ```

6. **Apply Changes**:

    ```bash
    source ~/.zshrc
    ```

---

## Bash Script for Automation

Below is a simple bash script that can automate much of this setup:

```bash
#!/bin/bash

# System update and install prerequisites
sudo apt update && sudo apt upgrade -y


sudo apt install -y build-essential apt-transport-https ca-certificates curl gnupg lsb-release zsh git libfuse2

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER

# Restart Docker
sudo systemctl restart docker

# Install Portainer
docker volume create portainer_data
docker run -d -p 9000:9000 --name portainer --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data portainer/portainer-ce

# Install VS Code via Microsoft repository (not Snap)
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code

# Install .NET SDK 8 LTS and 9 Preview
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install -y dotnet-sdk-8.0 dotnet-sdk-9.0

# Install OneDrive client
sudo apt update
sudo apt install -y curl gnupg2 lsb-release
curl -fsS https://download.opensuse.org/repositories/home:the_real_me/deb/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/onedrive.gpg > /dev/null
echo "deb http://download.opensuse.org/repositories/home:/the_real_me/xUbuntu_$(lsb_release -rs)/ /" | sudo tee /etc/apt/sources.list.d/onedrive.list
sudo apt update
sudo apt install onedrive

# Install JetBrains Toolbox
mkdir -p ~/apps/jetbrains-toolbox
curl -L "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.25.12999.tar.gz" -o jetbrains-toolbox.tar.gz
tar -xvzf jetbrains-toolbox.tar.gz -C ~/apps/jetbrains-toolbox --strip-components=1
~/apps/jetbrains-toolbox/jetbrains-toolbox

# Change default shell to Zsh
chsh -s $(which zsh)
```

To run the script:

1. Save it to a file, e.g., `setup-dev-environment.sh`.
2. Make the file executable:

    ```bash
    chmod +x setup-dev-environment.sh
    ```

3. Run the script:

    ```bash
    ./setup-dev-environment.sh
    ```

---

## Known Issues

### 1. **Docker Desktop UI Fails to Start** (Resolved)

**Issue**: The Docker Desktop backend (Docker daemon) appears to be working correctly, but the **Docker Desktop UI** does not launch when clicking the application icon. This issue was commonly reported by other users.

**Resolution**:  
Upgrading to the **6.11 Kernel** for Ubuntu resolves this issue. Instructions for installing the 6.11 Kernel can be found [here](https://ubuntuhandbook.org/index.php/2024/09/linux-kernel-6-11-released-how-to-install-in-ubuntu-24-04/).

### 2. **Intel AX210 Wireless Adapter Performance** (Resolved)

**Issue**: The **Intel AX210 Wireless Adapter** was experiencing poor performance on Ubuntu, with many community-suggested fixes not resolving the issue.

**Resolution**:  
Upgrading to the **6.11 Kernel** for Ubuntu significantly improves the wireless performance. Follow the [installation guide for the 6.11 Kernel](https://ubuntuhandbook.org/index.php/2024/09/linux-kernel-6-11-released-how-to-install-in-ubuntu-24-04/) to resolve the issue.

---

## Conclusion

Your environment should now be fully set up and ready for .NET development, Docker-based projects, and other tasks. If you encounter any issues, refer to the **Known Issues** section for potential workarounds or contact your system administrator for further support.
