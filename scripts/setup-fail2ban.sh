#!/bin/bash

# Update packages
sudo apt-get update

# Install Fail2Ban
sudo apt-get install -y fail2ban

# Create a jail.local file to override the default settings
cat << EOF | sudo tee /etc/fail2ban/jail.local
[DEFAULT]
# Ban hosts for one hour:
bantime = 3600

# Override /etc/fail2ban/jail.d/00-firewalld.conf:
banaction = iptables-multiport

[sshd]
enabled = true
EOF

# Restart Fail2Ban
sudo service fail2ban restart

# Call additional scripts
source ./protect-nginx.sh
source ./change-ban-time.sh
source ./setup-email-notifications.sh
