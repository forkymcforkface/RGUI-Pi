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

4. **Compile RetroArch** (or download precompiled one here)
   - [GitHub Repository: forkymcforkface/RetroArch](https://github.com/forkymcforkface/RetroArch)
   - Go to the bottom and modify 64bit compile without FFMPEG.

5. **Compile and altinstall Python 3.9.2**
   ```markdown
   sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget vim systemtap-sdt-dev
   wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
   tar zxf Python-3.9.2.tgz
   cd Python-3.9.2/
   ./configure --enable-shared --prefix=/usr --enable-ipv6 --enable-loadable-sqlite-extensions --with-dbmliborder=bdb:gdbm --with-computed-gotos --with-ensurepip --with-system-expat --with-dtrace --with-system-libmpdec --with-system-ffi
   make -j5
   make altinstall
   python3.9 -m pip install Pillow==9.1.1
   python3.9 -m pip install smbus==1.1.post2
   python3.9 -m pip install psutil==5.9.1
   python3.9 -m pip install evdev==1.5.0
   python3.9 -m pip install pyalsaaudio==0.9.2

*   **Run RetroPie installer and install SDL2 package**
    ```markdown 
    git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
    cd RetroPie-Setup
    sudo ./retropie_setup.sh
    
*   **Install DHCPCD so that OS4 can connect to WiFi**
    ```markdown
    sudo systemctl disable NetworkManager
    sudo systemctl stop NetworkManager
    sudo apt-get update
    sudo apt-get install -y dhcpcd5
    sudo cp /usr/share/dhcpcd/hooks/10-wpa_supplicant /lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant
  
*   **Copy OS4 Files to bookworm**
    
    *   Copy `/opt` from OS4 image to `/opt` in bookworm. Replace RetroArch binary with the one you compiled.
    *   Copy `.config/retroarch`.
    *   Copy udev rules.
    *   Copy any boot or shutdown services.
    *   Copy `config.txt` to `boot/config.txt` even though it says don't write to that file (gets rid of RGBPi device warning).
    *   Copy Python all files in /usr/lib/python3/dist-packages directly from OS4 image into /usr/lib/python3.9/site-packages. Installing the same versions manually does not work for some reason and video wont init
    *   Run `pip list` to confirm they are installed.


Known problems
- wifi may not connect right away, may take a reboot after typing password in
- ui is not 100% smooth, this does not affect retroarch
- interlaced games do not work, at least for me. timings are all wonky. More research needed.
- working on kodi, has the same interlace issue
- not all cores are optimized for pi5. N64, Dreamcast, Naomi dont work right now. Need to do more research/compile new cores.
