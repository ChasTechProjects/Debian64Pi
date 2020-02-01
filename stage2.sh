# Apt install core packages

apt update
apt upgrade -y 
apt install console-setup keyboard-configuration sudo ssh curl wget dbus usbutils ca-certificates crda less fbset debconf-utils avahi-daemon fake-hwclock nfs-common apt-utils man-db pciutils openssh-server zram-tools ntfs-3g apt-listchanges -y
apt install wpasupplicant wireless-tools firmware-atheros firmware-brcm80211 firmware-libertas firmware-misc-nonfree firmware-realtek dhcpcd5 net-tools -y

# Setup zram-tools - swap will be 2 x ram amount. 1GB ram, will give you 2gb zram

rm /etc/default/zramswap

echo '# Specifies amount of zram devices to create.
# By default, zramswap-start will use all available cores.
#CORES=1

# Specifies the amount of RAM that should be used for zram
# based on a percentage the total amount of available memory
PERCENTAGE=200

# Specifies a static amount of RAM that should be used for
# the ZRAM devices, this is in MiB
#ALLOCATION=256

# Specifies the priority for the swap devices, see swapon(2)
# for more details.
#PRIORITY=100' >> /etc/default/zramswap

# Uncomment one of these to install a Desktop Environment

#apt install task-xfce-desktop -y # For XFCE
#apt install task-gnome-desktop -y # For GNOME
#apt install task-kde-desktop-y # For KDE Plasma
#apt install task-mate-desktop -y # For MATE
#apt install task-lxde-desktop -y # For LXDE
#apt install task-lxqt-desktop -y # For LXQT

# Setup default user; this step does require a bit of user interaction for password and user info

adduser debian
usermod -aG sudo,video,audio,cdrom debian
echo "Now, exit the chroot and run stage3.sh."
