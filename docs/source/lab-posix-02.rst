Timerwheel Module
=================


Concepts
--------

* A **timerwheel** is a data structure to organize multiple user timers based on a single core timer tick
* Used in both OS kernels and user space frameworks
* It can support a large number of user timers


Assignment
----------

* Create a timer module, providing the ability to call a user callback upon timer expiration
* Use a hashed timerwheel and a linked list for every hash node
* Use a single POSIX timer a timer tick
* Make a generic implementation with user callback and data pointer
* Create a header file for reuse in other programs


Module API
----------

.. code-block:: c

   #ifndef TIMERWHEEL_HDR
   #define TIMERWHEEL_HDR

   #define TIMER_STOP              0x00
   #define TIMER_SINGLE_SHOT       0x01
   #define TIMER_INTERVAL          0x02
   #define TIMER_AUTO_DEL          0x04

   struct timerwheel_ctx;
   struct timerwheel_node;

   typedef void (*timer_cb)(struct timerwheel_node *node, void *data);

   int timerwheel_init(struct timerwheel_ctx **wheel, int tick_period, int wheel_len);
   int timerwheel_get_fd(struct timerwheel_ctx *wheel);
   int timerwheel_start(struct timerwheel_ctx *wheel);
   int timerwheel_tick(struct timerwheel_ctx *wheel);

   int timerwheel_node_create(struct timerwheel_ctx *wheel,
                                   struct timerwheel_node **handle);
   int timerwheel_node_init(struct timerwheel_node *handle, timer_cb funcp, void *data);
   int timerwheel_node_reschedule(struct timerwheel_node *handle, int period, int mode);
   int timerwheel_node_remove(struct timerwheel_node *handle);

   #endif


Hints
-----

* Use the following structures as internal main context and node context:


.. code-block:: c

  // main wheel control structure
  struct timerwheel_ctx {
          int fd;                         // timer file descriptor
          int len;                        // length of the wheel
          int tick_period;                // timer tick period in ms
          int current_slot;               // current timer slot
          struct list_node slots[];       // placeholder for variable array
  };

  // individual timer node structure
  struct timerwheel_node {
          int expire;                     // number of ticks
          int mode;                       // singleshot, interval, auto-delete
          int period;                     // node in ms
          void *data;                     // user context to pass to callback
          timer_cb callback;              // user callback to call at expiration
          struct timerwheel_ctx *wheel;   // pointer to parent context
          struct list_node el;
  };


Questions
---------

* Where is this data structure used in Linux?
* What are the benefits of using such a data structure for timers?
* What other data structures exist for implementing timers? With or without timer tick?
