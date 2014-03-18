Docker file for SphinxSearch
============================

A Sphinx Search instance builded from source.

Version: 2.1.6
Support:
 - libstemmer
 - xml (with iconv)
 - postgresql
 - mysql

Exposes ports `9306` and `9312`.

## E.g.

* `docker run leodido/sphinxsearch`

    prints `searchd --help` by default.

* `docker run leodido/sphinxsearch -c mysphinx.conf`

	...

