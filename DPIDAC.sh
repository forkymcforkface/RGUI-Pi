# Install DPIDAC for SCART cable driver, Only run this after running OS4 Install
apt install raspberrypi-kernel-headers -y
git clone https://github.com/forkymcforkface/rpi-dpidac
cd rpi-dpidac
make
make install
reboot
