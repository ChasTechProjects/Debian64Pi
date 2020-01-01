# Debian64Pi
64-bit Debian Buster images for the Raspberry Pi 3 and 4.

There is no 'universal' image that supports both the Pi 3 and 4, you must download the Pi 3 image to run it on a Pi 3B/B+/A+ or the Pi 4 image if you want to run it on the Pi 4B. Hopefully I will be able to find a fix soon for this.

The source code includes three stage scripts: stage1.sh sets up the image, installs Debian, modifies fstab, hostname, and sources.list, and installs the bootloader and kernel. stage2.sh installs core Debian packages into the image as well as WiFi drivers for the Pi's wireless capabilities. stage3.sh unmounts the mount points for the image, allowing the image to be flashed to your SD card.

## Build instructions

Use qemu-img to create a blank image of at least 3.5GB (more needed if you intend on preinstalling a desktop environment with the image):

<code>qemu-img create debian-rpi64.img 3.5G
  
  sudo losetup -f -P --show debian-rpi64.img</code>

You will be given the name of the loopback device (eg, /dev/loop0). Open it in gparted:

<code>sudo gparted /dev/loop0</code>

Click device in the top menu of the window, then create partition table and select DOS. Then, for the first partition create a FAT32 partition about 70MB. For the second partition, create an ext4 partition taking up the rest of the image. Then click apply.

Close the window and run:

<code>sudo mount /dev/loop0p2 /mnt
  
  sudo mkdir /mnt/boot
  
  sudo mount /dev/loop0p1 /mnt/boot</code>
  
Then, it's time to start the first script. Ensure your terminal session is working in the folder the image builder scripts are (using cd), and run:

<code>sudo ./stage1.sh</code>

By default, this script will setup the Pi 4 kernel, meaning it will not work on the Pi 3. To change it to the Pi 3, comment all the Pi 4 kernel install lines in the script and uncomment all the Pi 3 kernel install lines. This will break Pi 4 functionality however, as there is no current universal build support.

The script will setup a minimal Debian installation as well as the kernel and everything on the image. Once it's finished, you will be in the chroot environment, so run:

<code>./stage2.sh</code>

At some point you will be prompted for the keyboard configuration and to choose the password for the default user. You can tweak around if you want in stage2.sh, so if you're building a custom image for personal use you can change the username to something more personal and choose your own password when prompted. If building for public distribution you'll just want a username and password like debian.

There is a commented line in stage2.sh allowing for the XFCE desktop task to be installed, including XFCE and recommended PC software. You can uncomment this if you want or change it to another desktop task (eg, task-lxde-desktop). You will need a large image for this though, as this will install a lot of software as well as the desktop as it is a task package.

Once the script's finished you will not be automatically exited from the chroot, just in case you want to make any more customisations to your image. Once done, do exit the chroot with the 'exit' command.

Finally, once exited, run:

<code>sudo ./stage3.sh</code>

This will setup Pi-specific WiFi drivers and unmount any mount points. After that, you can use an image flashing tool to flash to your microSD card

