HTTP Server Module
==================


References
----------

* `https://en.wikipedia.org/wiki/Request–response <https://en.wikipedia.org/wiki/Request–response>`_
* https://github.com/nodejs/http-parser
* ...


Concept: M2M and Messaging Patterns
-----------------------------------

* **M2M**: machine-to-machine communication
* Machine can be anything: sensors, lights, refrigerators, cars, manufacturing robots, irrigation systems, ...
* Need for an infrastructure that connects components and services, ideally in a loosely coupled manner in order to maximize scalability
* **Messaging pattern:** a network-oriented architectural pattern which describes how two different parts of a 
  message passing system communicate with each other
* For example: HTTP GET, ... TODO
* To implement a messaging pattern and perform machine-to-machine communication, an application protocol is used
* The application protocol is usually implemented in user space on top of an in kernel transport mechanism 
  (TCP, UDP, Unix Domain Socket, serial line, wireless link, ...)
* Application protocol definition and encapsulation (example UDP):


Concept: Request/reply messaging pattern
----------------------------------------

* Aka REQREP, Request/response
* Messaging pattern that allows ...
* Form of asynchronous client-to-service or service-to-service communication that enables event-driven architectures
* Allows decoupling of applications into smaller, independent building blocks
* This increases performance, reliability and scalability
* In most cases, a client needs a separate connection needs to be established to every publisher
* ... TODO



Assignment
----------

* Create a **HTTP server** module
* Use raw POSIX sockets
* Use an open source HTTP parser
* Create a header file for reuse in other programs


Module API
----------

TODO


Hints
-----

* Use an event loop (or poll mechanism) for handling the socket file descriptors


Questions
---------

* What are the most popular REQREP (or messaging in general) protocols?
