# Setup ext4 root filesystem

qemu-debootstrap --arch=arm64 buster /mnt

mount -o bind /proc /mnt/proc
mount -o bind /dev /mnt/dev
mount -o bind /dev/pts /mnt/dev/pts
mount -o bind /sys /mnt/sys

# Make internet available from within the chroot, and setup fstab, hostname, and sources.list

cp /etc/resolv.conf /mnt/etc/resolv.conf
rm /mnt/etc/fstab
rm /mnt/etc/hostname
rm /mnt/etc/apt/sources.list
echo "proc            /proc           proc    defaults          0       0
/dev/mmcblk0p1  /boot           vfat    defaults          0       2
/dev/mmcblk0p2  /               ext4    defaults,noatime  0       1" >> /mnt/etc/fstab

echo "debian-rpi64" >> /mnt/etc/hostname

echo "deb http://deb.debian.org/debian/ buster main contrib non-free
#deb-src http://deb.debian.org/debian/ buster main contrib non-free

deb http://deb.debian.org/debian/ buster-updates main contrib non-free
#deb-src http://deb.debian.org/debian/ buster-updates main contrib non-free

deb http://deb.debian.org/debian-security buster/updates main contrib non-free
#deb-src http://deb.debian.org/debian-security buster/updates main contrib non-free

deb http://ftp.debian.org/debian buster-backports main
#deb-src http://ftp.debian.org/debian buster-backports main" >> /mnt/etc/apt/sources.list

# Setup bootloader and kernel

wget http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-bootloader_1.20190925-2_armhf.deb
mkdir /tmp/pi-bootloader/
dpkg-deb -x raspberrypi-bootloader_1.20190925-2_armhf.deb /tmp/pi-bootloader/
cp /tmp/pi-bootloader/boot/* /mnt/boot/
rm raspberrypi-bootloader_1.20190925-2_armhf.deb

wget https://github.com/sakaki-/bcm2711-kernel/releases/download/4.19.93.20200107/bcm2711-kernel-4.19.93.20200107.tar.xz
mkdir /tmp/pi-kernel
tar xf bcm2711-kernel-4.19.93.20200107.tar.xz -C /tmp/pi-kernel/
cp -r /tmp/pi-kernel/boot/* /mnt/boot/
mv /mnt/boot/kernel*.img /mnt/boot/kernel8.img
mkdir /mnt/lib/modules
cp -r /tmp/pi-kernel/lib/modules /mnt/lib/
rm bcm2711-kernel-4.19.93.20200107.tar.xz
rm -r /tmp/pi-kernel

## Comment or remove completely the above kernel setup and uncomment the kernel setup below to setup the image to run on the Pi 3 instead of the Pi 4.

#wget https://github.com/sakaki-/bcmrpi3-kernel/releases/download/4.19.89.20191224/bcmrpi3-kernel-4.19.89.20191224.tar.xz
#mkdir /tmp/pi-kernel
#tar xf bcmrpi3-kernel-4.19.89.20191224.tar.xz -C /tmp/pi-kernel/
#cp -r /tmp/pi-kernel/boot/* /mnt/boot/
#mkdir /mnt/lib/modules
#cp -r /tmp/pi-kernel/lib/modules /mnt/lib/
#rm bcmrpi3-kernel-4.19.89.20191224.tar.xz
#rm -r /tmp/pi-kernel

# Setup config.txt and cmdline.txt

echo "disable_overscan=1
#dtoverlay=vc4-kms-v3d" >> /mnt/boot/config.txt

echo "dwc_otg.lpm_enable=0 console=ttyAMA0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait" >> /mnt/boot/cmdline.txt

# Copy stage2 to chroot environment

cp stage2.sh /mnt/
echo "Run stage2.sh in chroot for stage 2."
chroot /mnt
