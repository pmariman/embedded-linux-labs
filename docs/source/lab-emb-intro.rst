Introduction
============

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------

.. important::
   The labs use the `Bootlin Embedded Linux training slides <Bootlin_>`_ as reference material

* Bootlin_ slides, chapter: *Introduction to Embedded Linux*
* Bootlin_ slides, chapter: *Embedded Linux Development*


Hardware for Labs
-----------------

* Development board (Raspberry Pi 3, Banana Pi M2+, ...)
* Power supply
* USB to UART TTL cable
* Housing for board


Terminology
-----------

Host System
  Workstation where development and cross compiling is done
Target System
  The embedded target


Host Tools and Libraries
------------------------

* **fdisk**:
  Partitioning tool
* **gcc**:
  GNU C compiler (package ``build-essential``)
* **git**:
  Software version control software
* **kpartx**:
  Tool to create device maps from partition tables
* **libncurses5-dev**:
  Needed to run kconfig for Buildroot
* **minicom**:
  Terminal emulator
* **mkfs**:
  Tool to create a filesystem
* **qemu**:
  Emulation tool
* **ssh**:
  Secure Shell
* **vim**:
  Command line text editor


Conventions \& Host Set Up
--------------------------

* Debian (or any Debian based distribution) works best
* No GUI environment needed (!)
* Default shell: **bash**
* Directory set up:

============================ =================== ===========
**Directory**                **Shell variable**  **Description**
---------------------------- ------------------- -----------
``/home/user/dev/``          ``${DEV_PATH}``     main development directory
``/home/user/dev/dl``        ``${DL_PATH}``      downloads directory
``/home/user/dev/staging``   ``${STAGING_PATH}`` target rootfs staging directory
``/home/user/dev/linux``     ``${LINUX_PATH}``   kernel source directory
``/home/user/dev/buildroot`` ``${BR_PATH}``      Buildroot source directory
``/home/user/dev/mnt``       ``${MNT_PATH}``     mountpoints directory
============================ =================== ===========


Programming Rules
-----------------
* All code produced shall follow the Linux Coding Style
  [`link <https://www.kernel.org/doc/html/v4.10/process/coding-style.html>`_]
* All code provided for review shall compile (at least)
* All code delivered must be uploaded to git repo.


Warnings
--------

.. important::
   * When removing the SD card from a target, always first power off the target. Otherwise the SD card might get damaged.
   * Disable automounting volumes on the host system. Otherwise formatting the SD card does not work when filesystems of the SD card are mounted.
   * If the target has on board flash (eMMC), make sure it is erased. The only bootable source for the labs should be the SD card.


Not Covered (yet)
-----------------
* Building cross-compilation toolchain with \textbf{crosstool-ng}
* NFS mounting the root filesystem
* Patching the kernel sources
* Raw flash filesystems
* Audio and video subsystems
* Real time Linux
* Remote application debugging
