#!/bin/bash

# With no arguments, will start a temporal postgres database.
# With one or more arguments, will start a potsgres database
# connecting to the data container with the name of the first
# argument.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
if [ $# -lt 1 ]; then
  docker run -i -t --rm --name pg lingz/postgresql
else
  # check for the data container
  CONTAINER_NUM="$( docker ps -a | grep "$!" | grep lingz/data | wc -l )"

  if [ "$CONTAINER_NUM" == 0 ]; then
    # If it the data container doesn't exist, start it
    $DIR/create_data_container.sh $1
  fi
  docker run -i -t --rm --volumes-from $1 --name pg lingz/postgresql
fi
