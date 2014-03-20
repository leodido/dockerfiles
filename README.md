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

## Usage example

```
docker run -i -t -v $PWD/tests/sphinx:/usr/local/etc -p 9306 leodido/sphinxsearch bash
```
