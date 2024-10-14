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