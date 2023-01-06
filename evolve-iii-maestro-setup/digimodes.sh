#!/bin/bash

# Update packages
sudo apt update -y
sudo apt upgrade -y

# Download WSJTX
wget -P $HOME/Downloads "https://downloads.sourceforge.net/project/wsjt/wsjtx-2.5.4/wsjtx_2.5.4_amd64.deb"

# Check to make sure it downloaded
if [ -f "$HOME/Downloads/wsjtx_2.5.4_amd64.deb" ]
then 
    sudo dpkg -i $HOME/Downloads/wsjtx_2.5.4_amd64.deb
    sudo apt --fix-broken -y install
    # Clean up WSJTX files
    rm -rf $HOME/Downloads/wsjtx_2.5.4_amd64.deb
else
    echo "WSJTX failed to download - does not exist"
    exit 1;
fi

# Download JS8Call
wget -P $HOME/Downloads "http://files.js8call.com/2.2.0/js8call_2.2.0_20.04_amd64.deb"

# Check to make sure it downloaded
if [ -f "$HOME/Downloads/js8call_2.2.0_20.04_amd64.deb" ]
then 
    sudo dpkg -i $HOME/Downloads/js8call_2.2.0_20.04_amd64.deb
    sudo apt --fix-broken -y install
    # Clean up JS8Call files
    rm -rf $HOME/Downloads/js8call_2.2.0_20.04_amd64.deb
else
    echo "JS8Call failed to download - does not exist"
    exit 1;
fi

