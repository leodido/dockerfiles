# Sphinx Search
#
# @version 	2.1.7
# @author 	leodido
FROM centos:latest

MAINTAINER Leonardo Di Donato, leodidonato@gmail.com

# add public key
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
# install wget
RUN yum install wget -y -q
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
# download sphinxsearch source and extract it
RUN wget -nv -O - http://sphinxsearch.com/files/sphinx-2.1.7-release.tar.gz | tar zx
# copy libstemmer inside sphinxsearch source code
RUN cp -R libstemmer_c/* sphinx-2.1.7-release/libstemmer_c/
# install sphinxsearch
RUN cd sphinx-2.1.7-release && ./configure --enable-id64 --with-mysql --with-pgsql --with-libstemmer --with-libexpat --with-iconv --with-unixodbc && make -j install
# remove sources
RUN rm -rf sphinx-2.1.7-release/ && rm -rf libstemmer_c/
# expose ports
EXPOSE 9306 9312
# scripts
ADD searchd.sh /
RUN chmod a+x searchd.sh
ADD indexall.sh /
RUN chmod a+x indexall.sh
# volumes
VOLUME ["/var/spx/sphinx", "/var/log/sphinx", "/var/lib/sphinx", "/var/run/sphinx"]
