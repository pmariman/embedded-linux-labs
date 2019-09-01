Analyse and Explore a Linux System
==================================


References
----------

* ``man`` pages


Goals
-----

* Analyse a Linux system in detail
* Understand important concepts regarding Linux


Steps
-----

1. Check which ``tty`` the serial port is connected to::

      user@host: ps -ef | grep tty

2. Check the partition table, their usage and which type of file systems are used::

      user@host: fdisk -l /dev/sda

  or::

      user@host: lsblk /dev/sda

3. Check which file systems are mounted::

      user@host: mount

  or::

      user@host: lsblk -f /dev/sda


4. Determine the details of the CPU::

      user@host: cat /proc/cpuinfo

5. Determine the details of the memory::

      user@host: cat /proc/meminfo

6. Determine which kernel modules are loaded::

      user@host: lsmod

7. Determine available network interfaces::

      user@host: ip l


Important Concepts
------------------

Serial port
  A UART or RS232 port available to the system which can provide a console/terminal. No need for screen and keyboard
  for basic terminal support like on desktop systems.

Partition table
  Sector on storage medium that describes the physical partioning of the storage memory. Most common schemes are
  *Master Boot Record (MBR)* and *GUID Partition Table (GPT)*.

File system
  Method that controls how data (files, directories, metadata) is stored and retrieved. It manages the storage memory.
  Most common file systems are *fat* and *ext4*.

Bootloader
  Usually collection of software pieces that bootstrap a system. Its most important objective is to load the OS kernel
  into main memory.

Kernel
  Core of the OS which controls and manages everything (hardware, users, processes, protocols, ...). It provides an
  interface to user processes to access resources.

Kernel module
  Dynamically loadable object file that can extend the functionality of the running kernel. Modules can implement any
  feature from device drivers to filesystems to protocols.

Device tree
  A data structure that describes the hardware details of a platform. Loaded and used by the kernel to manage those
  components (CPU, RAM, IO buses, peripherals, ...).

Root file system
  The file system where the root directory is located. Contains user space programs, kernel modules to be loaded
  dynamically, mount points for other file systems, ...

Init system
  The kernel will start only 1 user process at the end of its own initialization. This process is responsible to
  bootstrap the rest of user space.
