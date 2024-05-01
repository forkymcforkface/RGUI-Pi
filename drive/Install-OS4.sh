#!/bin/bash

source_dirs="boot etc media opt root usr"
script_dir=$(dirname "$(realpath "$0")")
for dir in $source_dirs; do
    echo "Copying $dir to /"
    sudo cp -r "$script_dir/$dir" /
    # Set execute permissions for binaries and .sh files
    sudo find "/$dir" -type f \( -executable -o -name "*.sh" \) -exec chmod +x {} +
done

sudo systemctl enable unplug-image.service boot-image.service argon-pwr-off.service argon-btn-fan.service
7z x /opt/retroarch/cores.7z
