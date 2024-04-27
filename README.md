1. Install bookworm lite onto sd card
enable ssh
modify rootpw and allow root ssh

2. Install DPIDAC for scart cable driver
https://github.com/forkymcforkface/rpi-dpidac
modify timings.txt location to /opt/rgbpi/ui/data/timings.dat

3. Compile retroarch
https://github.com/forkymcforkface/RetroArch
go to bottom and modify 64bit compile without FFMPEG

4. Compile and altinstall python3.9.2
sudo apt-get install -y build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev tar wget vim
wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
tar zxf Python-3.9.2.tgz
./configure --enable-optimizations --with-ensurepip=install
sudo make altinstall

5. run retropie installer and install SDL package
git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git
cd RetroPie-Setup
sudo ./retropie_setup.sh


6. Copy OS4 Files to bookworm
Copy /opt from os4 image to /opt in bookworm
Copy .config/retroarch
Copy udev rules
Copy any boot or shutdown services
Copy config.txt to boot/config.txt even though it says dont write to that file (gets rid of rgbpi device warning)
Copy python site-packges directly from OS4 image to bookworm3.9.2 folder. Installing the same versions manually does not work for some reason
pip list to confirm they are installed
