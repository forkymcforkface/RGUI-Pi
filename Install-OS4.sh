#!/bin/bash

# Kernel8.img is required for Dreamcast and N64 to run
if ! grep -q '^kernel=kernel8.img' /boot/firmware/config.txt; then
    echo "Adding kernel=kernel8.img to /boot/firmware/config.txt..."
    echo "kernel=kernel8.img" | sudo tee -a /boot/firmware/config.txt > /dev/null
    read -n 1 -s -r -p "Press any key to reboot, re-run this script after reboot to continue the installation. Reboot 1 of 2"
    fi
    echo "re-run Install-OS4.sh after reboot to continue the installation."
    sudo reboot
else
    echo "kernel=kernel8.img is already present in /boot/firmware/config.txt. Continuing installation..."
fi

if [ -f "/root/.upgraderun" ]; then
    echo "apt-get upgrade has already been performed. Continuing installation..."
else
    echo "Performing system upgrade..."
    apt-get update && apt-get -y upgrade
    touch /root/.upgraderun
    read -n 1 -s -r -p "Press any key to reboot. re-run this script after reboot to continue the installation. This is the last reboot"
    echo "re-run Install-OS4.sh after reboot to continue the installation."
    reboot
fi

# Install DPIDAC for SCART cable driver
apt-get update 
apt-upgrade
apt install git -y
apt install raspberrypi-kernel-headers -y
git clone https://github.com/forkymcforkface/rpi-dpidac
cd rpi-dpidac
make
make install
cd /root/RGBPi-Bookworm # I know there is a better way to do this. Lazy

# Compile and altinstall Python 3.9.2
sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget vim systemtap-sdt-dev libsdl1.2-dev libimagequant0 libtiff5-dev libreadline8 librhash0 librole-tiny-perl librsvg2-2 librsvg2-common librtmp-dev librtmp1 librubberband2 libsamplerate0 libsasl2-2 libsasl2-modules-db libsasl2-modules libsdl-image1.2-dev libsdl-image1.2 libsdl-mixer1.2 libsdl-ttf2.0-0 libsdl1.2-dev libsdl1.2debian libsdl2-2.0-0 libsdl2-dev libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-mixer-2.0-0 libsdl2-mixer-dev libsdl2-net-2.0-0 libsdl2-net-dev libsdl2-ttf-2.0-0 libsdl2-ttf-dev --allow-change-held-packages
wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
tar zxf Python-3.9.2.tgz
cd Python-3.9.2/
./configure --enable-shared --prefix=/usr --with-ensurepip
sudo make -j5
sudo make altinstall
cd /root/RGBPi-Bookworm

# Service cleanup and Install DHCPCD since OS4 does not work with NetworkManager
sudo apt-get update
sudo apt-get install -y dhcpcd5
sudo cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant
sudo systemctl enable dhcpcd
sudo systemctl disable NetworkManager apparmor ModemManager rpi-eeprom-update triggerhappy NetworkManager-wait-online

# Run RetroPie installer and install SDL1 and SDL2 package
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
cd RetroPie-Setup
sudo ./retropie_packages.sh sdl1
sudo ./retropie_packages.sh sdl2
cd /root/RGBPi-Bookworm

# Copy OS4 files to correct directories
source_dirs="drive/boot drive/etc drive/media drive/opt drive/root drive/usr"
script_dir=$(dirname "$(realpath "$0")")

for dir in $source_dirs; do
    echo "Copying $dir contents to /"
    if [ "$dir" != "drive/boot" ]; then
        sudo chmod -R 0777 "$script_dir/$dir"
    fi
    sudo cp -rp "$script_dir/$dir" /
done

#just in case they somehow came back on :)
sudo systemctl disable NetworkManager apparmor glamor-test ModemManager rpi-eeprom-update rp1-test triggerhappy NetworkManager-wait-online
#enable rgbpi os boot and shutdown images
sudo systemctl enable unplug-image.service boot-image.service argon-pwr-off.service argon-btn-fan.service
#extract cores
7z x -aoa /opt/retroarch/cores.7z -o/opt/retroarch

#cleanup
rm /opt/retroarch/cores.7z
rm -rf /opt/pigpio
rm -rf /opt/retropie
rm -rf /root/RGBPi-Bookworm
rm -rf /root/RetroPie
sudo reboot
