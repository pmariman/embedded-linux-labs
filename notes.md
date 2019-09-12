## Lab Template
* Goal
* External literature / references
* Steps / implementation
* Assignments
* Questions
* Cool tricks
* Best Practices

## TODO embedded linux
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
* http server
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
