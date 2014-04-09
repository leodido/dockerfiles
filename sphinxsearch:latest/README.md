Docker file for Sphinx Search [![Analytics](https://ga-beacon.appspot.com/UA-49657176-1/dockerfiles/sphinxsearch:latest)](https://github.com/igrigorik/ga-beacon)
============================================

Version: **2.1.7** (corresponding to **latest** tag)

A Sphinx Search instance builded from source.

## Content

Supports:
 - libstemmer
 - xml (with iconv)
 - postgresql
 - mysql
 - odbc

### Exposed ports

* `9306` aimed to SQL connections
* `9312` aimed to client connections

### Mount points

* `/var/spx/sphinx`
* `/var/log/sphinx`
* `/var/lib/sphinx`
* `/var/run/sphinx`

### Scripts

* [searchd.sh](#searchd.sh), to start `searchd` in the foreground (needed also for real-time indexes)
* [indexall.sh](#indexall.sh), to index all the plain indexes (i.e., `indexer --all`) defined in the shared Sphinx Search configuration

## Usage

The simplest usage case is to start a Sphinx Search container, attach to it and do whatever you want inside it:

```
docker run -i -t leodido/sphinxsearch /bin/bash
```

```
root@ab2589:/
```

### Daemonized usage (1)

Assume now hat we want to index our documents into some real-time indexes.

Given a Sphinx Search configuration file (e.g., `sphinx.conf`) in our current directory (i.e., `$PWD`), we have to share the content of `$PWD` with the container (using docker option `-v`).

We also want to expose port 9306 (see option `-p`) to query Sphinx Search from the host machine.

So, the command to run a daemonized (see option `-d`) instance of this container is:

```
docker run -i -t -v $PWD:/usr/local/etc -p 9306 -d leodido/sphinxsearch ./searchd.sh
```

Now, verify that it is running ...

```
docker ps
```

```
CONTAINER ID     IMAGE                   COMMAND                CREATED            STATUS             PORTS                     NAMES
43b651892dab     leodido/sphinxsearch    /usr/bin/supervisord   3 seconds ago      Up 3 seconds       0.0.0.0:49175->9306/tcp   jolly_brown
```

And eventually try to connect to it:

```
mysql -h 0.0.0.0 -P 49174
```

We can now index document into our Sphinx Search container or perform queries against it.

### Daemonized usage (2)

Assume that we want to index our documents into some plain indexes.

We need:

1. the source files (e.g. XML files structured as demanded by the Sphinx Search's xmlpipe2 driver)

2. a valid Sphinx Search configuration file that defines our plain indexes and their sources

3. a way to querying Sphinx Search from the host machine (e.g., using IP `127.0.0.1` and port `9306`)

So, assuming that in our current directory (i.e., `$PWD`) we have these files, we run a daemonized instance of Sphinx Search as follow:

```
docker run -i -t -v $PWD:/usr/local/etc -p 127.0.0.1:9306:9306 -d leodido/sphinxsearch ./indexall.sh
```

This way we have indexed our documents (i.e., with `index --all`) and started serving queries through `searchd`.

Again, if you want to query from the host machine:

```
mysql -h 127.0.0.1 -P 9306
```

---

**ENJOY IT**.
