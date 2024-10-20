# Makers & Managers Toolkit

This repository provides a **cross-platform toolkit** for onboarding both **Makers** (developers) and **Managers** in our company, **Applicita**. These setup guides and automation scripts are used internally to streamline workspace setup across **Ubuntu** and **Windows** environments. We have decided to open-source these tools to share them with others who may find them useful for their own teams.

## Table of Contents

1. [Overview](#overview)
2. [Setup Guides](#setup-guides)
   - [Makers Setup Guides](#makers-setup-guides)
   - [Managers Setup Guides](#managers-setup-guides)
3. [Automation Scripts](#automation-scripts)
4. [Getting Started](#getting-started)
5. [Contribution Guidelines](#contribution-guidelines)
6. [License](#license)

---

## Overview

The **Makers & Managers Toolkit** is designed to support a seamless onboarding experience for both developers (**Makers**) and **Managers**, providing tailored automation scripts and comprehensive documentation for the most commonly used tools, services, and configurations.

### Key Features:
- **Cross-Platform Setup**: Guides and automation for both **Ubuntu** and **Windows** environments.
- **Role-Specific Customization**:
  - **Makers**: Developer-centric environments with tools like Docker, JetBrains, .NET SDK, and Visual Studio Code.
  - **Managers**: Productivity-focused setup including Office 365, communication tools (Teams, Slack, Discord), and browsers (Chrome, Firefox).
- **Efficient Onboarding**: Simplify and standardize the onboarding process for new employees and team members.

---

## Setup Guides

### Makers Setup Guides

The guides for **Makers** (developers) focus on creating a robust environment suitable for coding, development, and deployment. These include the installation of various development tools like Docker, VSCode, and terminal customizations.

- [**Ubuntu Developer Setup Guide**](./Developer_Setup_Guide_Ubuntu.md): Instructions and automation for setting up a full .NET and Docker-based development environment on Ubuntu.
- [**Windows Developer Setup Guide**](./Developer_Setup_Guide_Windows.md): Detailed steps for setting up a Windows-based development environment with .NET SDK, Docker, and other development tools.

### Managers Setup Guides

The guides for **Managers** provide a productivity-focused workspace setup, emphasizing communication tools, productivity applications, and easy access to collaboration platforms.

- [**Windows Manager Setup Guide**](./Manager_Setup_Guide_Windows.md): Steps and automation for setting up Office 365, communication tools (Slack, Discord, Teams), and productivity tools.

---

## Automation Scripts

The **automation scripts** provided in this repository enable rapid installation and configuration of all required software for both Makers and Managers. These scripts use **Chocolatey** (on Windows) and **bash** scripts (on Ubuntu) to simplify and automate the environment setup.

### Available Scripts:

- [**Ubuntu Developer Setup Script**](./setup-dev-environment.sh): Automates the installation of Docker, JetBrains Toolbox, VSCode, .NET SDK, and other essential tools.
- [**Windows Developer Setup Script**](./setup-dev-environment.ps1): Installs all necessary development tools using Chocolatey, including Git, Docker Desktop, and JetBrains Toolbox.
- [**Windows Manager Setup Script**](./setup-manager-environment.ps1): Automates the installation of productivity tools, browsers, and communication applications for managers.

---

## Getting Started

To get started, follow the instructions for your role and platform:

### For Makers (Developers):
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/johnkattenhorn/MakersAndManagersToolkit.git
   ```
2. **Navigate to the Appropriate Setup Guide**:
   - For Ubuntu: Follow the [**Developer Setup Guide for Ubuntu**](./Developer_Setup_Guide_Ubuntu.md).
   - For Windows: Follow the [**Developer Setup Guide for Windows**](./Developer_Setup_Guide_Windows.md).

3. **Run the Automation Script**:
   - Ubuntu: Use the `setup-dev-environment.sh` script.
   - Windows: Use the `setup-dev-environment.ps1` script.

### For Managers:
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/johnkattenhorn/MakersAndManagersToolkit.git
   ```
2. **Navigate to the Manager Setup Guide** ([**Manager Setup Guide for Windows**](./Manager_Setup_Guide_Windows.md)).
3. **Run the Automation Script**:
   - Windows: Use the `setup-manager-environment.ps1` script to automate the setup process.

---

## Contribution Guidelines

This toolkit is used internally by **Applicita**, but we believe it could be useful for others as well. Contributions are welcome!

- **Reporting Issues**: If you encounter any issues, please open an issue in the repository.
- **Feature Requests**: If you have ideas for improving the toolkit, we’d love to hear them.
- **Pull Requests**: Contributions in the form of pull requests are always welcome. Please ensure that changes are well-documented and tested.

For detailed contribution guidelines, please see `CONTRIBUTING.md`.

---

## License

This project is licensed under the **MIT License**. See the `LICENSE` file for more details.

---

## Feedback

We hope this toolkit helps streamline onboarding processes for Makers and Managers alike! If you have any feedback, please feel free to reach out or create an issue in the repository.
