#!/bin/bash

# Change the ban time to 24 hours
echo "bantime = 86400" | sudo tee -a /etc/fail2ban/jail.local

# Restart Fail2Ban
sudo service fail2ban restart
