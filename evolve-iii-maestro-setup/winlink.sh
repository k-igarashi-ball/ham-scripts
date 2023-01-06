#!/bin/bash

# Update packages
sudo apt update -y
sudo apt upgrade -y

#Install GPS 
packages=(ax25-tools ax25-apps libasound2-dev cmake libudev-dev yad)
for package in ${packages[@]}; do
    echo "Installing $package"
    sudo apt install -y $package
    if [ ! $? -eq 0 ]; then
        echo "Installing $package failed"
        exit 1
    fi
done

## Install direwolf
cd $HOME
if [ ! -d "$HOME/direwolf" ]
then
	sh -c "$(git clone https://github.com/wb2osz/direwolf.git)"
	cd $HOME/direwolf
else
	cd $HOME/direwolf
	git pull
fi

mkdir build
cd build
cmake ..
make -j 4
sudo make install
make install-conf
<<hold

## Install ax.5
# /etc/ax25/axports
# wl2k ${CALLSIGN} 1200 255 7 Winlink

## Install ARDOP
wget -P $HOME/Downloads https://www.cantab.net/users/john.wiseman/Downloads/Beta/ardopc64
if [ -f "$HOME/Downloads/ardopc64" ]
then 
	chmod +x $HOME/Downloads/ardopc64
	sudo mv $HOME/Downloads/ardopc64 /usr/local/bin/ardopc64
else
    echo "ardopc failed to download - does not exist"
    exit 1;
fi

## Install VARA HF
wget -P $HOME/Downloads https://raw.githubusercontent.com/km4ack/pi-scripts/master/vara-on-debian
if [ -f "$HOME/Downloads/vara-on-debian" ]
then 
	bash $HOME/Downloads/vara-on-debian
	rm $HOME/Downloads/vara-on-debian
	
else
    echo "vara install script failed to download - does not exist"
    exit 1;
fi

## Install PAT

wget -P $HOME/Downloads https://github.com/la5nta/pat/releases/download/v0.13.1/pat_0.13.1_linux_amd64.deb
if [ -f "$HOME/Downloads/pat_0.13.1_linux_amd64.deb" ]
then 
	sudo dpkg -i $HOME/Downloads/pat_0.13.1_linux_amd64.deb
	rm $HOME/Downloads/pat_0.13.1_linux_amd64.deb
	
else
    echo "pat failed to download - does not exist"
    exit 1;
fi

## Install PAT Menu
cd $HOME
if [ ! -d "$HOME/patmenu2" ]
then
	sh -c "$(git clone https://github.com/km4ack/patmenu2.git)"
	cd $HOME/patmenu2
	git checkout x86-dev
else
	cd $HOME/patmenu2
	git checkout x86-dev
	git pull
fi

hold
