Sphinx Search docker image [![Analytics](https://ga-beacon.appspot.com/UA-49657176-1/dockerfiles/sphinxsearch:latest)](https://github.com/igrigorik/ga-beacon)
============================================

Version: **2.1.7**

## Content

A Sphinx Search instance builded from source.

Supports:

- libstemmer

- xml (with iconv)

- postgresql

- mysql

- odbc

### Exposed ports

* `9306` for SQL connections

* `9312` for client connections

### Mount points

This image provides some directories for your configurations:

* `/var/spx/sphinx`

* `/var/log/sphinx`

* `/var/lib/sphinx`

* `/var/run/sphinx`

### Scripts

* [searchd.sh](#searchd.sh), to start `searchd` in the foreground (needed also for real-time indexes)
* [indexall.sh](#indexall.sh), to index all the plain indexes (i.e., `indexer --all`) defined in the configuration

## Usage

The simplest usage case is to start a Sphinx Search container, attach to it and do whatever you want with it:

```
docker run -i -t leodido/sphinxsearch /bin/bash
```

### Daemonized usage (1)

Assume that we want to index our documents into some real-time indexes.

Given a Sphinx Search configuration file (e.g., `sphinx.conf`) in our current directory (i.e., `$PWD`), we have to share its content with the container using docker option `-v`.

We also want to link to exposed `9306` port to query Sphinx Search from the host machine.

So, the command to run a **daemonized instance** of this container is:

```
SS=$(docker run -i -t -v $PWD:/usr/local/etc -p 9306 -d leodido/sphinxsearch ./searchd.sh)
```

Now we want to see to which host address it has been linked:

```
docker port $SS 9306
```

And eventually try to connect to it:

```
mysql -h 0.0.0.0 -P 49174
```

We can now index documents into our Sphinx Search container or perform queries against it.

### Daemonized usage (2)

Assume that we want to index our documents into some plain indexes.

We need:

1. the [data source](http://sphinxsearch.com/docs/2.1.7/xmlpipe2.html) files (e.g. XML files structured as demanded by the Sphinx Search's xmlpipe2 driver)

2. a valid Sphinx Search configuration file that defines our plain indexes and their sources

3. a way to querying Sphinx Search from the host machine (e.g., using IP `127.0.0.1` and port `9306`)

So, assuming that in our current directory (i.e., `$PWD`) we have these files, we run a daemonized instance of Sphinx Search as follow:

```
docker run -i -t \
		   -v $PWD:/usr/local/etc -p 127.0.0.1:9306:9306 -d \
		   leodido/sphinxsearch ./indexall.sh
```

This way we have indexed our documents and started serving queries.

Again, if you want to query from the host machine:

```
mysql -h 127.0.0.1 -P 9306
```

---

**ENJOY IT**.
