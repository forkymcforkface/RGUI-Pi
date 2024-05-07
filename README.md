**I have created two different installers, one is an automated install and the other is for anyone that wants to go through the steps themselves.**
--------------------------------------------------------------
- **Option #1 Automated install (there are a few reboots, fully automated and takes about 10mins to complete install)
- **Does not include scraper images (900Mb) this is to keep down size and increase install speed.
- **Dreamcast will not work correctly without the pi5 branch of RGBPi-Extra. Naomi games do not currently work. https://github.com/forkymcforkface/RGBPi-Extra/tree/Pi5
- read known problems at the very bottom.

**Install 64bit bookworm lite onto SD card** https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit
   - Plug into Pi5
   - Get IP address
   - SSH Login as Pi user
   - Run the below command and sit back until the OS4 UI appears
   ```markdown
   sudo apt install git -y && git clone --depth=1 --branch=dev https://github.com/forkymcforkface/RGBPi-Bookworm.git && cd RGBPi-Bookworm && chmod +x Install-OS4.sh && ./Install-OS4.sh
   ```
--------------------------------------------------------------
**Option #2 Manual install**
   1. **Install 64bit bookworm lite onto SD card** you must reboot after step 1
      - On your computer open /boot/firmware/config.txt and add the below on the last line.
      ```markdown
      kernel=kernel8.img
      ```
      - Plug into Pi5
      - Get IP address
      - SSH Login as Pi user
        
      ```markdown
      sudo apt-get update && apt-get upgrade
      sudo passwd root
      sudo touch /etc/ssh/sshd_config && sudo bash -c 'echo "PermitRootLogin yes" >> /etc/ssh/sshd_config'
      sudo reboot
      ```
      - Login as root    

   
   2. **Install DPIDAC for SCART cable driver**
      ```markdown
      apt install git -y
      apt install raspberrypi-kernel-headers -y
      git clone https://github.com/forkymcforkface/rpi-dpidac
      cd rpi-dpidac
      make
      make install
   
   3. **Compile RetroArch** (skip this step to use precompiled one step 7)
      - [GitHub Repository: forkymcforkface/RetroArch](https://github.com/forkymcforkface/RetroArch)
      - Go to the bottom and modify 64bit compile without FFMPEG.
   
   4. **Install SDL1 and SDL2 packages**
       ```markdown 
      sudo usermod -a -G video root && sudo usermod -a -G input root
      sudo ./SDL/retropie_packages.sh sdl1 install
      sudo ./SDL/retropie_packages.sh sdl2 install
      ```
   
   5. **Compile and altinstall Python 3.9.2**
      ```markdown
      sudo apt-get install -y libasound2-plugin-equal bluez build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget vim systemtap-sdt-dev libsdl1.2-dev libimagequant0 libtiff5-dev libreadline8 librhash0 librole-tiny-perl librsvg2-2 librsvg2-common librtmp-dev librtmp1 librubberband2 libsamplerate0 libsasl2-2 libsasl2-modules-db libsasl2-modules libsdl-image1.2-dev libsdl-image1.2 libsdl-mixer1.2 libsdl-ttf2.0-0 libsdl1.2debian libsdl2-2.0-0 libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-mixer-2.0-0 libsdl2-mixer-dev libsdl2-net-2.0-0 libsdl2-net-dev libsdl2-ttf-2.0-0 libsdl2-ttf-dev --allow-change-held-packages
   
      
      wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
      tar zxf Python-3.9.2.tgz && cd Python-3.9.2/
      ./configure --enable-shared --prefix=/usr --with-ensurepip
      make -j5 && make altinstall
   6. **Do some service cleanup and Install DHCPCD so that OS4 can connect to WiFi**
       ```markdown
       
      sudo systemctl disable NetworkManager apparmor glamor-test ModemManager rpi-eeprom-update rp1-test triggerhappy NetworkManager-wait-online
      
      sudo apt-get update
      sudo apt-get install -y dhcpcd5
      sudo cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant
   
   7. **Copy OS4 Files to bookworm** (To keep size down this does not include scaper images, and only the default megatech theme.)
      
      ```markdown
      git clone --depth 1 https://github.com/forkymcforkface/RGBPi-Bookworm
      cd RGBPi-Bookworm
      cd drive
      chmod +x OS4-sysinstall.sh
      ./OS4-sysinstall.sh
      ```
   
   **Optional**
   -  Install XONE for Xbox controller support
    
         ```
         sudo apt-get install -y dkms cabextract
         git clone https://github.com/medusalix/xone
         cd xone
         sudo ./install.sh
         sudo xone-get-firmware.sh
         ```
   **Known problems**
   - USB Audio dac required
   - wifi may not connect right away, may take a reboot after typing password in
   - Pi5 does not support interlacing
   - Kodi is not installed since interlacing isnt supported

