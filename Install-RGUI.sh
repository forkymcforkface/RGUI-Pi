#!/bin/bash

clear
echo "installation script!"
echo "For more information, visit: https://github.com/forkymcforkface"
echo "System will reboot itself a few times during install"
echo

# Define flag file
flag_file="$(dirname "$0")/install_step"

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
        sudo echo "$script_dir/Install-CRTRGUI.sh" | sudo tee -a /etc/profile.d/10-rgbpi.sh > /dev/null
        sudo echo -e "[Service]\nExecStart=\n#ExecStart=-/sbin/agetty --autologin root --noclear %I \$TERM\nExecStart=-/sbin/agetty --skip-login --noclear --noissue --login-options \"-f pi\" %I \$TERM" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf > /dev/null
        sudo apt-get update
        sudo echo 1 > "$flag_file"
        sync
        sudo reboot
        ;;
    1) 
        echo "Step 1: Compiling and installing DPIDAC driver..."
        cd "$(dirname "$0")"
        sudo apt-get install -y raspberrypi-kernel-headers
        git clone https://github.com/forkymcforkface/rpi-dpidac
        cd rpi-dpidac
        sudo make
        sudo make install
        sudo echo 2 > "$flag_file"
        sync
        sudo reboot
        ;;
    2)
        echo "Step 2: Installing packages and downloading files..."
        cd "$(dirname "$0")"
        sudo apt-get install -y git build-essential tk-dev libasound2-plugin-equal bluez libncurses5-dev rfkill libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget vim systemtap-sdt-dev libimagequant0 libtiff5-dev libreadline8 librhash0 librole-tiny-perl librsvg2-2 librsvg2-common librtmp-dev librtmp1 librubberband2 libsamplerate0 libsasl2-2 libsasl2-modules-db libsasl2-modules libsasl2-modules libsdl-image1.2-dev libsdl-image1.2 libsdl-mixer1.2 libsdl-ttf2.0-0 libsdl1.2-dev libsdl1.2debian libsdl2-2.0-0 libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-mixer-2.0-0 libsdl2-mixer-dev libsdl2-net-2.0-0 libsdl2-net-dev libsdl2-ttf-2.0-0 libsdl2-ttf-dev dhcpcd5 dkms cabextract exfat-fuse
        git clone https://github.com/forkymcforkface/xone
        
        echo "Compiling and installing Python3.9.2..."
        tar zxf Python-3.9.2.tgz
        cd Python-3.9.2/
        export SETUPTOOLS_USE_DISTUTILS=stdlib
        sudo make altinstall
        cd "$(dirname "$0")"

        echo "Installing SDL1/SDL2..."
        cd SDL
        sudo usermod -a -G video root && sudo usermod -a -G input root
        sudo chmod +x *
        sudo ./retropie_packages.sh sdl1 install
        sudo ./retropie_packages.sh sdl2 install
        cd "$(dirname "$0")"
        sudo echo 3 > "$flag_file"
        sudo systemctl disable NetworkManager-wait-online
        sync
        sudo reboot
        ;;
    3) 
        echo "Step 3: Compiling and installing XONE..."
        cd "$(dirname "$0")"
        cd xone
        sudo chmod +x *
        sudo ./install.sh --release
        cd install
        sudo chmod +x *
        sudo ./firmware_offline.sh --skip-disclaimer
        cd "$(dirname "$0")"
                
        echo "Moving files to correct locations, enabling services, and extracting cores..."
        cd "$(dirname "$0")"/drive
        source_dirs="boot etc media opt root usr"
        for dir in $source_dirs; do
            if [ "$dir" = "boot" ]; then
                sudo cp -rp --no-preserve=ownership "$dir" /
            else
                sudo chmod -R 0777 "$dir"
                sudo cp -rp "$dir" /
            fi
        done

        sudo cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant
        sudo touch /etc/ssh/sshd_config && sudo bash -c 'echo "PermitRootLogin yes" >> /etc/ssh/sshd_config'
        sudo 7z x -aoa /opt/retroarch/cores.7z -o/opt/retroarch
        done
        
        echo "Cleaning up..."
        sudo apt autoremove -y
        sudo systemctl disable NetworkManager apparmor ModemManager rpi-eeprom-update triggerhappy NetworkManager-wait-online
        sudo rm /opt/retroarch/cores.7z
        sudo rm -rf /opt/pigpio
        sudo rm -rf /opt/retropie
        sudo rm -rf /home/pi/CRT-RGUI
        sudo rm -rf /home/pi/RetroPie
        sudo find / -name ".gitkeep" -type f -delete
        sudo echo 4 > "$flag_file"
        sync
        sudo reboot
        ;;
    *)
        echo "Invalid step: $current_step" >&2
        ;;
esac
