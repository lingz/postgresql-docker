#!/bin/bash

# Starts a data only container for postgresql
# First argument gives the name.

VOL=/data

if [ $# -ne 1 ]; then
  echo 1>&2 "Pass in the name of this postgresql data container"
else
  docker run --name $1 -v $VOL lingz/data
fi
