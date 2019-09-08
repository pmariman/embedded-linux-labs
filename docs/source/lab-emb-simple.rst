Simple Root Filesystem
======================

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------

* Bootlin_ slides, chapter: *Linux Root Filesystem*
* Bootlin_ slides, chapter: *Busybox*


Goals
-----

* Extract and install an SD card image
* Analyse a simple embedded Linux system
* Understand the Busybox command multiplexer


Steps
-----

1. Download a **rootfs-xxx-simple.img.gz** from the server (where *xxx* stands for the platform):
::

    user@host: cd ${DL_PATH}
    user@host: wget ${serverip}/downloads/rootfs-xxx-simple.img.gz

2. Extract the image on your host:
::

    user@host: gunzip rootfs-xxx-simple.img.gz

3. Byte copy the extracted image to an SD card (for example: ``/dev/mmcblk0`` or ``/dev/sda``):

   - **WARNING**: clearly check the device id of the SD card!
   - **WARNING**: clearly check that the SD card partitions are not automatically mounted!

::

    user@host: dd if=rootfs-simple.img of=/dev/mmcblk0 bs=1M

4. Insert the SD card in the target and boot the board

   - Watch the serial output while booting, using ``minicom`` at a baud rate of 115200 kbps

5. Explore the system:
::

    login:  root
    passwd: root

6. On the target: If the boot partition is not mounted on ``/boot`` or ``/boot`` does not exist at all:

   - **WARNING**: clearly check the device id of the SD card!

::

    root@target: mkdir /boot
    root@target: mount /dev/mmcblk0p1 /boot

7. Get the IP address and log in over SSH


Questions
---------

* What is the default shell?
* What binaries are installed?
* What is the size of binary and library directories?
* What is the partition layout?
* What filesystems are mounted?
* What is the total size of each filesystem?
* What is the used size of each filesystem?
* What are the filesystem usage percentages?
* Which kernel is running?
* Where are the kernel image and device tree blob located?
* What is special about standard utilities (``ls``, ``cat``, ...)?
* What are the differences with a Debian based embedded Linux systems?
