Debootstrap a Debian System
===========================


Concepts
--------

* **Debootstrap:** Tool to install Debian base system into a subdirectory
* Only needs access to a Debian repository, like https://www.debian.org/mirror/list
* Cross architecture: cross-debootstrapping
* Debian one of the most stable systems available for desktop and server
* Not the most optimal solution for embedded systems

  - Further customisation for embedded systems possible
  - For example: included man pages, locales, ...


References
----------

* ``man debootstrap``


Goals
-----

* Create a Debian root file system
* Integrate custom kernel and modules
* Make a bootable storage medium and test on hardware platform


Steps
-----

1. Prepare host tools:
::

    root@host: apt install debootstrap qemu qemu-user-static binfmt-support fakeroot

2. Create a minimal install root file system (``--variant=minbase``)
::

   root@host: debootstrap --no-check-gpg --foreign --arch=armhf  \
                --variant=minbase jessie rootfs/ \
                http://archive.raspbian.org/raspbian

3. Second stage debootstrapping:

   - Necessary for non native architecture, like ``armhf``
   - Use qemu-arm-static for cross execution inside ``rootfs/``

::

   root@host: cp /usr/bin/qemu-arm-static rootfs/usr/bin/
   root@host: LANG=C chroot rootfs/ /debootstrap/debootstrap --second-stage
   root@host: LANG=C chroot rootfs/ apt-get clean
   root@host: LANG=C chroot rootfs/ apt-get autoclean
   root@host: rm rootfs/usr/bin/qemu-arm-static

4. Directory ``rootfs/`` can be copied to root file system partition of SD card


Assignments
-----------

* Configure the necessary configuration files
* Re-run the build procedure, but include some packages


Questions
---------

* What are the benefits and drawbacks of this procedure?
* What are the possible use cases of using Debian in products?


Hints
-----

* https://github.com/phmariman/linux-tinkering/tree/master/debian-arm-build
* Overlay directory:

::

   linux-tinkering/debian-arm-build/deb-rpi-overlay
   etc/
    - apt/
         - sources.list
    - fstab
    - hostname
    - modules
    - systemd/
        - system/
            - getty@ttyAMA0.service -> /lib/systemd/system/getty@.service

* Sample ``/etc/fstab``:

::

   root@host: cat rootfs/etc/fstab
   proc           /proc      proc defaults         0 0
   /dev/mmcblk0p1 /boot      vfat defaults         0 2
   /dev/mmcblk0p2 /          ext4 defaults,noatime 0 2
   /dev/mmcblk0p3 /opt/data  ext4 defaults,noatime 0 2
