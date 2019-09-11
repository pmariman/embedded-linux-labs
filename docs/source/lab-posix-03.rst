Event Loop
==========


Concepts
--------

* Event loops
* Asynchronous event handling
* File descriptor based IO multiplexing


Assignment
----------

* Create an **event loop** module implementation
* Use the ``epoll`` system call
* Make a generic implementation with user callback and data pointer
* Create a header file for reuse in other programs


Module API
----------

.. code-block:: c

   #ifndef EVLOOP_HDR
   #define EVLOOP_HDR

   #define EVLOOP_POLL_READ      0x01
   #define EVLOOP_POLL_WRITE     0x02
   #define EVLOOP_POLL_HUP       0x04
   #define EVLOOP_POLL_POLLPRI   0x08

   struct evloop_ctx;
   struct evloop_event;

   typedef void(*evloop_fd_cb)(int fd, short revents, void *data);

   // creates a new event loop context
   int evloop_create(struct evloop_ctx **ctx);
   // starts the event loop context, running a continuous loop inside
   int evloop_run(struct evloop_ctx *ctx);
   // pause the event loop
   int evloop_halt(struct evloop_ctx *ctx);
   // clean up and remove the event loop context
   int evloop_destroy(struct evloop_ctx *ctx);

   // create a fd event and add it to the evloop context ctx
   int evloop_event_add_fd(struct evloop_ctx *ctx, struct evloop_event **ev, int fd,
                           int events, evloop_cb cb, void *data);
   // clean up and remove the event
   int evloop_event_remove(struct evloop_event *ev);

   #endif


Example
-------

.. code-block:: c

   #include "evloop.h"
   #include "nsock.h"

   void socket_cb(int fd, short revents, void *data)
   {
           int ret = 0;
           char buf[1024] = "";
           char reply[1024] = "";

           ret = nsock_read(fd, buf, 1024);
           // ...

           // process and build reply

           ret = nsock_write(fd, reply, strlen(reply));
           // ...

           return;
   }

   int main(int argc, char **argv)
   {
           int ret = 0;
           int sfd = -1;
           struct evloop_ctx *evlctx = NULL;
           struct evloop_event *sev = NULL;

           sfd = nsock_open("192.168.1.100", 5555);
           // ...

           ret = evloop_create(&evlctx);
           // ...

           ret = evloop_event_add(evlctx, &sev, sfd, EVLOOP_POLL_READ, socket_cb, NULL);
           // ...

           return evloop_run(evlctx);
   }


Questions
---------

* What open source libraries exist that provide event loop features?
* How to add support for timers in the API?
* How to add support for signals in the API?
