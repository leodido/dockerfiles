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

Assuming that your Sphinx Search configuration file (e.g., `sphinx.conf`) is in your current directory, you can create and run a container with:


```
docker run -i -t -v $PWD:/usr/local/etc -p 9306 leodido/sphinxsearch searchd
```

