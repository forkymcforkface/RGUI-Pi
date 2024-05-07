**Install 64bit bookworm lite onto SD card** https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit
   - Plug into Pi5
   - Get IP address
   - SSH Login as Pi user
   - Run the below command and sit back until the OS4 UI appears
   ```markdown
   sudo apt install git -y && git clone --depth=1 --branch=dev https://github.com/forkymcforkface/RGBPi-Bookworm.git && cd RGBPi-Bookworm && chmod +x Install-OS4.sh && ./Install-OS4.sh
   ```

   **Known problems**
   - USB Audio dac required
   - wifi may not connect right away, may take a reboot after typing password in
   - Pi5 does not support interlacing
   - Kodi is not installed since interlacing isnt supported
   - Does not include scraper images (900Mb) this is to keep down size and increase install speed.
   - Dreamcast will not work correctly without the pi5 branch of RGBPi-Extra. Naomi games do not currently work. https://github.com/forkymcforkface/RGBPi-Extra/tree/Pi5
