#!/bin/bash

# Enable Nginx HTTP Auth protection
echo "[nginx-http-auth]" | sudo tee -a /etc/fail2ban/jail.local
echo "enabled = true" | sudo tee -a /etc/fail2ban/jail.local

# Restart Fail2Ban
sudo service fail2ban restart
