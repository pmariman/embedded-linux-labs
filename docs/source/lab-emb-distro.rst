Distribution Based Root Filesystem
==================================


References
----------

* https://www.debian.org/intro/why_debian
* https://www.armbian.com


Goals
-----

* Extract and install an SD card image
* Analyse a Distribution based embedded Linux system


Concepts
--------

TBD


Steps
-----

1. Download the file **rootfs-xxx-debian.img.gz** from the server (where *xxx* stands for the platform):
::

   user@host: cd ${DL_PATH}
   user@host: wget ${serverip}/downloads/rootfs-xxx-debian.img.gz

2. Extract the image on your host:
::

   user@host: gunzip rootfs-xxx-debian.img.gz

3. Byte copy the extracted image to an SD card (for example: ``/dev/mmcblk0`` or ``/dev/sda``):

   - **WARNING**: clearly check the device id of the SD card!
   - **WARNING**: clearly check that the SD card partitions are not automatically mounted!

::

   user@host: dd if=rootfs-xxx-debian.img of=/dev/mmcblk0 bs=1M

4. Insert the SD card in the target and boot the board:

   - Watch the serial output while booting, using ``minicom`` at a baud rate of 115200 kbps


5. Explore the system (lookup login name and password)
::

   login:  user_name
   passwd: user_password

6. On the target: If the boot partition is not mounted on ``/boot`` or ``/boot`` does not exist at all:

   - **WARNING**: clearly check the device id of the SD card!

::

   root@target: mkdir /boot
   root@target: mount /dev/mmcblk0p1 /boot

7. Get the IP address and log in over SSH


Questions
---------
* What is the default shell? (hint: shell variable ``$SHELL``)
* What binaries are installed?
  (hint: look in ``/bin``, ``/sbin``, ``/usr/bin``, ``/usr/sbin``, ``/lib``, ``/usr/lib``)
* What is the size of binary and library directories? (hint: use ``du``)
  (hint: look in ``/bin``, ``/sbin``, ``/usr/bin``, ``/usr/sbin``, ``/lib``, ``/usr/lib``)
* What is the total size of each filesystem? (hint: use ``df``)
* What is the used size of each filesystem? (hint: use ``df``)
* What are the filesystem usage percentages? (hint: use ``df``)
* Which kernel is running? (hint: use ``uname``)
* Is Python installed? Why would this be used on an embedded system?
* Is Perl installed? Why would this be used on an embedded system?
* What are the steps to update the system?
