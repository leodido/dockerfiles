# TreeTagger
#
# @link     http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger
# @version 	3.2
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
# download parameter files
ADD paramfiles.txt $TT/paramfiles.txt
RUN cd $TT && wget -nv -i paramfiles.txt
# download chunker parameter files
ADD chunkerparamfiles.txt $TT/chunkerparamfiles.txt
RUN cd $TT && wget -nv -i chunkerparamfiles.txt
# download the package
RUN wget -P $TT http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tree-tagger-linux-3.2.tar.gz
# download the tagging scripts
RUN wget -P $TT http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tagger-scripts.tar.gz
# installation
ADD install.sh $TT/install.sh
RUN cd $TT && chmod a+x install.sh && sh install.sh
# environment
ENV PATH $PATH:$TT/bin
ENV PATH $PATH:$TT/cmd
# clean up
RUN cd $TT && xargs -a paramfiles.txt -d'\n' -L1 basename | xargs rm
RUN cd $TT && xargs -a chunkerparamfiles.txt -d'\n' -L1 basename | xargs rm 
RUN cd $TT && rm tree-tagger-linux-3.2.tar.gz tagger-scripts.tar.gz install.sh paramfiles.txt chunkerparamfiles.txt
