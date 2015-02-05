# Sphinx Search
#
# @version 	2.2.7
# @author 	leodido <leodidonato@gmail.com>
FROM centos:centos6

MAINTAINER Leonardo Di Donato, leodidonato@gmail.com

# add public key
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
# install utils
RUN yum install wget tar -y -q
# install sphinxsearch build dependencies
RUN yum install autoconf automake libtool gcc-c++ -y -q
# install sphinxsearch dependencies for odbc
RUN yum install unixODBC-devel -y -q
# install sphinxsearch dependencies for mysql support
RUN yum install mysql-devel -y -q
# install sphinxsearch dependencies for postgresql supp
RUN yum install postgresql-devel -y -q
# install sphinxsearch dependencies for xml support
RUN yum install expat-devel -y -q
# download libstemmer source and extract it
RUN wget -nv -O - http://snowball.tartarus.org/dist/libstemmer_c.tgz | tar zx
# download re2 source and extract it
RUN wget -nv -O - https://re2.googlecode.com/files/re2-20140304.tgz | tar zx
# download sphinxsearch source and extract it
RUN wget -nv -O - http://sphinxsearch.com/files/sphinx-2.2.7-release.tar.gz | tar zx
# copy libstemmer inside sphinxsearch source code
RUN cp -R libstemmer_c/* sphinx-2.2.7-release/libstemmer_c/
# fix for libstemmer changes
RUN sed -i -e 's/stem_ISO_8859_1_hungarian/stem_ISO_8859_2_hungarian/g' sphinx-2.2.7-release/libstemmer_c/Makefile.in
# copy re2 library inside sphinxsearch source code
RUN cp -R re2/* sphinx-2.2.7-release/libre2/
# compile and install sphinxsearch
RUN cd sphinx-2.2.7-release && ./configure --enable-id64 --with-mysql --with-pgsql --with-libstemmer --with-libexpat --with-iconv --with-unixodbc --with-re2
RUN cd sphinx-2.2.7-release && make
RUN cd sphinx-2.2.7-release && make install
# remove sources
RUN rm -rf sphinx-2.2.7-release/ && rm -rf libstemmer_c/ && rm -rf re2/
# expose ports
EXPOSE 9306 9312
# prepare directories
RUN mkdir -p /var/idx/sphinx
RUN mkdir -p /var/log/sphinx
RUN mkdir -p /var/lib/sphinx 
RUN mkdir -p /var/run/sphinx
RUN mkdir -p /var/diz/sphinx
# dicts
ADD dicts /var/diz/sphinx
# scripts
ADD searchd.sh /
RUN chmod a+x searchd.sh
ADD indexall.sh /
RUN chmod a+x indexall.sh