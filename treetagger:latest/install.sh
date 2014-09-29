#!/bin/sh
#
# Installation script
# @author   leodido   <leodidonato@gmail.com>

mkdir cmd
mkdir lib
mkdir bin
mkdir doc
echo ''

PARAM_DIR=params
CPARAM_DIR=chunkerparams

# Install TreeTagger
if [ -r tree-tagger-linux-3.2.tar.gz ]; then
    gzip -cd tree-tagger-linux-3.2.tar.gz | tar -xf -
    echo 'TreeTagger installed.'
else
  exit 1
fi

# Install tagging scripts
if [[ -r tagger-scripts.tar.gz ]]; then
    gzip -cd tagger-scripts.tar.gz | tar -xf -
    chmod +x cmd/*
    echo 'Tagging scripts installed.'
fi

# Install parameter files
for PARAM in $(find ${PARAM_DIR} -type f -name "*.bin.gz" -printf '%f\n'); do
    NAME=${PARAM%%-*}
    OUTPUT="${NAME^} parameter file"
    if [ $(echo ${PARAM} | grep "utf8") ]; then
        NAME="${NAME}-utf8"
        OUTPUT="${OUTPUT} (UTF8)"
    fi
    gzip -cd ${PARAM_DIR}/${PARAM} > lib/${NAME}.par
    echo "${OUTPUT} installed."
done

# Install chunker parameter files
for CPARAM in $(find ${CPARAM_DIR} -type f -name "*.bin.gz" -printf '%f\n'); do
    LANG=${CPARAM%%-*}
    NAME=$(echo ${CPARAM} | cut -d '-' -f 1,2)
    OUTPUT="${LANG^} chunker parameter file"
    if [ $(echo ${CPARAM} | grep "utf8") ]; then
        NAME="${NAME}-utf8"
        OUTPUT="${OUTPUT} (UTF8)"
    fi
    gzip -cd ${CPARAM_DIR}/${CPARAM} > lib/${NAME}.par
    echo "${OUTPUT} installed."
done

# Edit path variables of tagging scripts
for file in cmd/*
do
    awk '$0=="BIN=./bin"{print "BIN='`pwd`'/bin";next}\
         $0=="CMD=./cmd"{print "CMD='`pwd`'/cmd";next}\
         $0=="LIB=./lib"{print "LIB='`pwd`'/lib";next}\
         {print}' ${file} > ${file}.tmp;
    mv ${file}.tmp ${file};
done
echo 'Path variables modified in tagging scripts.'
chmod 0755 cmd/*
echo 'Done.'
