# Embedded Linux Labs


## Create Build Container

```
$ docker build -t dev-sphinx docker/
```


## Create The Documentation

```
$ docker run --rm -ti -u dev -v $(pwd):/app -w /app dev-sphinx make -C docs/ html
```
