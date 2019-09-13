Buildroot Initial Config
========================


References
----------

* Main Buildroot documentation: https://buildroot.uclibc.org/downloads/manual/manual.html


Goals
-----

* Explore the Buildroot configuration system
* Make an initial configuration for Buildroot
* Build a first **Board Support Package (BSP)** with Buildroot
* Analyse the generated output


Steps
-----

1. Download a recent Buildroot version: **2019.02.1**:
::

   user@host: cd ${DL_PATH}
   user@host: wget https://buildroot.uclibc.org/downloads/buildroot-2019.02.1.tar.gz

2. Extract the tarball and ``cd`` into the unpacked directory:
::

   user@host: tar -xvf buildroot-2019.02.1.tar.gz
   user@host: mv buildroot-2019.02.1/ ${BR_PATH}
   user@host: cd ${BR_PATH}

3. Initialize the configuration with the default one provided:
::

   user@host: make xxx_defconfig

4. Enter the configuration menu:
::

   user@host: make menuconfig

5. Update the configuration as following:

   * set the download directory to ${DL_PATH}
   * include WCHAR support
   * include C++ support
   * set root passwd "root"
   * start a getty on ``ttyAMA0`` or ``ttyS0`` (depending on the platform)
   * let Buildroot generate a "tar" filesystem image

6. Start the build:
::

   user@host: make


Assignments
-----------

* Build a SD card image for a hardware platform
* Configure the system to automatically handle DHCP on the network interface
* Test the image on the hardware


Questions
---------

* Compare the ``Target options`` in the menuconfig (using the defconfigs) for:

  - **raspberrypi3** vs **beaglebone**
  - **beaglebone** vs **qemu_x86_64**

* What is the default configured ``libc`` for the cross toolchain? And what others are available?
* Which version of ``gcc`` is used for the cross toolchain? What version is shipped on the host machine?


Buildroot Output Directories
----------------------------

* Buildroot will generate its build artifacts under the ``output/`` directory:

  - ``build/``: contains all packages *build* subdirectories
  - ``host/``: contains the generated host tools (compiler, autotools, ...)
  - ``images/``: contains the generated target images (kernel, device tree blob, bootloader, filesystem images, tarballs, SD card images)
  - ``target/``: mimics the root filesystem excluding ``/dev``


Hints
-----

::

   # print help
   make help

   #make
   make list-defconfigs

   # load a default configuration file from configs/ directory
   make <target_defconfig>

   # start the configuration menu
   make menuconfig

   # start the Linux kernel configuration menu
   make linux-menuconfig

   # start the Busybox configuration menu
   make busybox-menuconfig

   # run the download stage to download all software sources
   make source

   # start a build
   make

   # export the current configuration
   make savedefconfig
