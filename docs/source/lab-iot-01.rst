Digital Input Counter
=====================


Concepts
--------

* Digital inputs and conversions
* Linux kernel GPIO interface
* Reporting data in JSON format
* TLV (Type-Length-Value) protocol


Assignment
----------

* Main context: create an application that counts the pulses on a digital input pin
* Configure a digital pin as input and apply test pulses to this pin
* Periodically write the count values to a report file
* Set up a TCP server socket on port for user connections to get counter report values
* All report values shall be JSON encoded
* Provide command line arguments to set digital pin, TCP port number, loglevel, ...


Hints
-----

* Set up the input pin for reading inside a ``epoll()`` loop using the ``POLLPRI`` event flag
* Suggested JSON report format:

::

    {
        "timestamp" : "2017/10/18 14:40:35",
        "pin-id" : "/sys/class/gpio/gpio20/value",
        "count" : 511
    }

* An other digital (gpio) pin can be configured as output and used in a test script as pulse input
* Suggested help message for program:

::

    counter: counts the pulses on a digital input
        -h                  Show help
        -l "level"          Log level to be used (console and file logging)
        -i "id"             Identifier for digital input
        -t "period"         Interval to make a counter report in seconds
        -r "path"           Full path to the report file, default current directory
        -p "port"           TCP port number to use, default 5555
        -u "max-nr"         Max number of connected users, default 10

* Capture signal ``SIGTERM`` and ``SIGINT`` to gracefully shutdown the process
* Use a small TLV-like protocol to report the counter values over TCP socket


Legacy Linux GPIO interface
---------------------------

* To use a GPIO pin, it must first be exported:

::

    # echo XY > /sys/class/gpio/export      # with XY the desired pin number

* The pin number can be calculated from the pin bank name and number:

::

    (position_bank_letter_in_alphabet - 1) * 32 + pin_number

* For example:

::

    PA17: (1 - 1) * 32 + 17 =   0 + 17 = 17
    PH18: (8 - 1) * 32 + 18 = 224 + 18 = 242

* The IO direction must be set on the pin:

  * **WARNING:** the default direction is *in*, but set it explicitly!

::

    # echo in  > /sys/class/gpio/gpio23/direction
    # echo out > /sys/class/gpio/gpio24/direction

* The value of the GPIO pin can be read (input) or be written (output):

::

    # cat /sys/class/gpio/gpio23/value
    # echo 1 > /sys/class/gpio/gpio24/value


New Linux GPIO interface
------------------------

* In kernel 4.8, a new GPIO API interface was released
* Check the kernel source: ``tools/gpio/*``
* https://kernel-recipes.org/en/2018/talks/new-gpio-interface-for-user-space/


Questions
---------

* A digital input signal can bounce on transition (e.g. mechanical relay), how to debounce such a signal in software?
* What are possible digital input isolation techniques?
* Why use a TLV-like protocol over a TCP connection?


Assignments (optional)
----------------------

* Provide an ``evloop`` API extension for signals
* Provide an ``evloop`` API extension for timers
* Provide an ``evloop`` API extension for simple sockets
* Use the new kernel GPIO interface
