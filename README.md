1. **Install 64bit bookworm lite onto SD card**
   - Enable SSH.
   - Modify root pw if you would like with sudo passwd root
   - sudo touch /etc/ssh/sshd_config && sudo bash -c 'echo "PermitRootLogin yes" >> /etc/ssh/sshd_config'
   - reboot

2. **Install DPIDAC for SCART cable driver**
   ```markdown
   apt install git -y
   apt install raspberrypi-kernel-headers -y
   git clone https://github.com/forkymcforkface/rpi-dpidac
   cd rpi-dpidac
   make
   make install

4. **Compile RetroArch** (or use precompiled one that will be applied in step 8)
   - [GitHub Repository: forkymcforkface/RetroArch](https://github.com/forkymcforkface/RetroArch)
   - Go to the bottom and modify 64bit compile without FFMPEG.

5. **Run RetroPie installer and install SDL1 and SDL2 package**
    ```markdown 
    git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
    cd RetroPie-Setup
    sudo ./retropie_setup.sh

6. **Compile and altinstall Python 3.9.2**
   ```markdown
   sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget   vim systemtap-sdt-dev libsdl1.2-dev libimagequant0 libtiff5-dev libreadline8 librhash0 librole-tiny-perl librsvg2-2 librsvg2-common librtmp-dev librtmp1 librubberband2 libsamplerate0 libsasl2-2 libsasl2-modules-db libsasl2-modules libsdl-image1.2-dev libsdl-image1.2 libsdl-mixer1.2 libsdl-ttf2.0-0 libsdl1.2-dev libsdl1.2debian libsdl2-2.0-0 libsdl2-dev libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-mixer-2.0-0 libsdl2-mixer-dev libsdl2-net-2.0-0 libsdl2-net-dev libsdl2-ttf-2.0-0 libsdl2-ttf-dev

   
   wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
   tar zxf Python-3.9.2.tgz
   cd Python-3.9.2/
   ./configure --enable-shared --prefix=/usr --enable-loadable-sqlite-extensions --with-dbmliborder=bdb:gdbm --with-computed-gotos --with-ensurepip --with-system-expat --with-dtrace --with-system-libmpdec --with-system-ffi
   make -j5
   make altinstall
   pip3.9 install --upgrade setuptools
   python3.9 -m pip install paramiko==2.11.0
   python3.9 -m pip install Pillow==9.1.1
   python3.9 -m pip install smbus==1.1.post2
   python3.9 -m pip install psutil==5.9.1
   python3.9 -m pip install evdev==1.5.0
   python3.9 -m pip install pyalsaaudio==0.9.2
   python3.9 -m pip install FBpyGIF==1.0.5
   python3.9 -m pip install setproctitle==1.2.3

7. **Do some service cleanup and Install DHCPCD so that OS4 can connect to WiFi**
    ```markdown
    
   sudo systemctl disable apparmor.service glamor-test.service ModemManager.service rpi-eeprom-update.service rp1-test.service triggerhappy.service
   
   sudo apt-get update
   sudo apt-get install -y dhcpcd5
   sudo cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant

8. **Copy OS4 Files to bookworm**
   
   ```markdown
   git clone https://github.com/forkymcforkface/RGBPi-Bookworm
   cd drive
   chmod +x Install-OS4.sh
   ./Install-OS4.sh

Known problems
- wifi may not connect right away, may take a reboot after typing password in
- ui is not 100% smooth, this does not affect retroarch
- interlaced games do not work, Kernel needs to be patched
- Kodi is not installed just yet
- not all cores are optimized for pi5. N64, Dreamcast, Naomi dont work right now. Need to do more research/compile new cores.
