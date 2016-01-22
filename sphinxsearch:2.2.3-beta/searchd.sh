#!/bin/bash
#
# @author leodido

# start searchd without exiting shel
exec searchd --nodetach "$@"
