#!/bin/bash

# Update packages
sudo apt update -y
sudo apt upgrade -y

#Install Packages
packages=(conky ruby)
for package in ${packages[@]}; do
    echo "Installing $package"
    sudo apt install -y $package
    if [ ! $? -eq 0 ]; then
        echo "Installing $package failed"
        exit 1
    fi
done

mkdir -p $HOME/bin/conky

cd $HOME/bin/conky
wget https://raw.githubusercontent.com/km4ack/pi-scripts/master/conky/get-freq
wget https://raw.githubusercontent.com/km4ack/pi-scripts/master/conky/get-grid
wget https://raw.githubusercontent.com/km4ack/pi-scripts/master/conky/grid

scripts=(get-freq get-grid grid)
for script in ${scripts[@]}; do
    chmod +x $script
done

cd $HOME
cp $HOME/ham-scripts/evolve-iii-maestro-setup/.conkyrc .conkyrc

### TODO: Setup sed for call sign

# Install GPS tools

sudo gem install gpsd_client
sudo gem install maidenhead

## TODO: Add crontab modification for reboot
# @reboot sleep 20 && export DISPLAY=:0 && /usr/bin/conky
