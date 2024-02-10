#!/bin/bash

# Top-level variables
MYSQL_USER="$MYSQL_USR"
MYSQL_PASSWORD="$MYSQL_PWD"
DATABASE_NAME="$DB_NAME"

# Sample table creation SQL
TABLE_SQL="
CREATE TABLE sample_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
"

# Update the system
sudo apt update

# Install MySQL
sudo apt install -y mysql-server

# Secure MySQL installation
# Note: This will prompt you for some configurations like setting root password, removing anonymous users, etc.
sudo mysql_secure_installation

# Login to MySQL, create the database, and the sample table
sudo mysql -u root -e "
CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'localhost' WITH GRANT OPTION;
CREATE DATABASE ${DATABASE_NAME};
USE ${DATABASE_NAME};
${TABLE_SQL}
FLUSH PRIVILEGES;
"

echo "MySQL installation, database, and table creation completed!"
