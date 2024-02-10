#!/bin/bash

# Update system packages
sudo apt update
sudo apt upgrade -y

# Install Nginx
sudo apt install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Remove default Nginx configuration
sudo rm /etc/nginx/sites-enabled/default

# Create a new Nginx configuration file
echo "server {
    listen 80;
    $SITE_NAME;

    root /home/deploy/dsclub/public;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location ~* ^/assets/ {
        expires 12h;
        add_header Cache-Control public;
    }

    error_page 500 502 503 504 /500.html;
    client_max_body_size 10M;
    keepalive_timeout 10;
}" | sudo tee /etc/nginx/sites-available/$SITE_NAME

# Enable the new Nginx configuration
sudo ln -s /etc/nginx/sites-available/$SITE_NAME /etc/nginx/sites-enabled/

# Test the Nginx configuration
sudo nginx -t

# Restart Nginx
sudo systemctl restart nginx
