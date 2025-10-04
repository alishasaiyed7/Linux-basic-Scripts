#!/bin/bash
# Deploy Bootstrap "Full Width Pics" template with Nginx + Apache

# Update system
sudo apt update -y && sudo apt upgrade -y

# Install packages
sudo apt install -y nginx apache2 unzip wget git

# Enable & start both
sudo systemctl enable nginx apache2

# Change Apache to port 8080
sudo sed -i 's/Listen 8080/' /etc/apache2/ports.conf 
#if this doesn't work you can manually do the changes
sudo sed -i 's/<VirtualHost \*:8080 >/' /etc/apache2/sites-available/000-default.conf
#if this doesn't work you can manually do the changes

# Restart Apache
sudo systemctl restart apache2

# Clean old content

sudo rm -rf /var/www/html/*
mkdir -p /var/www/html

# Download from github
# Deploy to Nginxrom github

git clone http://github.com/StartBootstrap/startbootstrap-agency.git

#deploy to apache
sudo cp -r startbootstrap-agency/dist/* /var/www/html

# Restart Nginx
sudo systemctl restart nginx

echo "==================================================="
echo "✅ Deployment complete!"
echo "Nginx:  http://<your-server-ip>"
echo "Apache: http://<your-server-ip>:8080"
echo "==================================================="
