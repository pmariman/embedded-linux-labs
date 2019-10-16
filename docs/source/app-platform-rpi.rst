SBC - Raspberry Pi 3
====================


Specs
-----

* Broadcom BCM2837 1.2 GHz 64bit SoC
* Quad-core ARM Cortex A53 (ARMv8) cluster
* 1GB RAM LPDDR2 (900 MHz)
* Broadcom VideoCore IV GPU
* BCM43438 wireless LAN and Bluetooth Low Energy (BLE) on board
* 40-pin extended GPIO
* 4 USB 2 ports
* Full size HDMI
* Micro SD port


Pin Header
----------

====================== ======= ======= ============
**Function**           **Pin** **Pin** **Function**
---------------------- ------- ------- ------------
3.3V                   1       2       5V
GPIO02 (SDA1)          3       4       5V
GPIO03 (SCL1)          5       6       Ground
GPIO04 (GPIO_GCLK)     7       8       (TXD0) GPIO14
Ground                 9       10      (RXD0) GPIO15
GPIO17 (GPIO_GEN0)     11      12      (GPIO_GEN1) GPIO18
GPIO27 (GPIO_GEN2)     13      14      Ground
GPIO22 (GPIO_GEN3)     15      16      (GPIO_GEN4) GPIO23
3.3V                   17      18      (GPIO_GEN5) GPIO24
GPIO10 (SPI_MOSI)      19      20      Ground
GPIO09 (SPI_MISO)      21      22      (GPIO_GEN5) GPIO25
GPIO11 (SPI_CLK)       23      24      (SPI_CE0_N) GPIO08
Ground                 25      26      (SPI_CE1_N) GPIO07
ID_SD (I2C ID EEPROM)  27      28      (I2C ID EEPROM) ID_SC
GPIO05                 29      30      Ground
GPIO06                 31      32      GPIO12
GPIO13                 33      34      Ground
GPIO19                 35      36      GPIO16
GPIO26                 37      38      GPIO20
Ground                 39      40      GPIO21
====================== ======= ======= ============


Serial Line
-----------

* TXD pin 8
* RXD pin 10
* Ground pin 6
* The default Linux UART serial line parameters:

  - Baudrate 115200
  - Databits 8
  - No parity bit
  - Stopbit 1


Broadcom Raspberry Pi Bootloader
--------------------------------

* Proprietary bootloader from Broadcom (BCM) https://github.com/raspberrypi/firmware
* This repository contains:

  - Pre-compiled binaries Raspberry Pi kernel and modules
  - Userspace libraries
  - Bootloader/GPU firmware


* The bootloader resides in the ``/boot`` directory
* Bootloader sequence consists of 3 stages:

  - 1st stage: executed from code in ROM, loads 2nd stage in L2 cache memory from SD card
  - 2nd stage: executed from L2 cache, initializes RAM, loads 3rd stage (= GPU firmware) in RAM from SD card
  - 3rd stage: executed from RAM, loads kernel image and device tree blob from SD card


Bootloader stages
^^^^^^^^^^^^^^^^^

* 1st stage bootloader

  - Located in ROM on the SoC, not reprogrammable
  - Executed in small RISC core on the GPU
  - Mounts the 1st partition of the SD card
  - Partition must be **FAT32** or **FAT16** formatted
  - SD card is mandatory, but advantage is that board cannot be bricked
  - Then loads 2nd stage bootloader **bootcode.bin** in L2 cache memory


* 2nd stage bootloader (**bootcode.bin**)

  - Loaded from SD card's 1st partition
  - Loaded into L2 cache from GPU
  - Initializes SDRAM
  - Retrieves GPU firmware **start.elf** from 1st partition of the SD card
  - Programs the firmware and starts execution


* 3rd stage bootloader (**start.elf**)

  - Includes GPU firmware (remains in RAM after booting kernel)
  - Loaded from SD card's 1st partition
  - Parses configuration (**config.txt**)
  - Uses **fixup.dat** to configure SDRAM partition between GPU and CPU
  - Load **kernel.img** (default) and device tree blob into memory
  - Copy **cmdline.txt** content into memory
  - Starts up ARM CPU by releasing reset and kernel starts booting


* Conclusion: relevant files:

  - bootcode.bin
  - fixup.dat
  - start.elf
  - config.txt
  - cmdline.txt


Configuration
^^^^^^^^^^^^^

* https://www.raspberrypi.org/documentation/configuration/config-txt/
* http://elinux.org/RPiconfig
* Example configuration:

::

   user@host: cat config.txt
   kernel=kernel.img-4.9.x-armv7a
   initramfs initrd.img-4.9.x-armv7a
   enable_uart=1
   dtparam=i2c_arm=on
   disable_splash


* Example kernel command line:

::

   user@host: cat cmdline.txt
   dwc_otg.lpm_enable=0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200
   console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=noop rootwait
   rw smsc95xx.macaddr=b8:27:eb:57:c8:42


Comparison to U-Boot Bootloader
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* U-Boot has more extended configuration (scripted)
* U-Boot has more advanced features (NFS boot, ...)


Links
^^^^^

* Product page: https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/
* Raspbian: https://www.raspberrypi.org/downloads/raspbian/
* eLinux: http://elinux.org/RPi_Hub
