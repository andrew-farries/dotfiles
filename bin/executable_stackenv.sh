#! /bin/bash

#
# Take the output of a Xata pulumi stack and write its values to stdout in .env
# file format.
#
# Usage: ./stackenv.sh <stack-name>
#

pulumi stack output \
  -s $1 \
  --show-secrets  \
  --shell  \
  xataEnvOutput  \
  | sed '1d;$d'  \
  | awk '{$1=$1;print}'  \
  | tr -d "'"  \
  | tr -d "\\"
