Linux Kernel Modules
====================

.. _Bootlin: https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf


References
----------

* Bootlin_ slides, chapter *Linux kernel introduction*
* Mainline kernel: https://www.kernel.org/
* Kernel documentation on out of tree builds: https://www.kernel.org/doc/Documentation/kbuild/modules.txt
* http://derekmolloy.ie/writing-a-linux-kernel-module-part-1-introduction/


Goals
-----

* Make a simple *out-of-tree kernel module*
* Build the kernel module for a target (e.g. ```qemu```)
* Test the module and module commands on a target


Steps
-----

1. Create a ```hello-module.c``` file containing the following code inside a new directory ``hello-module/``:
::

        #include <linux/init.h>
        #include <linux/module.h>
        #include <linux/kernel.h>

        static int __init hello_init(void)
        {
                printk(KERN_INFO "########################### hello module\n");
                return 0;
        }

        static void __exit hello_exit(void)
        {
                printk(KERN_INFO "########################### goodbye module\n");
        }

        module_init(hello_init);
        module_exit(hello_exit);

        MODULE_LICENSE(“GPL”);
        MODULE_AUTHOR(“foo”);
        MODULE_DESCRIPTION(“a simple hello kernel module”);
        MODULE_VERSION(“0.01”);


2. Create a ```Makefile``` file containing the following code:
::

        obj-m += hello.o

        KBUILD=$(LINUX_PATH)

        all:
                make -C $(KBUILD) M=$(PWD) modules
        install:
                make -C $(KBUILD) M=$(PWD) INSTALL_MOD_PATH=$(STAGING_PATH) modules_install
        clean:
                make -C $(KBUILD) M=$(PWD) clean


3. Build the module:
::

    user@host: make && make install



Assignments
-----------

* Create a root file system containing the module
* Test the module on a target
* List all shell commands that manipulate kernel modules
* Make the module load automatically at boot


Questions
---------

* What are the purpose of kernel modules?
* What well known external kernel modules exist?
* Where are out-of-tree modules installed?
* What are the risks of using/depending on externally maintained kernel modules?
