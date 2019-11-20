Docker Basics
=============


Docker Lingo
------------

* Images
* Containers
* Image layers
* Ephemeral
* Volumes
* Network
* Port forwarding
* Docker files


Simple Demo
-----------

1. Download Ubuntu image:
::

   user@host: docker pull ubuntu:latest

2. List images:
::

   user@host: docker image ls

3. Simple temporary container:
::

   user@host: docker run -ti —rm --name test1 ubuntu:latest /bin/sh

4. List instances:
::

   user@host: docker ps -a

5. Simple daemonized container:
::

   user@host: docker run -d -ti --name test2 ubuntu:latest /bin/sh

6. Attach terminal:
::

   user@host: docker attach test2

7. Stop container:
::

   user@host: docker stop test2

8. Start container:
::

   user@host: docker start test2


Web Server Demo
---------------

1. nginx sample config as http directory listing:
::

   daemon off;
   user nginx;
   worker_processes 1;

   error_log /var/log/nginx/error.log warn;
   pid /var/run/nginx.pid;

   events {
       worker_connections  1024;
   }

   http {
       include /etc/nginx/mime.types;
       default_type application/octet-stream;
       sendfile on;
       keepalive_timeout  65;

       server {
           listen 80;
           location / {
                   root /usr/share/nginx/data;
                   autoindex on;
           }
       }
   }



2. Dockerfile: ubuntu + nginx + default config file
::

   # base container image
   FROM ubuntu:18.04

   # install packages
   RUN export DEBIAN_FRONTEND=noninteractive && \
       apt update --fix-missing && apt upgrade -y && \
       apt install -y sudo locales nginx

   # generate locale
   RUN locale-gen en_US.UTF-8 && locale-gen --no-purge --lang en_US.UTF-8

   # create a nginx user
   RUN useradd -M --home /nonexistent --shell /usr/sbin/nologin nginx

   # set default configuration
   COPY nginx.conf /etc/nginx/nginx.conf

   # default command at startup is nginx daemon
   ENTRYPOINT [ "nginx" ]


3. Build container image from Dockerfile:
::

   user@host: docker build -t nginx-http-share .


4. Start web server service:
::

   user@host: docker run --rm -ti -p 80:80 \
              -v </full/path/to/share/>:/usr/share/nginx/data nginx-http-share

5. The web server is accessible on localhost port 80


References
----------

* https://docs.docker.com/reference/
* https://www.youtube.com/watch?v=UV3cw4QLJLs (watch at 1.5x speed)
* http://takacsmark.com/getting-started-with-docker-in-your-project-step-by-step-tutorial/
* https://www.youtube.com/watch?v=6Er8MAvTWlI
* https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/
* https://12factor.net/processes https://docs.docker.com/engine/tutorials/dockervolumes/
* https://deis.com/blog/2016/docker-storage-introduction/
* https://learning-continuous-deployment.github.io/docker/container/volumes/2015/05/22/persistent-data-with-docker/
* https://github.com/wsargent/docker-cheat-sheet
* https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/
