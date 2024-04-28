1. **Install 64bit bookworm lite onto SD card**
   - Enable SSH.
   - Modify root pw and allow root SSH in sshd_config.
   - reboot

2. **Install DPIDAC for SCART cable driver**
   - [GitHub Repository: forkymcforkface/rpi-dpidac](https://github.com/forkymcforkface/rpi-dpidac)
   - reboot and you will now have video via scart.

3. **Compile RetroArch**
   - [GitHub Repository: forkymcforkface/RetroArch](https://github.com/forkymcforkface/RetroArch)
   - Go to the bottom and modify 64bit compile without FFMPEG.

4. **Compile and altinstall Python 3.9.2** (or download precompiled one here and altinstall)
   ```markdown
   sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget vim
   wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
   tar zxf Python-3.9.2.tgz
   ./configure --enable-optimizations --with-ensurepip=install
   sudo make altinstall

*   **Run RetroPie installer and install SDL2 package**
      
    `git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git cd RetroPie-Setup sudo ./retropie_setup.sh`
    
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
    *   Copy Python site-packages directly from OS4 image to `bookworm3.9.2` folder. Installing the same versions manually does not work for some reason.
    *   Run `pip list` to confirm they are installed.


Known problems
- wifi may not connect right away, may take a reboot after typing password in
- ui is not 100% smooth, this does not affect retroarch
- interlaced games do not work, at least for me. timings are all wonky. More research needed.
- working on kodi, has the same interlace issue
- not all cores are optimized for pi5. N64, Dreamcast, Naomi dont work right now. Need to do more research/compile new cores.
