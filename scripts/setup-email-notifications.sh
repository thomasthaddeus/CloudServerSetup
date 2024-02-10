#!/bin/bash

# Set the email destination
echo "destemail = $USER_EMAIL" | sudo tee -a /etc/fail2ban/jail.local

# Set the action to take when a ban occurs
# The "sendmail-whois" action sends an email with whois information about the banned IP
echo "action = %(action_mw)s" | sudo tee -a /etc/fail2ban/jail.local

# Restart Fail2Ban
sudo service fail2ban restart
