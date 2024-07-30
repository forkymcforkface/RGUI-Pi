RGUI-Pi is an advanced CRT only RGUI implementation using rtomasa Retroarch Dynares for pixel perfect gaming. It also has the ability to migrate OS4 from the Pi4 to the Pi5.

------------------------
**OS4 Migration**
- RGUI-Pi image https://mega.nz/folder/xqkh2Y6D#5S16aX_Ax2Lv6qtkpwGsdA
- The migration tool looks for a second OS4 drive at boot and migrates the files to the Pi5 sd card once it finds it. If it does not, it will boot to RGUI. You can either migrate your existing SD card or burn a fresh copy of OS4 onto a usb drive.
- If you are using the sd card you will have to use an sd to usb adatper
- Here is a video of the process https://youtu.be/CJom1TIRI6g
- Must use a USB Dac that has the device name 'Headphone' in alsamixer, if it does not, audio will not work in OS4 UI. I use this specific one (https://a.co/d/2eTi2mp) 
- Kodi disabled (do not use)

------------------------
Build Sources
- Debian Bookworm: https://www.raspberrypi.com/news/bookworm-the-new-version-of-raspberry-pi-os/
- Python Version: 3.9.2
- RetroArch: https://github.com/rtomasa/RetroArch
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
 

