# Debian64Pi
64-bit Debian Buster images for the Raspberry Pi 3 and 4.

There is no 'universal' image that supports both the Pi 3 and 4, you must download the Pi 3 image to run it on a Pi 3B/B+/A+ or the Pi 4 image if you want to run it on the Pi 4B. Instructions will be added in the future for adapting a Pi 3 installation to run on the Pi 4 (this will result in loss of Pi 3 support in the image, however) and vice versa.

The source code includes three stage scripts: stage1.sh sets up the image, installs Debian, modifies fstab, hostname, and sources.list, and installs the bootloader and kernel. stage2.sh installs core Debian packages into the image as well as WiFi drivers for the Pi's wireless capabilities. stage3.sh unmounts the mount points for the image, allowing the image to be flashed to your SD card.

WIP.
