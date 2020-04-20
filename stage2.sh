# Apt install core packages

apt update
apt upgrade -y 
apt install console-setup keyboard-configuration sudo ssh curl wget dbus usbutils ca-certificates crda less fbset debconf-utils avahi-daemon fake-hwclock nfs-common apt-utils man-db pciutils ntfs-3g apt-listchanges -y
apt install wpasupplicant wireless-tools firmware-atheros firmware-brcm80211 firmware-libertas firmware-misc-nonfree firmware-realtek dhcpcd5 net-tools -y

# Uncomment one of these to install a Desktop Environment

#apt install task-xfce-desktop -y # For XFCE
#apt install task-gnome-desktop -y # For GNOME
#apt install task-kde-desktop-y # For KDE Plasma
#apt install task-mate-desktop -y # For MATE
#apt install task-lxde-desktop -y # For LXDE
#apt install task-lxqt-desktop -y # For LXQT

# Setup default user; this step does require a bit of user interaction for password and user info
useradd -m -p '$6$bN7eXEuAm6uMIuX2$m760DygUoCHMA3yc2.cKfFMBFxvGeuBWfPM13FV5TB69IHjS1TDCPVP6X9xrQrHHvvkm99aVpi4B94byyPHNO/' -s /bin/bash pi # pi / raspberry
usermod -aG sudo,video,audio,cdrom pi

useradd -m -p '$6$bESbi8ENieH9wyMV$m/4ZAjsFJxdYGhp29MO/haSCfjv2Y6IBuBYa.2up8QhNTA2xevXHEFQj16xWDDGC3EtdgqlX6B1fiT/3FUJ8P1' -s /bin/bash debian  # debian / debian
usermod -aG sudo,video,audio,cdrom debian
