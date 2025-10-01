#!/bin/bash

# Log all script output to a file for easier debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sudo apt-get update -y
sudo apt-get install -y python3 python3-pip python3-venv git

sudo mkdir -p /opt/mikeapp
sudo chown -R ubuntu:ubuntu /opt/mikeapp

# Clone the app from its repository
sudo -H -u ubuntu git clone https://github.com/migmoren/mikeapp.git /opt/mikeapp

# Create a Python virtual environment
cd /opt/mikeapp
sudo -H -u ubuntu python3 -m venv venv

# Install flask
sudo -H -u ubuntu /opt/mikeapp/venv/bin/pip install Flask

# Start the Flask app in the background and log app's output to a file
cd /opt/mikeapp/src
sudo -H -u ubuntu nohup /opt/mikeapp/venv/bin/python3 app.py > /opt/mikeapp/app.log 2>&1 &
