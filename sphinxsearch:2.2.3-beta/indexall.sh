#!/bin/bash
#
# @author leodido

indexer --all "$@"
./searchd.sh
