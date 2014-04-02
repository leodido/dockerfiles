Docker file for Sphinx Search
=============================

A Sphinx Search instance builded from source.

Version: 2.1.6.

Support:
 - libstemmer
 - xml (with iconv)
 - postgresql
 - mysql

## Exposed ports

* `9306`

## Mount points

* `/var/spx/sphinx`
* `/var/log/sphinx`
* `/var/lib/sphinx`
* `/var/run/sphinx`

## Usage example

Assume that your Sphinx Search configuration file (e.g., `sphinx.conf`) is in your current directory (i.e., `$PWD`).

So first of all we have to share the content of `$PWD` with the container (see option `-v`).

We also want to expose port 9306 so we set option `-p`.

So the command to run a daemonized (see option `-d`) instance of this container is:

```
docker run -i -t -v $PWD:/usr/local/etc -p 9306 -d leodido/sphinxsearch
```

Now, verify that it is running ...

```
docker ps
```

```
CONTAINER ID        IMAGE                         COMMAND                CREATED             STATUS              PORTS                     NAMES
43b651892dab        leodido/sphinxsearch:latest   /usr/bin/supervisord   3 seconds ago       Up 3 seconds        0.0.0.0:49174->9306/tcp   ecstatic_brown
```

Eventually try to connect to it. E.g.,

```
mysql -h 0.0.0.0 -P 49174
```
