#!/bin/bash

clear
echo "OS4 installation script!"
echo "For more information, visit: https://github.com/forkymcforkface"
echo "System will reboot itself a few times during install"
echo

# Define flag file
flag_file="$(dirname "$0")/os4_install_step"

# Check current step from the flag file
current_step=0
if [ -f "$flag_file" ]; then
    current_step=$(cat "$flag_file")
fi

# Execute different steps based on the current step
case $current_step in
    0)
        echo "Step 0: Adding configuration and updating system..."
        sudo echo "kernel=kernel8.img" | sudo tee -a /boot/firmware/config.txt > /dev/null
        sudo echo "dtoverlay=vc4-kms-dpi-custom" | sudo tee -a /boot/firmware/config.txt > /dev/null
        script_dir="$(dirname "$(realpath "$0")")"
        sudo echo "$script_dir/Install-OS4.sh" | sudo tee -a /etc/profile.d/10-rgbpi.sh > /dev/null
        sudo echo -e "[Service]\nExecStart=\n#ExecStart=-/sbin/agetty --autologin root --noclear %I \$TERM\nExecStart=-/sbin/agetty --skip-login --noclear --noissue --login-options \"-f pi\" %I \$TERM" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf > /dev/null
        sudo apt-get update && sudo apt-get upgrade -y
        sudo echo 1 > "$flag_file"
        sync
        echo "Rebooting..."
        sudo reboot
        ;;
    1) 
        echo "Step 1: Compiling and installing DPIDAC driver..."
        cd "$(dirname "$0")"
        sudo apt-get install -y raspberrypi-kernel-headers
        git clone https://github.com/forkymcforkface/rpi-dpidac
        cd rpi-dpidac || { echo "Error: Unable to change directory to rpi-dpidac"; exit 1; }
        sudo make || { echo "Error: Compilation failed for DPIDAC driver"; exit 1; }
        sudo make install || { echo "Error: Installation failed for DPIDAC driver"; exit 1; }
        sudo echo 2 > "$flag_file"
        sync
        echo "Rebooting..."
        sudo reboot
        ;;
    2)
        echo "Step 2: Installing packages and downloading files..."
        cd "$(dirname "$0")"
        sudo apt-get install -y git build-essential tk-dev libasound2-plugin-equal libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget vim systemtap-sdt-dev libsdl1.2-dev libimagequant0 libtiff5-dev libreadline8 librhash0 librole-tiny-perl librsvg2-2 librsvg2-common librtmp-dev librtmp1 librubberband2 libsamplerate0 libsasl2-2 libsasl2-modules-db libsasl2-modules libsasl2-modules libsdl-image1.2-dev libsdl-image1.2 libsdl-mixer1.2 libsdl-ttf2.0-0 libsdl1.2-dev libsdl1.2debian libsdl2-2.0-0 libsdl2-dev libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-mixer-2.0-0 libsdl2-mixer-dev libsdl2-net-2.0-0 libsdl2-net-dev libsdl2-ttf-2.0-0 libsdl2-ttf-dev dhcpcd5 dkms cabextract exfat-fuse || { echo "Error: Package installation failed"; exit 1; }
        git clone https://github.com/medusalix/xone || { echo "Error: Unable to clone xone repository"; exit 1; }

        echo "Compiling and installing Python3.9.2..."
        tar zxf Python-3.9.2.tgz
        cd Python-3.9.2/ || { echo "Error: Unable to change directory to Python-3.9.2"; exit 1; }
        sudo export SETUPTOOLS_USE_DISTUTILS=stdlib
        sudo make altinstall || { echo "Error: Compilation failed for Python3.9.2"; exit 1; }
        cd "$(dirname "$0")"

        echo "Installing SDL1/SDL2..."
        cd SDL || { echo "Error: Unable to change directory to SDL"; exit 1; }
        sudo usermod -a -G video root && sudo usermod -a -G input root
        chmod +x *
        sudo ./retropie_packages.sh sdl1 install || { echo "Error: SDL1 installation failed"; exit 1; }
        sudo ./retropie_packages.sh sdl2 install || { echo "Error: SDL2 installation failed"; exit 1; }
        cd "$(dirname "$0")"
        sudo echo 3 > "$flag_file"
        sync
        echo "Rebooting..."
        sudo reboot
        ;;
    3) 
        echo "Step 3: Reinstalling DAC driver..."
        cd "$(dirname "$0")"
        cd rpi-dpidac || { echo "Error: Unable to change directory to rpi-dpidac"; exit 1; }
        sudo make clean || { echo "Error: Clean failed for DAC driver"; exit 1; }
        sudo make || { echo "Error: Compilation failed for DAC driver"; exit 1; }
        sudo make install || { echo "Error: Installation failed for DAC driver"; exit 1; }
        sudo echo 4 > "$flag_file"
        sync
        echo "Rebooting..."
        sudo reboot
        ;;
    4) 
        echo "Step 4: Compiling and installing XONE..."
        cd "$(dirname "$0")"
        cd xone || { echo "Error: Unable to change directory to xone"; exit 1; }
        chmod +x *
        sudo ./install.sh || { echo "Error: Installation failed for XONE"; exit 1; }
        sudo xone-get-firmware.sh --skip-disclaimer || { echo "Error: Unable to get firmware for XONE"; exit 1; }
        cd "$(dirname "$0")"
                
        echo "Moving OS4 files to correct locations, enabling services, and extracting cores..."
        cd "$(dirname "$0")"/drive || { echo "Error: Unable to change directory to drive"; exit 1; }
        source_dirs="boot etc media opt root usr"
        for dir in $source_dirs; do
            echo "Copying $dir contents to /"
            if [ "$dir" = "boot" ]; then
                sudo cp -rp --no-preserve=ownership "$dir" / /  || { echo "Error: Unable to move $dir"; exit 1; }
            else
                sudo chmod -R 0777 "$dir"  || { echo "Error: Unable to change permissions for $dir"; exit 1; }
                sudo cp -rp "$dir" /  || { echo "Error: Unable to move $dir"; exit 1; }
            fi
        done

        sudo systemctl enable unplug-image.service boot-image.service dhcpcd || { echo "Error: Failed to enable services"; exit 1; }
        sudo cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant || { echo "Error: Failed to copy 10-wpa_supplicant"; exit 1; }
        sudo touch /etc/ssh/sshd_config && sudo bash -c 'echo "PermitRootLogin yes" >> /etc/ssh/sshd_config' || { echo "Error: Failed to modify sshd_config"; exit 1; }
        sudo 7z x -aoa /opt/retroarch/cores.7z -o/opt/retroarch || { echo "Error: Failed to extract cores"; exit 1; }
        sudo 7z x -aoa /opt/rgbpi/ui/themes/*.7z -o/opt/rgbpi/ui/themes || { echo "Error: Failed to extract themes"; exit 1; }
        
        echo "Cleaning up..."
        sudo apt autoremove -y
        sudo systemctl disable NetworkManager apparmor ModemManager rpi-eeprom-update triggerhappy NetworkManager-wait-online || { echo "Error: Failed to disable services"; exit 1; }
        sudo rm /opt/retroarch/cores.7z
        sudo rm -rf /opt/pigpio
        sudo rm -rf /opt/retropie
        cd ..
        sudo rm -rf RGBPi-Bookworm
        sudo rm -rf RetroPie
        sudo echo 5 > "$flag_file"
        sync
        echo "Rebooting..."
        sudo reboot
        ;;
    *)
        echo "Invalid step: $current_step"
        ;;
esac
