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
7z x /opt/retroarch/cores.7z

reboot