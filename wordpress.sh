#!/bin/bash

# Update the package list and upgrade all installed packages to their latest versions
# This ensures we have the most recent software and security updates
sudo apt update
sudo apt upgrade -y

# Install necessary packages:
# apache2: Web server to host WordPress
# php: Server-side scripting language required by WordPress
# php-mysql: PHP extension for MySQL database connectivity
# mysql-server: Database server to store WordPress data
sudo apt install -y apache2 php php-mysql mysql-server

# Start the Apache web server and enable it to start automatically on system boot
sudo systemctl start apache2
sudo systemctl enable apache2

# Change to the default web root directory where we'll install WordPress
cd /var/www/html

# Download the latest version of WordPress
sudo wget https://wordpress.org/latest.tar.gz

# Extract the WordPress archive
sudo tar -xzf latest.tar.gz

# Move WordPress files to the current directory (web root)
sudo cp -r wordpress/* .

# Clean up by removing the original archive and the empty WordPress directory
sudo rm -rf wordpress latest.tar.gz

# Create a WordPress configuration file from the sample provided
sudo cp wp-config-sample.php wp-config.php

# Set the correct ownership for all WordPress files
# www-data is the user and group that Apache uses by default on Ubuntu
sudo chown -R www-data:www-data /var/www/html/*

# Restart Apache to ensure all changes take effect
sudo systemctl restart apache2

# Note: After running this script, you'll need to:
# 1. Set up a MySQL database for WordPress
# 2. Edit wp-config.php to include your database details
# 3. Complete the WordPress installation through the web interface 