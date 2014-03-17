# SphinxSearch
#
# Version 1

# ubuntu base image
FROM ubuntu

MANTAINER Leonardo Di Donato, leodidonato@gmail.com

# download libstemmer source and extract it
RUN wget http://snowball.tartarus.org/dist/libstemmer_c.tgz | tar -xzf

# download sphinxsearch source and extract it
RUN wget http://sphinxsearch.com/files/sphinx-2.1.2-release.tar.gz | tar -xzf

# copy libstemmer inside sphinxsearch source code
RUN cp -R libstemmer_c/* sphinx-2.1.2-release/libstemmer_c/

# install sphinxsearch
RUN cd sphinx-2.1.2-release/
RUN ./configure --with-libstemmer
RUN make
RUN make install


