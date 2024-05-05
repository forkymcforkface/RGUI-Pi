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
        # Kernel8 is required for N64 and Dreamcast cores
        echo "kernel=kernel8.img" | sudo tee -a /boot/firmware/config.txt > /dev/null
		echo "dtoverlay=vc4-kms-dpi-custom" | sudo tee -a /boot/firmware/config.txt > /dev/null
        script_dir="$(dirname "$(realpath "$0")")"
        echo "$script_dir/Install-OS4.sh" | sudo tee -a /etc/profile.d/10-rgbpi.sh > /dev/null
        echo -e "[Service]\nExecStart=\n#ExecStart=-/sbin/agetty --autologin root --noclear %I \$TERM\nExecStart=-/sbin/agetty --skip-login --noclear --noissue --login-options \"-f pi\" %I \$TERM" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/autologin.conf > /dev/null
        sudo apt-get update && sudo apt-get upgrade -y
        sudo echo 1 > "$flag_file"
        sync
        sleep 3
        sudo reboot
        ;;

    1) 
        # Compile and Install DPIDAC for SCART cable driver
		cd "$(dirname "$0")"
		sudo apt-get install -y raspberrypi-kernel-headers
		git clone https://github.com/forkymcforkface/rpi-dpidac
        cd rpi-dpidac || exit
        sudo make
        sudo make install
		sudo echo 2 > "$flag_file"
		sync
		sleep 3
        sudo reboot
		;;
		
    2)
		# Install packages and download files
		cd "$(dirname "$0")"
        sudo apt-get install -y git build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget vim systemtap-sdt-dev libsdl1.2-dev libimagequant0 libtiff5-dev libreadline8 librhash0 librole-tiny-perl librsvg2-2 librsvg2-common librtmp-dev librtmp1 librubberband2 libsamplerate0 libsasl2-2 libsasl2-modules-db libsasl2-modules libsdl-image1.2-dev libsdl-image1.2 libsdl-mixer1.2 libsdl-ttf2.0-0 libsdl1.2-dev libsdl1.2debian libsdl2-2.0-0 libsdl2-dev libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-mixer-2.0-0 libsdl2-mixer-dev libsdl2-net-2.0-0 libsdl2-net-dev libsdl2-ttf-2.0-0 libsdl2-ttf-dev dhcpcd5 dkms cabextract exfat-fuse
		git clone https://github.com/medusalix/xone
        wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz

		#Compile and Install XONE 
		cd xone
		chmod +x *
		sudo ./install.sh
		sudo xone-get-firmware.sh --skip-disclaimer
		cd "$(dirname "$0")"

        # Compile and Install Python3.9.2
		tar zxf Python-3.9.2.tgz
        cd Python-3.9.2/ || exit
        ./configure --enable-shared --prefix=/usr --with-ensurepip
        sudo make -j5
        sudo make altinstall
        cd "$(dirname "$0")"

        # Install SDL1/SDL2
        cd SDL || exit
		sudo usermod -a -G video root && sudo usermod -a -G input root
		chmod +x *
        sudo ./retropie_packages.sh sdl1 install
        sudo ./retropie_packages.sh sdl2 install
        cd "$(dirname "$0")"
		sudo echo 3 > "$flag_file"
		sync
		sleep 3
        sudo reboot
        ;;

    3) 
        # Something breaks the DAC Driver and it needs to be installed again
		
				# Copy OS4 files to correct locations, enable services extract cores
		cd "$(dirname "$0")"/drive
		source_dirs="boot etc media opt root usr"
		for dir in $source_dirs; do
			echo "Copying $dir contents to /"
			if [ "$dir" = "boot" ]; then
				sudo cp -rp --no-preserve=ownership "$dir" /  # Copy boot directory without preserving ownership
			else
				sudo chmod -R 0777 "$dir"  # chmod other directories
				sudo cp -rp "$dir" /  # Copy other directories with ownership preservation
			fi
		done

        sudo systemctl enable unplug-image.service boot-image.service argon-pwr-off.service argon-btn-fan.service dhcpcd
        sudo cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant
		sudo touch /etc/ssh/sshd_config && sudo bash -c 'echo "PermitRootLogin yes" >> /etc/ssh/sshd_config'
        sudo 7z x -aoa /opt/retroarch/cores.7z -o/opt/retroarch
        cd "$(dirname "$0")"
        cd rpi-dpidac || exit
		sudo make clean
		sudo make
        sudo make install
        cd ..

        # Cleanup
		sudo apt autoremove -y
		sudo systemctl disable NetworkManager apparmor ModemManager rpi-eeprom-update triggerhappy NetworkManager-wait-online
		echo '# launch our autostart apps (if we are on the correct tty and not in X)
if [ "`tty`" = "/dev/tty1" ] && [ -z "$DISPLAY" ] && [ "$USER" = "root" ]; then
    bash "/opt/rgbpi/autostart.sh"
fi' | sudo tee /etc/profile.d/10-rgbpi.sh > /dev/null
        sudo rm /opt/retroarch/cores.7z
        sudo rm -rf /opt/pigpio
        sudo rm -rf /opt/retropie
		cd ..
		sudo rm -rf RGBPi-Bookworm
		sudo rm -rf RetroPie
		sleep 5
        sudo reboot
        ;;

    *)
        echo "Invalid step: $current_step"
        ;;
esac