#!/bin/bash

if [ ! -d "/data/pg" ]; then
  # Give ownership to postgres
  mkdir -p /data/pg 
  chmod 700 /data/pg 
  chown postgres /data/pg

  # Create a database
  sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D /data/pg -E 'UTF-8'
fi

sudo -u postgres -i /usr/lib/postgresql/9.3/bin/postgres -D /data/pg -c config_file=/etc/postgresql/9.3/main/postgresql.conf
