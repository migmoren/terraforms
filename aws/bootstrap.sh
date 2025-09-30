#!/bin/bash

# Update package lists (Debian/Ubuntu)
sudo apt-get update -y

# Install Python3
sudo apt-get install -y python3 python3-pip

# Install pipx for isolated Python package management
sudo apt-get install -y pipx
pipx ensurepath

# Activate pipx environment
source /home/ubuntu/.local/share/pipx/venvs/flask/bin/activate

# Install Flask using pipx
pipx install flask

# Start a sample Flask app
python3 app.py
