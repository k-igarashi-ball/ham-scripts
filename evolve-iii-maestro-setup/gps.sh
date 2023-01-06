#!/bin/bash

# Update packages
sudo apt update -y
sudo apt upgrade -y

#Install GPS 
packages=(python3-gps gpsd-clients gpsd chrony python3-gi-cairo libgps-dev)
for package in ${packages[@]}; do
    echo "Installing $package"
    sudo apt install -y $package
    if [ ! $? -eq 0 ]; then
        echo "Installing $package failed"
        exit 1
    fi
done

chrony_string="refclock SHM 0 offset 0.5 delay 0.2 refid NMEA"
## TODO: Update chrony.conf
#$(sudo echo $chrony_string >> /etc/chrony/chrony.conf)

echo "#################"
echo "Action Required"
echo "#################"
echo "You will need to setup the GPS device in /etc/devices/gpsd"
