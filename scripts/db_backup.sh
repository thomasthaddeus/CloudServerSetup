#!/bin/bash

# Set database parameters
db_user=$MYSQL_USERNAME
db_password=$MYSQL_PWD
db_name=$MYSQL_DBNAME

# Set the backup path
DIR=$(date +"%Y-%m-%d")
DEST=~/db_bak/$DIR
mkdir DEST

# Create a backup
mysqldump -u $db_user -p$db_password $db_name > bkup_$DEST.sql

