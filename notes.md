## Prerequisites for Labs

* Basic to medior knowledge on the following topics is required:
  - Linux Basics
  - C programming
  - TCP/IP Networking
  - Embedded Programming & RTOS


## Agenda Week 1

* Day 1:
    * Intro
    * Embedded Linux in the field
    * Overview of devices in embedded systems (flash, block, serial, network, sensors, ...)
    * Embedded Linux components: bootloader, kernel, initramfs, root file system, BSP, ...
    * Workshop: Setup development platform (SD card, serial line, ...)
    * Workshop: Debian on embedded systems
    * Workshop: compact custom root file system
    * The Linux kernel (sources, configuration, versioning, development life cycle)
    * Explanation on x86 and embedded (ARM, MIPS, PPC, ...) CPU architectures
    * Workshop: Building Linux kernel and running in *qemu-system-x86_64*
* Day 2:
    * Linux boot process on x86 and init systems
    * Organization of root file system
    * Initial RAM file system (initramfs)
    * Workshop: Building a minimal root file system from scratch and running in *qemu-system-x86_64*
    * Cross compiling concepts (architectures, compiling & linking)
    * C libraries (overview, differences, selection, ...)
    * Workshop: Configuring and building a cross toolchain with *crosstool-ng*
    * Workshop: Building Linux kernel and running in *qemu-system-arm*
    * Workshop: Building a minimal root file system from scratch and running in *qemu-system-arm*
    * Workshop: Building a minimal root file system from scratch and running on development platform
* Day 3:
    * Build systems introduction, Buildroot introduction
    * Buildroot system configuration
    * Workshop: a first simple root file system with Buildroot
    * Linux generic boot process on ARM and the U-boot bootloader
    * Boot media overview (NAND, NOR, eMMC, USB, network, ...)
    * File systems overview (*ext4, squashfs, btrfs, nfs, f2fs, ...*)
    * Workshop: Boot media creation from scratch using *kpartx, parted, mkfs, ...*
    * Workshop: U-boot
* Day 4:
    * Linux kernel configuration for embedded systems
    * Linux kernel modules
    * Overview lightweight open source utilities
    * Workshop: a more complex root file system with Buildroot
    * Buildroot advanced tips & tricks


## Content Week 1
* Content selection from **Bootlin Slides**:
    * Introduction to embedded Linux
    * C libraries. Building a cross-compiling toolchain
    * Bootloaders (focus on U-boot)
    * Configuring, (cross) compiling and booting a Linux kernel
    * Creating a simple, BusyBox based root filesystem from scratch
    * Block filesystems
    * Cross-compiling libraries and applications
    * Embedded system building tools
    * Lightweight tools for embedded systems.
    * Developing and debugging applications for the embedded system (short)
* Specific content for practical labs on development board:
    * Debian on embedded systems
    * The Linux kernel (emulation on *qemu*)
    * Buildroot usage
    * Build simple root file system for development platform
    * U-boot bootloader
    * Build custom kernel for development platform
    * Cross compiling applications for development platform using Buildroot
    * Extending simple root file system for development platform
    * IoT use case project


## Lab Template
* Goal
* External literature / references
* Steps / implementation
* Assignments
* Questions
* Cool tricks
* Best Practices


## TODO embedded linux

* Lab on cross compiling busybox and creating a more complete cpio including modules and init etc
* Lab on cross compiling toybox and creating a more complete cpio including modules and init and bash etc
* U-Boot bootloader
  -  mkimage -T script -C none -n 'boot script file' -d ${file_in} ${file_out}
* Storage media overview and mtd vs mmc
* Types of HW platforms (ref slides bootlin) + examples
* Simple debootstrap
* Buildroot customization
    - References
      - Main Buildroot documentation, chapter 9: https://buildroot.uclibc.org/downloads/manual/manual.html#customize
    - Goals
      - Use customization options of Buildroot
    - Assignment
      - Create a custom board directory
      - Use an **overlay directory** to install a custom init script (BR2_ROOTFS_OVERLAY)
      - Use an **post build script** to modify ... (adapt *interfaces* file) (BR2_ROOTFS_POST_BUILD_SCRIPT)
      - Create a package in Buildroot and enable it in the custom config
      - Store the custom configuration file to ``configs/``


# TODO lsp
* http server and request reply protocol
* Small init system, including SIGCHLD to SIGIGN


# TODO iot
* Small chat server and client using zmq
* Program design (event loop, MP, ...)
* Small user space sensor driver over (I2C or SPI)
  * https://www.kernel.org/doc/Documentation/i2c/dev-interface
  * https://www.ctrlinux.com/blog/?p=12
  * https://xgoat.com/wp/2007/11/11/using-i2c-from-userspace-in-linux/
* CAN socket interface
* Embedded System components:
  * PSU, CPU board, IO ports, HMI
  * schematics
  * diagnostics (logs)
  * connection backend
  * use cases
* Messaging:
  * concepts (push/pull, pub/sub, req/rep)
  * protocols (REST + JSON, ZMTP, NATS, COAP + CBOR, ...)
  * libraries (libzmq, NATS, ...)
  * architecture: message driven micro services
* Use cases:
  * factory sensor units + iot gateway
  * public transport ticketing system -> distributed truck management system
* Final lab: Data Logger + reporting + Redis + PUB client
  - data collection app, interface with db, maybe via separate process using uds
  - Assignment
    -  Main context: create a sensor data collection application
    -  Data management and storage back-end (rw files)
    -  Virtual sensor input over pipe/socket/...
    -  Interface tcp/ip socket (http get/put)
    - Listen on incoming sockets on specific port
    - Arrangement socket management:
      - Use one child process per accepted socket
      - Use dynamic memory
      - Use the ``epoll()`` system call
    - Capture signal ``SIGTERM`` and ``SIGINT`` to gracefully shutdown the processes
    - Command line parameters (use ``getopt``):
```
-h (show help)
-d (daemonize the process)
-l "path" (full path to the log file, default current working dir)
-p "port" (tcp port number to use, default 5555)
-u "max-nr" (max number of connected users, default 10)
-s (server mode)
-c (client mode)
```
