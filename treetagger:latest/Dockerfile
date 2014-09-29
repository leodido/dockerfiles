# TreeTagger
#
# @link     http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger
# @version 	latest (3.2)
# @author 	leodido <leodidonato@gmail.com>
FROM centos:centos6

MAINTAINER Leonardo Di Donato, leodidonato@gmail.com

# add public key
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
# envinronment
ENV TT /treetagger-3.2
RUN mkdir $TT
# utilitites
RUN yum install perl wget tar -y -q
# download the parameters, chunker parameters and available tagsets
RUN wget -P $TT https://bitbucket.org/leodido/treetagger-src/downloads/treetagger-src-3.2.tar.gz
# download the package
RUN wget -P $TT http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tree-tagger-linux-3.2.tar.gz
# download the tagging scripts
RUN wget -P $TT http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tagger-scripts.tar.gz
# installation
ADD install.sh $TT/install.sh
RUN cd $TT && tar -xzf treetagger-src-3.2.tar.gz && chmod a+x install.sh && sh install.sh
# environment
ENV PATH $PATH:$TT/bin
ENV PATH $PATH:$TT/cmd
# clean up
RUN cd $TT && rm tree-tagger-linux-3.2.tar.gz tagger-scripts.tar.gz treetagger-src-3.2.tar.gz install.sh
RUN cd $TT && rm -rf params/ && rm -rf chunkerparams/