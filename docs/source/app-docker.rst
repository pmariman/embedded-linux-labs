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

1. Use **nginx** as webserver:
::

    user@host: docker run -ti --name test3 ubuntu:latest /bin/sh
    root@<docker-id>: apt install nginx

2. Question: how to access webserver? *[TODO]*
::

   user@host: 

3. Dockerfile: ubuntu + nginx *[TODO]*

4. nginx sample config as http directory listing:
::

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

5. Start web server service:
::

   user@host: docker run --rm -ti -v /home/user/nginx.conf:/etc/nginx/nginx.conf -v /home/user/data:/usr/share/nginx/data -p 80:80 nginx


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
