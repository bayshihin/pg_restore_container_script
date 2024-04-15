#!/bin/bash

# Parameters for connecting to the PostgreSQL database
PGHOST="localhost"
PGUSER=""
PGPASSWORD=""
DATABASE=""

# Pulling an archive with a backup copy from the repository
cd /your/path/to/archiveslocation/
git pull origin main

# Name of the backup archive
BACKUP_FILE=$(basename $(ls -t db_backup*.tar.gz | head -n 1))
SQLFILE=$(ls -t db_backup*.sql | head -n 1)

# Unpacking the archive
tar -xzf $BACKUP_FILE -C /your/path/to/archiveslocation/

# Delivery of backup to container
docker cp /your/path/to/archiveslocation/$SQLFILE $(docker ps -aqf "name=<POSTGRESQL_CONTAINER_NAME>"):/your_desired_path_in_container/$SQLFILE  # replace <POSTGRESQL_CONTAINER_NAME> with your PostgreSQL container name

# Run pg_restore in a PostgreSQL container
docker exec <POSTGRESQL_CONTAINER_NAME> psql -U $PGUSER -d $DATABASE -f /your_desired_path_in_container/$SQLFILE # replace <POSTGRESQL_CONTAINER_NAME> with your PostgreSQL container name

# Optional: Deleting the unpacked archive
rm /your/path/to/archiveslocation/$BACKUP_FILE
