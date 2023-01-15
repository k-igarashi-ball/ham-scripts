#!/bin/bash

# Update packages
sudo apt update -y
sudo apt upgrade -y

packages=(libjack-jackd2-dev portaudio19-dev)
for package in ${packages[@]}; do
    echo "Installing $package"
    sudo apt install -y $package
    if [ ! $? -eq 0 ]; then
        echo "Installing $package failed"
        exit 1
    fi
done

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

# Download fldigi
#
fldigi_version=4.1.23
wget -P $HOME/Downloads "http://www.w1hkj.com/files/fldigi/fldigi-${fldigi_version}.tar.gz"
if [ -f "$HOME/Downloads/fldigi-${fldigi_version}.tar.gz" ]
then 
    cd $HOME/Downloads
    tar -xzvf fldigi-${fldigi_version}.tar.gz
    cd fldigi-${fldigi_version}

    ./configure --prefix=/usr/local --enable-static
    make
    sudo make install
    sudo ldconfig

    # Clean up flxml files
    rm -rf $HOME/Downloads/fldigi-${fldigi_version}.tar.gz $HOME/Downloads/fldigi-${fldigi_version}
else
    echo "FLDIGI archive failed to download - does not exist"
    exit 1;
fi 

# Download flmsg
#
flmsg_version=4.0.20
wget -P $HOME/Downloads "http://www.w1hkj.com/files/flmsg/flmsg-${flmsg_version}.tar.gz"
if [ -f "$HOME/Downloads/flmsg-${flmsg_version}.tar.gz" ]
then 
    cd $HOME/Downloads
    tar -xzvf flmsg-${flmsg_version}.tar.gz
    cd flmsg-${flmsg_version}

    ./configure --prefix=/usr/local --enable-static
    make
    sudo make install
    sudo ldconfig

    # Clean up flmsg files
    rm -rf $HOME/Downloads/flmsg-${flmsg_version}.tar.gz $HOME/Downloads/flmsg-${flmsg_version}
else
    echo "FLMSG archive failed to download - does not exist"
    exit 1;
fi 
