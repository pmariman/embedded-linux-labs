Simple Log Module
=================


Concepts
--------

* Logs don't lie
* Log files are written to ``/var/log/`` or ``/var/log/<application>``, for example:

    - ``/var/log/messages``: generic system activity logs
    - ``/var/log/cron.log``: Crond logs (cron job)
    - ``/var/log/auth.log``: Authentication log
    - ``/var/log/httpd/``: Apache access and error logs directory
    - ...

* Log files and directories are **rotated** to limit the space used by older logs (see ``logrotate``)
* Log messages can be filtered away by implementing a treshold on log (severity) level


Assignment
----------

* By default, log to the connected terminal
* Make functions to open, close, and print to a log file
* Support the *syslog* logging levels
* Write the logs with a timestamp of format **[2017/10/18 14:40:35.666]**
* Provide support for setting a global log treshold
* Create a header file for reuse in other programs
* Use ``snprintf`` and ``vsnsprintf``


Module API
----------

.. code-block:: c

    #ifndef LOG_HDR
    #define LOG_HDR

    // mapping of syslog log levels
    #define LOG_LEVEL_EMERGENCY     0
    #define LOG_LEVEL_ALERT         1
    #define LOG_LEVEL_CRITICAL      2
    #define LOG_LEVEL_ERROR         3
    #define LOG_LEVEL_WARNING       4
    #define LOG_LEVEL_NOTICE        5
    #define LOG_LEVEL_INFO          6
    #define LOG_LEVEL_DEBUG         7

    int log_init(void);
    int log_set_level(int lvl);

    int log_console_println(int lvl, const char *str);
    int log_console_printf(int lvl, const char *fmt, ...);

    int log_file_open(const char *path, int truncate);
    int log_file_close(int fd);
    int log_file_println(int fd, int lvl, const char *str);
    int log_file_printf(int fd, int lvl, const char *fmt, ...);

    #endif


Example Output
--------------

.. code-block:: console

    [2017/10/18 14:40:35.666][INFO     ] HTTP GET /index.html 192.168.157.21
    [2017/10/18 14:40:36.666][INFO     ] HTTP GET /index.html 192.168.157.133
    [2017/10/18 14:40:37.666][ERROR    ] HTTP PUT /upload/badfile.txt 192.168.157.154
    [2017/10/18 14:40:38.666][WARNING  ] HTTP GET /index.php 192.168.157.154 - error 404
    [2017/10/18 14:40:39.666][INFO     ] HTTP GET /index.html 192.168.157.100
    [2017/10/18 14:40:39.666][EMERGENCY] error - out-of-memory, shutting down daemon


Questions
---------

* Why is ``snprintf()`` superior to ``strcpy()`` and ``sprintf()``?


Extension (Optional)
--------------------

* Colorize the outpur on the console regarding the log level (red = error for example)
* The terminal will interpret ANSI control characters as text formatting settings
* It is possible to check if a ``fd`` is a terminal: ``isatty()``
* ANSI terminal control characters:

    .. code-block:: c

        #define ANSI_RESET              "\x1b[0m"
        #define ANSI_BOLD               "\x1b[1m"
        #define ANSI_UNDERLINE          "\x1b[4m"
        #define ANSI_COLOR_TXT_BLACK    "\x1b[30m"
        #define ANSI_COLOR_TXT_RED      "\x1b[31m"
        #define ANSI_COLOR_TXT_GREEN    "\x1b[32m"
        #define ANSI_COLOR_TXT_YELLOW   "\x1b[33m"
        #define ANSI_COLOR_TXT_BLUE     "\x1b[34m"
        #define ANSI_COLOR_TXT_MAGENTA  "\x1b[35m"
        #define ANSI_COLOR_TXT_CYAN     "\x1b[36m"
        #define ANSI_COLOR_TXT_WHITE    "\x1b[37m"
        #define ANSI_COLOR_BKG_BLACK    "\x1b[40m"
        #define ANSI_COLOR_BKG_RED      "\x1b[41m"
        #define ANSI_COLOR_BKG_GREEN    "\x1b[42m"
        #define ANSI_COLOR_BKG_YELLOW   "\x1b[43m"
        #define ANSI_COLOR_BKG_BLUE     "\x1b[44m"
        #define ANSI_COLOR_BKG_MAGENTA  "\x1b[45m"
        #define ANSI_COLOR_BKG_CYAN     "\x1b[46m"
        #define ANSI_COLOR_BKG_WHITE    "\x1b[47m"


* For example: print 'hello world' formatted bold + red:

    .. code-block:: c

        dprintf(STDOUT_FILENO, ANSI_BOLD ANSI_COLOR_TXT_RED);
        dprintf(STDOUT_FILENO, "hello world\n");
        dprintf(STDOUT_FILENO, ANSI_RESET);
