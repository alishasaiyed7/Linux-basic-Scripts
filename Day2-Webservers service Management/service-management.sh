#!/bin/bash
# Script to deploy Apache or Nginx and manage services

echo "============================"
echo " Process & Service Management Script "
echo "============================"

# Ask user for choice
echo "Which web server do you want to install?"
echo "1. Apache"
echo "2. Nginx"
read -p "Enter choice [1/2]: " choice

## This is will Check is choice = 1 or 2 if its 1 then it will install apache2 and if 2 then it will install and 
start NGINX 

if [ "$choice" -eq 1 ]; then
   sudo apt update -y
   sudo apt install apache2 -y
   sudo systemctl enable apache2
   sudo systemctl start apache2
elif [ "$choice" -eq 2 ]; then
   sudo apt update -y
   sudo apt install nginx -y
   sudo systemctl enable nginx
   sudo systemctl start nginx
else
    echo "❌ Invalid choice. Exiting..."
    exit 1
fi
