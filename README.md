Docker file for Sphinx Search
=============================

A Sphinx Search instance builded from source.

Version: 2.1.6.

Support:
 - libstemmer
 - xml (with iconv)
 - postgresql
 - mysql

Exposes ports `9306` and `9312`.

## Usage example

```
SPH=$(docker run \
    -i -t -d -p 9306 \
    -v /var/log/sphinx -v /var/lib/sphinx -v /var/run/sphinx -v $PWD/tests/sphinx:/etc/sphinx \
    leodido/sphinxsearch \
    /bin/sh)

docker attach $SPH
searchd -c /etc/sphinx/sphinx.conf
exit
docker start $SPH
```
