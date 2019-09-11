Configure and Build the Linux Kernel
====================================

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------
* Bootlin_ slides, chapter *Linux kernel introduction*
* Mainline kernel: https://www.kernel.org/


Goals
-----
* Understand the Linux kernel build and configuration process
* Build a kernel for the native architecture of the host (using the native distribution C compiler)
* Test the kernel on an emulated x86 system


Concepts
--------
* The default architecture is **x86_64**.
* All supported architectures have subdirectory in ``arch/`` subdirectory of the kernel source.
* Main architectures for embedded Linux devices: ``arm``, ``mips``, ``x86``, ``powerpc``

.. important::
    The following steps are taken to configure, build and use a kernel:

        * ``make <some-defconfig>``
        * ``make``
        * ``make install``


Steps
-----
#. Get the kernel source::

    user@host: cd ${DL_PATH}
    user@host: wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.0.6.tar.xz

#. Extract the source tarball on your host::

    user@host: mkdir ${LINUX_PATH}
    user@host: tar -C ${LINUX_PATH} -xvf linux-5.0.6.tar.xz
    user@host: cd ${LINUX_PATH}/linux-5.0.6/

#. Set a default configuration for **x86_64**::

    user@host: make x86_64_defconfig

#. Optionally: Start kernel configuration menu::

    user@host: make menuconfig

#. Start kernel build process, (note: the number of jobs for make should equal 2*cpus + 1)::

    user@host: make -j 9

#. Test if the kernel boots in an emulated environment::

    user@host: qemu-system-x86_64 -M pc -no-reboot -kernel arch/x86/boot/bzImage \
                -append "panic=1 console=tty1"


Hints
-----
* The following packages might need to be installed in order to build::

    user@host: sudo apt install libssl-dev flex bison

* Remove the ``panic=1`` parameter to not reboot the virtual machine


Questions
---------
* What does the error generated at the end of the kernel initialization mean?
* Under which path in the kernel configuration is the CPU architecture defined?
