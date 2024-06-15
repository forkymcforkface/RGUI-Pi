I built this image since I had a Pi5 and I couldn't wait for ReplayOS. That being said, ReplayOS is going to be much better than OS4. I hope my many hours of work makes your day better. Happy Gaming!  

------------------------
Open Sources
- Debian Bookworm: https://www.raspberrypi.com/news/bookworm-the-new-version-of-raspberry-pi-os/
- Python Version: 3.9.2
- Custom RetroArch: https://github.com/rtomasa/RetroArch
- GPIO Video driver: https://github.com/rtomasa/rpi-dpidac
- Jamma Driver: https://github.com/rtomasa/JammaPi
- Guncon Driver: https://github.com/rtomasa/guncon2
------------------------


*Self Install** (this has zero custom code and just the original OS4 file copied from the open source linux image provided)
   - https://www.raspberrypi.com/software/operating-systems/#raspberry-pi-os-64-bit
   - Plug into Pi5
   - Get IP address
   - SSH Login as pi user
   - Run the below command and sit back until the OS4 UI appears
   ```markdown
   sudo apt install git -y && git clone --depth=1 https://github.com/forkymcforkface/RGBPi-Bookworm.git && cd RGBPi-Bookworm && chmod +x Install-OS4.sh && ./Install-OS4.sh
   ```
--------------------

**Features (open source)**
- Works with RGBPi, VGA666, Pi2Scart cable and should work with others as well.
  - enable VGA666 in OS4 UI: before mounting an external drive, scan for new games, open ports folder, press 'VGA666 Mode')
- Works with RGBPi Jamma/Plus

**Known problems**
- Must use a USB Dac that has the word headphone in the device name. I use this specific one (https://a.co/d/2eTi2mp) 
- Pi5 does not and will not support interlacing through GPIO.
- OS4 Pi UI is half the fps as Pi4 UI, does not affect retroarch.
- Bluetooth controllers do not work.
