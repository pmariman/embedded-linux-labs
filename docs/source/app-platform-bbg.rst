SBC - Beagle Bone Green
=======================


Specs
-----

* TI AM335x 1GHz ARM Cortex-A8 SoC
* NEON floating-point accelerator
* 512 MB DDR3 RAM
* 4GB eMMC on-board flash
* Micro SD card slot
* 2x 46-pin IO headers
* 1x RJ45 Ethernet connector
* 1x USB2 port
* 1x micro USB port
* 2x Grove connectors (I2C and UART)


References
----------

* Product page (1): https://beagleboard.org/green
* Product page (2): http://wiki.seeedstudio.com/BeagleBone_Green/
* Debian image (Beagle Bone Black): https://beagleboard.org/latest-images


Serial Line
-----------

* Separate debug (serial) header

======= ============
**Pin** **Function**
------- ------------
1       GND
2       CTS#
3       VCC
4       TXD
5       RXD
6       RTS#
======= ============


* The default Linux UART serial line parameters:

  - Baudrate 115200
  - Databits 8
  - No parity bit
  - Stopbit 1


Interesting Links
-----------------

* http://derekmolloy.ie/beaglebone/
* http://www.bootembedded.com/beagle-bone-black/building-embedded-linux-system-using-mainline-kernel-for-beaglebone-black/
* https://jumpnowtek.com/beaglebone/Beaglebone-Black-U-Boot-Notes.html
* https://wiki.beyondlogic.org/index.php?title=BeagleBoneBlack_Upgrading_uBoot
* https://diydrones.com/profiles/blogs/booting-up-a-beaglebone-black
* https://www.twam.info/hardware/beaglebone-black/u-boot-on-beaglebone-black
* https://www.digikey.com/eewiki/display/linuxonarm/BeagleBone+Black
* https://gist.github.com/vsergeev/2391575
* https://wiki.beyondlogic.org/index.php/BeagleBoneBlack_Building_Kernel
* http://mkaczanowski.com/embedded-development-with-qemu-beagleboard-yocto-angstrom-buildroot-where-to-begin/
* https://www.nexlab.net/product/mosso/
* https://www.youtube.com/watch?v=SaIpz00lE84
* https://elinux.org/BeagleBone_Black_Extracting_eMMC_contents
