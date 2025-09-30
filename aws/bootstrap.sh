#!/bin/bash

# Update package lists (Debian/Ubuntu)
sudo apt-get update -y

# Install Nginx web server
sudo apt-get install -y nginx

# Install Python3
sudo apt-get install -y python3 python3-pip

# Install pipx for isolated Python package management
sudo apt-get install -y pipx
pipx ensurepath

# Activate pipx environment
source /home/ubuntu/.local/share/pipx/venvs/flask/bin/activate

# Install Flask using pipx
pipx install flask

# Enable and start Nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Sample index.html file to verify Nginx is serving content
echo "Welcome to Mike's Nginx server!" > /var/www/html/index.html

# Print installed versions
nginx -v
python3 --version