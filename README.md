# Ubuntu Developer Setup Guide

This repository contains a guide and an automation script for setting up my developer environment on **Ubuntu 24.04 LTS**. The setup includes Docker, JetBrains Toolbox, Visual Studio Code, OneDrive sync, .NET SDK, and Zsh customisation.

## Table of Contents
- [Documentation](#documentation)
- [Automation Script](#automation-script)
- [How to Use the Script](#how-to-use-the-script)

## Documentation

The full developer setup guide is available in the **Markdown file**. This guide provides detailed steps to manually set up the development environment on a fresh Ubuntu installation.

You can view the documentation [here](./Developer_Setup_Guide.md).

## Automation Script

To speed up the setup process, an **automation script** is also provided. This script automates the installation of Docker, Portainer, Visual Studio Code, JetBrains Toolbox, .NET SDK, and more.

You can find the script [here](./setup-dev-environment.sh).

## How to Use the Script

To run the automation script, follow these steps:

1. Clone the repository:
    ```bash
    git clone https://github.com/johnkattenhorn/linux-developer-environment.git
    cd linux-developer-environment
    ```

2. Make the script executable:
    ```bash
    chmod +x setup-dev-environment.sh
    ```

3. Run the script:
    ```bash
    ./setup-dev-environment.sh
    ```

The script will handle the installation of all necessary components for your developer environment. Note - its completely un-tested as I ran the steps one by one manually, but I'll test it the next time!

## Known Issues

Refer to the "Known Issues" section in the [Documentation](./Developer_Setup_Guide.md#known-issues) for potential workarounds related to Docker Desktop UI issues and Intel AX210 Wireless Adapter performance problems.
