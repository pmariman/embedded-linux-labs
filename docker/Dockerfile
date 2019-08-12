# base container image
FROM ubuntu:18.04

# description labels
LABEL maintainer="Philippe Mariman <pmariman@nalys-group.com>"
LABEL buildenv="python-sphinx"

# install packages for development
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update --fix-missing && apt-get upgrade -y && \
        apt-get install -y sudo locales wget make build-essential python3 python3-pip

# generate locale
RUN locale-gen en_US.UTF-8 && locale-gen --no-purge --lang en_US.UTF-8

# create a dev user
RUN useradd -m dev && adduser dev sudo && (echo 'dev:dev' | chpasswd)

# set TERM variable to fix ncurses flickering
ENV TERM=xterm-color

# install python stuff
RUN pip3 install sphinx sphinx-rtd-theme

# set start user and workdir
USER dev
WORKDIR /home/dev

# default command at startup is bash shell
CMD /bin/bash
