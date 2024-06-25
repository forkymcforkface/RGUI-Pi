I built this script since I had a Pi5 and I couldn't wait for a proper dynamic resolution solution for the Pi5. CRT-RGUI is a bare bones CRT Compatible raspberry pi installer that works with basically any GPIO video output. It utilizes Ruben Tomas Dynares driver along with the below pieces.

------------------------
Build Sources
- Debian Bookworm: https://www.raspberrypi.com/news/bookworm-the-new-version-of-raspberry-pi-os/
- Python Version: 3.9.2
- Custom RetroArch: https://github.com/rtomasa/RetroArch
- GPIO Video driver: https://github.com/rtomasa/rpi-dpidac
- Jamma Driver: https://github.com/rtomasa/JammaPi
- Guncon Driver: https://github.com/rtomasa/guncon2
------------------------


*Self Install**
   - https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit
   - Plug into Pi5
   - Get IP address
   - SSH Login as pi user
   - Run the below command and sit back until the OS4 UI appears
   ```markdown
   sudo apt install git -y && git clone --depth=1 https://github.com/forkymcforkface/RGBPi-Bookworm.git && cd RGBPi-Bookworm && chmod +x Install-OS4.sh && ./Install-OS4.sh
   ```
--------------------
 
**Known problems**
- Must use a USB Dac that has the device name headphone in alsamixer, if it does not, audio will not work in OS4 UI. I use this specific one (https://a.co/d/2eTi2mp) 
- Pi5 does not and will not support interlacing through GPIO.
