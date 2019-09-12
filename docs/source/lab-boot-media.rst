Creating Boot Media from Scratch
================================

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------

* Bootlin_ slides, chapter *Block filesystems*
* Bootlin_ slides, chapter *Flash filesystems* (not covered)


Goals
-----

* Filesystems Overview
* Usage of ``kpartx`` on boot images
* Create an SD card set up
* Bootloader installation and configuration
* Kernel, device tree and modules installation
* Root filesystem installation


Storage Media
-------------

* **Block Devices:** Random access on a per-block basis

  - Hard drives, RAM disks (tmpfs)
  - eMMC, USB flash storage, SD card, SSD: these have integrated controller to emulate block device, also handles *wear-leveling* and bad blocks

* **Raw Flash Devices:** Driven by controller on SoC. Support for reading, erasing and writing.


Partition Table
---------------

* **Partitioning:** Dividing the storage media in multiple areas for different usage.
* **Partition Table:** Description of partions on the storage media.
* **MBR:** Legacy table format, first 512 bytes of storage media.
* **GPT:** New table format.


Filesystems Overview
--------------------

* **Block filesystems:** These filesystems can be directly used on the storage media
  (hard disk or flash plus controller) to control individual blocks within a partition.
* **Flash filesystems:** These filesystems are for specific use for raw flash based devices. They operate on top of
  *MTD* layer, which manipultes the flash storage device. The current de-facto standard flash filesystem is *UBIFS*.


Steps
-----

1. Create empty image of certain size:
::

   user@host: dd if=/dev/zero of=sdcard.img bs=1M count=650

2. Create MBR partition table on empty image:
::

   user@host: fdisk sdcard.img

   Device      Boot  Start     End Sectors  Size Id Type
   sdcard.img1        2048  104447  102400   50M  c W95 FAT32 (LBA)
   sdcard.img2      104448 1292287 1187840  580M 83 Linux

3. Create device maps from partition table:
::

   user@host: sudo kpartx -a sdcard.img

4. Create FAT32 filesystem on first partition (boot):
::

   user@host: sudo mkfs.vfat -n boot /dev/mapper/loop0p1

5. Mount first partition and copy boot/ files from staging:
::

   user@host: sudo mount /dev/mapper/loop0p1 ${MNT_PATH}
   user@host: sudo cp ${STAGING_PATH}/boot/* ${MNT_PATH}
   user@host: sudo umount ${MNT_PATH}

6. Create ext4 filesystem on second partition (root):
::

   user@host: sudo mkfs.ext4 -L root /dev/mapper/loop0p2

7. Mount second partition and copy ``root/`` files from staging and rootfs image:
::

   user@host: sudo mount /dev/mapper/loop0p2 ${MNT_PATH}
   user@host: sudo tar -C ${MNT_PATH} -xf ${BR_PATH}/output/images/rootfs.tar
   user@host: sudo cp -R ${STAGING_PATH}/root/ ${MNT_PATH}
   user@host: sudo umount ${MNT_PATH}

8. Unmap image:
::

   user@host: sudo kpartx -d sdcard.img

9. Some platforms require the SoC to load the SPL U-Boot directly from the MMC device:
::

   user@host: sudo dd if=u-boot-with-spl.bin of=sdcard.img bs=1K seek=x

.. important:

   The SoC will search a SPL on storage devices. Look up the required offset in kb to pass to the *seek* argument

10. Write to SD card:
::

    user@host: sudo dd if=sdcard.img of=/dev/mmcblk0 bs=1M

* Or test in qemu:

::

   user@host: qemu-system-x86_64 -drive format=raw,file=sdcard.img
