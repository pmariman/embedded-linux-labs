Busybox
=======

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------

* Bootlin_ slides, chapter *Busybox*


Goals
-----

* Build a simple root file system with a minimal Busybox configuration


Steps
-----

1. Download the Busybox sources:
::

   user@host: cd ${DL_PATH}
   user@host: wget https://busybox.net/downloads/busybox-1.30.1.tar.bz2

2. Extract the Busybox sources:
::

   user@host: tar -xvf busybox-1.30.1.tar.bz2
   user@host: cd busybox-1.30.1/

3. Set the empty config and enter the configuration:
::

   user@host: make allnoconfig
   user@host: make menuconfig

4. Enable the option in the configuration to build statically, symbol ``CONFIG_STATIC``:
::

   --> Busybox Settings
           --> Build Options
                   --> Build Busybox as a static binary (no shared libs)

5. Select ``ash``, ``vi`` and all ``coreutils``
6. Select the following settings:

::

   CONFIG_SHOW_USAGE=y
   CONFIG_FEATURE_VERBOSE_USAGE=y
   CONFIG_FEATURE_COMPRESS_USAGE=y
   CONFIG_BUSYBOX=y
   CONFIG_FEATURE_INSTALLER=y
   CONFIG_PLATFORM_LINUX=y
   CONFIG_INSTALL_APPLET_SYMLINKS=y

7. Build and inspect:
::

   user@host: make -j 9
   user@host: file busybox

8. Install Busybox tree:
::

   user@host: make CONFIG_PREFIX=../bb_install install


Assignments
-----------

* Create a *cpio* archive containing the Busybox install tree
* Run the *cpio* archive as initramfs
* Show a directory listing of the root file system in run time


Questions
---------

* Create a file */root/hello* containing "hello world", reboot, what happens to the file? Why?
* What directories are missing in the root file system?


Busybox init System
-------------------

* Busybox provides a simple ``init`` system equivalent to ``System V init``
* It does not offer a lot of features, like runlevels, but it is a very simple implementation

* ``/sbin/init`` The init binary (or soft link)
* ``/etc/inittab`` Jobs description file for the **init** system

::

   user@host: cat bb_example/etc/inittab
   # /etc/inittab
   ::sysinit:/etc/init.d/rcS
   ttyS0::respawn:/sbin/getty -L ttyS0 0 vt100


* ``/etc/init.d/rcS`` Init script to kickstart all other startup scripts in this directory.

::

   user@host: cat bb_example/etc/init.d/rcS
   #!/bin/sh

   mount -a


* ``etc/fstab`` Description of administered system mount points; all mounted during init.

::

   user@host: cat bb_example/etc/fstab
   # /etc/fstab
   #device         mount-point  type      options           dump  fsck order
   /dev/mmcblk0p1  /boot        ext4      rw,noauto         0     1
   proc            /proc        proc      defaults          0     0
   sysfs           /sys         sysfs     defaults          0     0
   devtmpfs        /dev         devtmpfs  mode=0755,nosuid  0     0
   tmpfs           /tmp         tmpfs     defaults          0     0
   tmpfs           /run         tmpfs     defaults          0     0


Assignments
-----------

* Enable the standard configuration for Busybox (``make defconfig``)
* Create the necessary files to start a shell at the console
* Create or adapt a simple init script that runs a ``hello-world`` binary


Questions
---------

* What starts the tty on the serial console?
* Which other init systems exist? Which ones are suitable for embedded systems and why?


Adding User Files
-----------------

::

   user@host: cat bb_example/etc/passwd
   root:x:0:0::/root:/bin/sh


::

   user@host: cat bb_example/etc/shadow
   root::0::::::

