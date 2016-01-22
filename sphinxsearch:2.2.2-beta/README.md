Sphinx Search docker file
=========================

Version: **2.2.2-beta**

You can read [the official changelog](http://sphinxsearch.com/bugs/changelog_page.php) the official changelog for details on changes.

## Content

A Sphinx Search instance builded from source.

Supports:

- stemming (via libstemmer, [link](http://snowball.tartarus.org/download.php))

- xml (with expat and iconv)

- postgresql

- mysql

- odbc

- regular expression filter (via RE2 engine, version 2015-11-01, [link](https://github.com/google/re2))

- lemmatization

    - `/var/diz/sphinx/ru.pak` (russian dict)
    - `/var/diz/sphinx/en.pak` (english dict)
    - `/var/diz/sphinx/de.pak` (deutsch dict)

### Exposed ports

* `9312` for client connections

* `9306` for SQL connections

### Mount points

This image provides some directories for configurations, logs and other files:

* `/var/idx/sphinx`

* `/var/log/sphinx`

* `/var/lib/sphinx`

* `/var/run/sphinx`

* `/var/diz/sphinx`

All this directories are **data volumes**.

### Scripts

The available scripts are:

* `searchd.sh`, to start `searchd` in the foreground (needed also for real-time indexes)
* `indexall.sh`, to index all the plain indexes (i.e., `indexer --all`) defined in the configuration

## Path

Both scripts and Sphinx Search's tools (e.g., the `spelldump` tool) are available from the PATH.

To list all Sphinx Search's tool you can execute:

```
docker run -it leodido/sphinxsearch:2.2.2-beta ls /usr/local/bin
# indexer  indextool  searchd  spelldump	wordbreaker
```

## Installation

You can clone this repository and manually build it.

```
cd dockerfiles/sphinxsearch\:2.2.2-beta
docker build -t leodido/sphinxsearch:2.2.2-beta .
```

Otherwise you can pull this image from docker index.

```
docker pull leodido/sphinxsearch:2.2.2-beta
```

## Usage

The simplest use case is to start a Sphinx Search container, attach to it and do whatever you want with it:

```
docker run -i -t leodido/sphinxsearch:2.2.2-beta /bin/bash
```

### Daemonized usage (1)

Assume that we want to index our documents into some real-time indexes.

Given a Sphinx Search configuration file (e.g., `sphinx.conf`) in our current directory (i.e., `$PWD`), we have to share its content with the container using docker option `-v`.

We also want to link to exposed `9306` port to query Sphinx Search from the host machine.

So, the command to run a **daemonized instance** of this container is:

```
SS=$(docker run -i -t -v $PWD:/usr/local/etc -p 9306 -d leodido/sphinxsearch:2.2.2-beta searchd.sh)
```

Now we want to see to which host address it has been linked:

```
docker port $SS 9306 # which returns 49174
```

And eventually try to connect to it:

```
mysql -h 0.0.0.0 -P 49174
```

We can now index documents into our Sphinx Search container or perform queries against it.

### Daemonized usage (2)

Assume that we want to index our documents into some plain indexes.

We need:

1. the data source files (e.g. XML files structured as demanded by the Sphinx Search's xmlpipe2 driver)

2. a valid Sphinx Search configuration file that defines our plain indexes and their sources

3. a way to querying Sphinx Search from the host machine (e.g., using IP `127.0.0.1` and port `9306`)

So, assuming that in our current directory (i.e., `$PWD`) we have these files, we run a daemonized instance of Sphinx Search as follow:

```
docker run -i -t -v $PWD:/usr/local/etc -p 127.0.0.1:9306:9306 -d leodido/sphinxsearch:2.2.2-beta indexall.sh
```

This way we have indexed our documents and started serving queries.

Again, if you want to query from the host machine:

```
mysql -h 127.0.0.1 -P 9306
```

---

[![Analytics](https://ga-beacon.appspot.com/UA-49657176-1/dockerfiles/sphinxsearch:2.2.2-beta)](https://github.com/igrigorik/ga-beacon)
