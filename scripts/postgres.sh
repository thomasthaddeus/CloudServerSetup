#!/bin/bash

# Update system packages
sudo apt update
sudo apt upgrade -y

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib libpq-dev -y

# Create a new PostgreSQL user
sudo -u postgres createuser -s devsetup

# Create a new PostgreSQL database
sudo -u postgres createdb dsserver
