Cross-Compiling Applications
============================

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------

* Bootlin_ slides, chapter *Cross-Compiling Toolchains*
* Main Buildroot documentation: https://buildroot.uclibc.org/downloads/manual/manual.html


Goals
-----

* Cross-compile an application for the target
* Using the Buildroot cross-compiler and sysroot


Steps
-----

1. Compile a simple C program with the host toolchain, using a Makefile.
2. Adapt the Makefile and compile a simple C program with the toolchain from Buildroot:

::

   user@host: ls -l ${BR_PATH}/output/host/usr/bin

3. Copy the binary to the target and test it (use the simple SD card image from previous lab).


Questions
---------

* Which binaries are present in the toolchain directory?
* Which version of gcc is used?
* Which libc is gcc using?
* Are there other interesting parameters used in the gcc configuration?
* Check the location of the **sysroot**.
* Show that the generated binary is built for the target architecture using ``readelf``:

::

   user@host: readelf -a <binary>
   user@host: readelf -h <binary>
