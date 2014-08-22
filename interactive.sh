#!/bin/bash

docker run --rm --volumes=true -t -i --link pg:pg lingz/postgresql \
  psql -h pg -U postgres
