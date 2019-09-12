Extending Buildroot System Image
================================

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------

* Bootlin_ slides, chapter **Embedded Linux system development**
* Main Buildroot documentation: https://buildroot.uclibc.org/downloads/manual/manual.html


Goals
-----

* Get familiar with user space tools and libraries for embedded Linux systems


Assignment
----------

* Change the default hostname of the system image.
* Add a SSH server to the configuration.
* Add a web server to the configuration.
* Add the ``netcat`` utility from Busybox.
* Add the ``ss`` utility. Figure out which package to add.
* Add ``libzmq`` and ``libcurl`` to the configuration.
* Add a complex package (NodeRed, Python, ...)


Steps
-----

1. Do the necessary configuration of the assignment and build:
::

   user@host: cd ${BR_PATH}
   user@host: make menuconfig
   user@host: make

2. Insert the SD card in the host machine and clear the ``root`` partition:
::

   root@host: mount /dev/mmcblk0p2 ${MNT_PATH}
   root@host: rm -rf ${MNT_PATH}/*

3. Unpack the latest generated tar image from Buildroot on the ``root`` partition:
::

   root@host: tar -C ${MNT_PATH} -xvf ${BR_PATH}/output/images/rootfs.tar

4. Unmount the SD card and test on the target:
::

   root@host: umount ${MNT_PATH}

* **Note:** as an alternative to extracting a tar archive to the second file system, a full file system image can be
  byte copied into place (if the partition is big enough):
* **WARNING:** clearly check that the SD card partitions are not automatically mounted!

::

   user@host: cd ${BR_PATH}
   root@host: dd if=${BR_PATH}/output/images/rootfs.ext4 of=/dev/mmcblk0p2 bs=1M


Hints
-----

* The default size of the ``ext4`` partition of the SD card image might be too small for these changes.
  Increase the size of the ``ext4`` image in the *menuconfig*. Also increase the size of the partition and the filesystem on the SD card.


Questions
---------

* Which package did you enable to include a SSH server?
* Which package did you enable to include a web server?
* What are the differences between the ``netcat`` utilities from Busybox and on your host system?
* Which package did you enable to include ``ss``? What is the impact of this for the target root filesystem?
