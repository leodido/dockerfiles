# SphinxSearch
#
# Version 0.2

# ubuntu base image
FROM ubuntu:13.10

MAINTAINER Leonardo Di Donato, leodidonato@gmail.com

RUN uname -m

# make sure the package repository is up to date
#RUN echo "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted" > /etc/apt/sources.list
#RUN apt-get update

# install wget
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget

# install sphinxsearch build dependencies
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y make autoconf automake libtool gcc-4.8 g++-4.8 libmysql++-dev libmysqlclient15-dev unixodbc-dev libpq5
#RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
#RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50

# download libstemmer source and extract it
#RUN wget -O - http://snowball.tartarus.org/dist/libstemmer_c.tgz | tar zx

# download sphinxsearch source and extract it
#RUN wget -O - http://sphinxsearch.com/files/sphinx-2.1.2-release.tar.gz | tar zx

# copy libstemmer inside sphinxsearch source code
#RUN cp -R libstemmer_c/* sphinx-2.1.2-release/libstemmer_c/

# install sphinxsearch
#RUN cd sphinx-2.1.2-release && ./configure --with-libstemmer # --enable-id64
#RUN cd sphinx-2.1.2-release && make -j install && ls -l
# Run make -j2 install

# launch? which configuration file, e.g. -c sphinx.conf ?
# ENTRYPOINT ["searchd", "-c", "sphinx.conf"]

# expose sphinxql port
# EXPOSE 9306

# REMOVE ALL GENERATED DIRECTORIES
