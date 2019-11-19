Hardware Selection
==================


Overview Single Board Computers (SBC)
-------------------------------------


Questions per platform
~~~~~~~~~~~~~~~~~~~~~~

* mainline kernel support
* mainline uboot support
* serial console interface support
* video/audio optional
* CAN nice to have
* rpi header support
* multiple boot modes



Raspberry Pi 3 B+
~~~~~~~~~~~~~~~~~
* https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/
* SoC: Broadcom BCM2710
* pro:

  - already in use in current labs
  - community

* con:

  - no mainline kernel
  - proprietary boot loader
  - old(er) technologies (GPU is main chip)
  - hobby attitude

* price: 35 euro


Beagle Bone Green
~~~~~~~~~~~~~~~~~
* https://beagleboard.org/green
* http://wiki.seeedstudio.com/BeagleBone_Green/
* SoC: TI AM335x
* pro:

  - based on Beagle Bone Black
  - community support
  - mainline kernel
  - mainline uboot
  - on board eMMC

* con:

  - price vs performance

- price: 40 euro


ROC-RK3328-CC
~~~~~~~~~~~~~
* http://en.t-firefly.com/product/rocrk3328cc
* Soc: Rockchip RK3328
* pro:

  - mainline kernel (from 4.17)
  - mainline uboot
  - rpi compatible (full)
  - new(er) technologies

* con:

  - TBD

* price: 35 euro


AML-S905X-CC (Le Potato)
~~~~~~~~~~~~~~~~~~~~~~~~
* https://libre.computer/products/boards/aml-s905x-cc/
* Soc: Amlogic S905X SoC
* pro:

  - mainline kernel
  - mainline uboot
  - rpi compatible (full)
  - community (http://linux-meson.com/doku.php)

* con:

  - TBD

* price: 32 euro


ALL-H3-CC (Tritium)
~~~~~~~~~~~~~~~~~~~
* https://libre.computer/products/boards/all-h3-cc/
* SoC: Allwinner Hx
* not released yet (!)
* price: 25 euro


BPI-M2+
~~~~~~~
* http://www.banana-pi.org/m2plus.html
* https://linux-sunxi.org/Sinovoip_Banana_Pi_M2%2B
* SoC: Allwinner H3
* pro:

  - mainline kernel
  - mainline uboot
  - EDU version without eMMC and wireless
  - rpi compatible (40 pin header)
  - USB OTG port
  - FEL mode (multiple boot modes)

* con:

  - power supply through barrel jack

* price: 28 euro, 25 euro (EDU)


PINE A64-LTS
~~~~~~~~~~~~
* https://www.pine64.org/?product=pine-a64-lts
* http://linux-sunxi.org/Pine64
* SoC: Allwinner R18 (A64)
* also available as SOM + baseboard (!)

  - https://www.pine64.org/?product=sopine-a64-baseboard-combo

* pro:

  - mainline kernel
  - mainline uboot
  - rpi compatible (40 pin header)
  - no wireless by default
  - multiple IO (eMMC, GPIO, ...)
  - FEL mode (multiple boot modes)

* con:

  - extensive kernel support (?)

* price: 32 euro


Toradex Colibri iMX7
~~~~~~~~~~~~~~~~~~~~
* https://www.toradex.com/computer-on-modules/colibri-arm-family/nxp-freescale-imx7
* Soc: iMX7
* pro:

  - no video/audio interfaces
  - CAN available
  - multiple carrier boards
  - professional industrial SoC

* con:

  - price
  - community support

* base boards:

  - https://www.toradex.com/products/carrier-board/viola-carrier-board (21 euro)
  - https://www.toradex.com/products/carrier-boards/aster-carrier-board (52 euro)

* price: +/- 70 euro (without base board)


Allwinner Extra Links
~~~~~~~~~~~~~~~~~~~~~
* https://linux-sunxi.org/Linux_mainlining_effort#Work_In_Progress
* https://linux-sunxi.org/FEL
* https://linux-sunxi.org/FEL/USBBoot


Network Labs Hardware
---------------------
* https://omnia.turris.cz/en/
* https://www.pcengines.ch/apu2.htm
* https://protectli.com/6-port/
* https://asrock.com/ipc/overview.asp?Model=NAS-9601
* https://asrock.com/ipc/overview.asp?Model=NAS-9602
* http://linuxgizmos.com/compact-six-port-net-appliance-features-dual-bypass-pairs/
* http://linuxgizmos.com/atom-c3000-based-net-appliance-targets-5g-vcpe-gear/
* http://linuxgizmos.com/atom-c3000-based-net-appliance-offers-eight-lan-ports/
