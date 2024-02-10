#!/bin/bash

# Set database parameters
db_user="$DB_USER"
db_password="$DB_PWD"
db_name="$MYSQL_DB_NAME"

# Set the backup path
backup_path="/var/log/mysql/backups"
date=$(date +"%Y-%m-%d")

# Create a backup
mysqldump -u $db_user -p$db_password $db_name > $backup_path/db_backup_$date.sql
