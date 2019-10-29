Cross-compiling the Linux Kernel
================================

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------

* Bootlin_ slides, chapter *Linux kernel introduction*
* Mainline kernel: https://www.kernel.org/


Goals
-----

* Cross-compile a kernel for an emulated target
* Use the Debian packaged cross-compiler
* Make a kernel configuration


Kernel make arguments for cross-compilation
-------------------------------------------

* Possible parameters passed to ``make`` for cross compilation:

======================= =========================== ===============================
**Option**              **Description**             **Example**
----------------------- --------------------------- -------------------------------
``ARCH=``               indicate the architecture   ``ARCH=arm``
``CROSS_COMPILE=``      cross compiler prefix       ``CROSS_COMPILE=arm-linux-``
``INSTALL_MOD_PATH=``   path to install modules     ``INSTALL_MOD_PATH=../staging``
======================= =========================== ===============================

* Pre-defined configuration files available for a lot of embedded boards.
* Architecture and vendor specific configurations enabled.


Steps
-----

1. Install packaged ARM cross-compiler toolchain from distribution:
::

    user@host: sudo apt install gcc-arm-linux-gnueabihf

2. Get the kernel source:
::

    user@host: cd ${DL_PATH}
    user@host: wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.6.tar.xz

3. Extract the source tarball on your host:
::

    user@host: mkdir ${LINUX_PATH}
    user@host: tar -C ${LINUX_PATH} -xvf linux-5.0.6.tar.xz
    user@host: cd ${LINUX_PATH}/linux-5.0.6/

4. Set a default configuration for **vexpress**, a motherboard containing an ARM Cortex-A9:
::

    user@host: ARCH=arm make vexpress_defconfig

5. Optionally: Start kernel configuration menu:
::

    user@host: ARCH=arm make menuconfig

6. Start kernel build process, (note: the number of jobs for make should equal 2*cpus + 1):
::

    user@host: ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j 9

7. Test if the kernel boots in an emulated environment:
::

    user@host: qemu-system-arm -M vexpress-a9 -nographic -no-reboot \
                    -kernel arch/arm/boot/zImage \
                    -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
                    -append "panic=5 console=ttyAMA0"

8. The kernel should panic


Assignments
-----------

* Cross compile *init-hello-world* with **arm-linux-gnueabihf-gcc** and test ``init=`` in qemu


Questions
---------

* Show the differences between the default and your kernel configuration.


Staging Installation Steps (Preparing the root file system)
-----------------------------------------------------------

1. Cross-compile the kernel modules:
::

    user@host: ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make -j 9 modules

2. Copy the kernel to staging directory:
::

    user@host: mkdir ${STAGING_PATH}/boot
    user@host: cp arch/arm/boot/zImage ${STAGING_PATH}/boot/zImage

3. Copy the device tree to staging directory:
::

    user@host: cp arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
                        ${STAGING_PATH}/boot/vexpress-v2p-ca9.dtb

4. Install kernel modules to staging directory:
::

    user@host: ARCH=arm INSTALL_MOD_PATH=${STAGING_PATH} make modules_install


Assignments
-----------

* Clean the *Busybox* build
* Enable the ``modprobe`` command and cross compile *Busybox*
* Install *Busybox* to the the staging directory
* Create a compressed *cpio* archive and boot in *qemu*
* Load a kernel module using ``modprobe``


Optional Assignments
--------------------

* Cross compile *toybox*, create a new compressed *cpio* archive and boot in *qemu*.
  Compare the differences between *toybox* and *busybox*.
* Configure the kernel in a way to make the resulting binary as small as possible (non used funtionality can be
  removed from the config, e.g. ipv6, wireless networking, exotic protocols, file systems, ...)
