# Container pg_restore script

This script will allow you to automate the restoration of Postgres from a backup downloaded from a remote repository
```
#!/bin/bash

# Parameters for connecting to the PostgreSQL database
PGHOST="localhost"
PGUSER=""
PGPASSWORD=""
DATABASE=""

# Create a backup file name with the current date
BACKUP_FILE="db_backup_$(date +'%Y%m%d').sql"

# Path to save the backup
cd /your/path/to/backup/dir/

# Create a database backup
docker exec <POSTGRESQL_CONTAINER_NAME> pg_dump -h $PGHOST -U $PGUSER -d $DATABASE > $BACKUP_FILE   # replace <POSTGRESQL_CONTAINER_NAME> with your posrgresql container name

# Archiving a backup
tar -czf $BACKUP_FILE.tar.gz $BACKUP_FILE

# Deleting the original backup file
rm $BACKUP_FILE

# Push archive to remote repository (optional)
cd /your/path/to/localrepo/with/backups
git add .
git commit -m "Added database backup"
git push origin main
```


