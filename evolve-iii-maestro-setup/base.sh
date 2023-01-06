#!/bin/bash

# Update all packages
sudo apt update -y 
sudo apt upgrade -y
sudo apt autoremove -y

# Install core tools

packages=(neovim wget curl htop zsh python3-pip fonts-powerline)

for package in ${packages[@]}; do
    echo "Installing $package"
    sudo apt install -y $package
    if [ ! $? -eq 0 ]; then
        echo "Installing $package failed"
        exit 1
    fi
done

# Add user to group
sudo usermod -a -G tty $USER
sudo usermod -a -G dialout $USER

# Switch shell to zsh 
chsh -s $(which zsh)

# Install powerline
pip3 install powerline-status

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
