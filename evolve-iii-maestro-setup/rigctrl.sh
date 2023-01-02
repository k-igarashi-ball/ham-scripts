#!/bin/bash

# Update packages
sudo apt update -y
sudo apt upgrade -y

# Set versions
hamlib_version="4.5.3"
flxml_version="0.1.4"
flrig_version="1.4.7"

# Install hamlib dependencies 
packages=(libusb-1.0-0 libusb-1.0-0-dev)
for package in ${packages[@]}; do
    echo "Installing $package"
    sudo apt install -y $package
    if [ ! $? -eq 0 ]; then
        echo "Installing $package failed"
        exit 1
    fi
done

# Download Hamlib
wget -P $HOME/Downloads "https://github.com/Hamlib/Hamlib/releases/download/${hamlib_version}/hamlib-${hamlib_version}.tar.gz"

# Check to make sure it downloaded
if [ -f "$HOME/Downloads/hamlib-${hamlib_version}.tar.gz" ]
then 
    cd $HOME/Downloads
    tar -xzvf hamlib-${hamlib_version}.tar.gz
    cd  hamlib-${hamlib_version}

    #Make and Install
    ./configure
    make 
    sudo make install
    sudo ldconfig

    echo $(rigctl --version)

    # Clean up Hamlib files
    rm -rf $HOME/Downloads/hamlib-${hamlib_version} $HOME/Downloads/hamlib-${hamlib_version}.tar.gz
else
    echo "Hamlib archive failed to download - does not exist"
    exit 1;
fi

# Install flrig dependencies 
packages=(libfltk1.3-dev libjpeg9-dev libxft-dev libxinerama-dev libxcursor-dev libsndfile1-dev libsamplerate0-dev portaudio19-dev libpulse-dev libusb-1.0-0-dev texinfo libudev-dev build-essential)
for package in ${packages[@]}; do
    echo "Installing $package"
    sudo apt install -y $package
    if [ ! $? -eq 0 ]; then
        echo "Installing $package failed"
        exit 1
    fi
done

#Get and install flxml
wget -P $HOME/Downloads  "http://www.w1hkj.com/files/flxmlrpc/flxmlrpc-${flxml_version)}.tar.gz"

# Check that it downloaded 
if [ -f "$HOME/Downloads/flxmlrpc-${flxml_version)}.tar.gz" ]
then 
    cd $HOME/Downloads
    tar -xzvf flxmlrpc-${flxml_version)}.tar.gz
    cd flxmlrpc-${flxml_version)}

    ./configure --prefix=/usr/local --enable-static
    make
    sudo make install
    sudo ldconfig

    # Clean up flxml files
    rm -rf $HOME/Downloads/flxmlrpc-${flxml_version)}.tar.gz $HOME/Downloads/flxmlrpc-${flxml_version)}
else
    echo "FLXML archive failed to download - does not exist"
    exit 1;
fi 

#Get and install flrig
wget -P $HOME/Downloads "http://www.w1hkj.com/files/flrig/flrig-${flrig_version}.tar.gz"
if [ -f "$HOME/Downloads/flrig-${flrig_version}.tar.gz" ]
then 
    cd $HOME/Downloads
    tar -xzvf flrig-${flrig_version)}.tar.gz
    cd flrig-${flrig_version)}

    ./configure --prefix=/usr/local --enable-static
    make
    sudo make install
    sudo ldconfig

    # Clean up flxml files
    rm -rf $HOME/Downloads/flrig-${flrig_version)}.tar.gz $HOME/Downloads/flrig-${flrig_version)}
else
    echo "FLRIG archive failed to download - does not exist"
    exit 1;
fi 

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
sudo echo $chrony_string >> /etc/chrony/chrony.conf