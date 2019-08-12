#!/bin/sh

docker build -t dev-sphinx docker/

docker run --rm -ti -u dev -v $(pwd):/app -w /app dev-sphinx make -C docs/ html

exit 0
