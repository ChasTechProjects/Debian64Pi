# Apt install core packages

apt upgrade -y 
apt install console-setup keyboard-configuration sudo ssh curl wget dbus usbutils ca-certificates crda less fbset debconf-utils avahi-daemon fake-hwclock nfs-common apt-utils man-db pciutils ntfs-3g apt-listchanges -y
apt install wpasupplicant wireless-tools firmware-atheros firmware-brcm80211 firmware-libertas firmware-misc-nonfree firmware-realtek dhcpcd5 net-tools -y
service dbus restart

# OPTIONAL: Install desktop environment, doesn't have to be XFCE

#apt install task-xfce-desktop

# Setup default user; this step does require a bit of user interaction for password and user info

adduser debian
usermod -aG sudo,video,audio,cdrom debian
echo "Now, exit the chroot and run stage3.sh."
