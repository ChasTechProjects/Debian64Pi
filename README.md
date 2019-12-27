# Debian64Pi
64-bit Debian Buster images for the Raspberry Pi 3 and 4.

These images include both Pi 3 and 4 kernels in the boot partition. By default, the Pi 4 one is selected by config.txt. To select the Pi 3 one, change the following line:

<code>kernel=kernel_rpi4.img</code>

to

<code>kernel=kernel_rpi3.img</code>

KVM support is enabled in the 64-bit kernel allowing for the use of acceleration in virtual machines. This works better on the Pi 4 due to the extended amount of RAM that can be allocated to a VM.



