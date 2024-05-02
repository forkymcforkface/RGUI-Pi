#!/bin/bash

source_dirs="boot etc media opt root usr"
script_dir=$(dirname "$(realpath "$0")")

for dir in $source_dirs; do
    echo "Copying $dir to /"
    if [ "$dir" != "boot" ]; then
        sudo chmod -R 0777 "$script_dir/$dir"
    fi
    sudo cp -rp "$script_dir/$dir" /
done

sudo systemctl enable unplug-image.service boot-image.service argon-pwr-off.service argon-btn-fan.service

7z x -aoa /opt/retroarch/cores.7z -o/opt/retroarch
rm /opt/retroarch/cores.7z
rm -rf /root/RetroPie-Setup
rm -rf /root/RGBPi-Bookworm
rm -rf /root/RetroPie
rm -rf /root/cores
rm -rf /root/rpi-dpidac
rm -rf /root/Python-3.9.2
rm /root/Python-3.9.2.tgz
sudo reboot