Docker file for Sphinx Search
=============================

A Sphinx Search instance builded from source.

Version: 2.1.6.

Support:
 - libstemmer
 - xml (with iconv)
 - postgresql
 - mysql

Exposes port `9306`.

## Volumes

* `/var/spx/sphinx`
* `/var/log/sphinx`
* `/var/lib/sphinx`
* `/var/run/sphinx`

## Usage example

Assuming that your Sphinx Search configuration file path is `./tests/sphinx/sphinx.conf` you can create a container with:


```
docker run -i -t -v $PWD/tests/sphinx:/usr/local/etc -p 9306 leodido/sphinxsearch searchd
```

