FROM ubuntu:14.04
MAINTAINER lingliangz@gmail.com

# prevent apt from starting postgres right after the installation
RUN echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``9.3``.
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Update the Ubuntu and PostgreSQL repository indexes
RUN apt-get update &&\
  apt-get -y -q install postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
ADD files/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD files/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
RUN chown -R postgres /etc/postgresql/9.3/main/ &&\
  chmod 644 /etc/postgresql/9.3/main/postgresql.conf &&\
  chmod 640 /etc/postgresql/9.3/main/pg_hba.conf

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/data"]
EXPOSE 5432

# Set the default command to run when starting the container
ADD files/run.sh run.sh
RUN chmod +x run.sh
CMD ["/run.sh"]
