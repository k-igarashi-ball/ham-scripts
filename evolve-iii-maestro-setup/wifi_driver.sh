#!/bin/bash

# Unload module
sudo modprobe -rv 8723du

# Update and install dependencies 
sudo apt update -y

packages=(make gcc linux-headers-$(uname -r) build-essential git)
for package in ${packages[@]}; do
    echo "Installing $package"
    sudo apt install -y $package
    if [ ! $? -eq 0 ]; then
        echo "Installing $package failed"
        exit 1
    fi
done

cd $HOME

if [ ! -d "$HOME/rtl8723du" ]
then
    sh -c "$(git clone https://github.com/lwfinger/rtl8723du.git)"
    cd rtl8723du
else
    cd rtl8723du
    git pull
fi

make clean
make
sudo make install

# Load module
sudo modprobe -v 8723du
