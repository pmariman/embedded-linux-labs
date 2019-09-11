Docker for Buildroot Development
================================


Dockerfile
----------

.. literalinclude:: Dockerfile.brdev


Container Commands
------------------

1. Create container image:
::

   user@host: docker build -t brdev .

2. Launch a persistant container for Buildroot development (``brdev``):
::

   user@host: docker run -ti -v ${HOME}/dockershare/:/home/dev/share/ \
                      --name brdev brdev
