## 🧰 Linux Web Deployment Automation (Apache & Nginx)

## 📖 Overview

This project automates the process of deploying a static Bootstrap website on a Linux server. \
It uses a shell script to: 

Install required web services (Apache2 or Nginx) \
Deploy the website from a GitHub repository \
Make it accessible via the server’s IP address \
This is a simple but powerful DevOps + Linux Administration project showing your understanding of automation, web service configuration, and deployment.

## ⚙️ Tech Stack

Linux (Ubuntu/Debian)
Apache2 / Nginx
Git
Bash Shell Script
StartBootstrap Template (Static HTML/CSS/JS)

## 🚀 Script Explanation

Below is an example deploy.sh for Apache2 deployment:
```bash
#!/bin/bash
# Automated Apache2 Bootstrap Template Deployment Script

echo "=== Starting Deployment ==="
# Update system packages
sudo apt update -y
# Install Apache, Git and Unzip
sudo apt install apache2 git unzip -y
# Enable and start Apache
sudo systemctl enable apache2 nginx
sudo systemctl start apache2 nginx

# Create web root
sudo rm -rf /var/www/html
sudo mkdir -p /var/www/html
sudo chown -R $USER:$USER /var/www/html

# Configure Apache to use the new directory
sudo sed -i 's|DocumentRoot /var/www/html|' /etc/apache2/sites-available/000-default.conf

# Restart Apache
sudo systemctl restart apache2

# Clone Bootstrap template
sudo git clone https://github.com/StartBootstrap/startbootstrap-agency.git 

# Copy required files to web root
cp -r startbootstrap-agency/dist/*  /var/www/html

# Restart nginx
sudo systemctl restart nginx

echo "=== Deployment Completed Successfully! ==="
echo "Visit: http://<your-server-ip>:8080"
echo "Visit: http://<your-server-ip>"

# both should show you the output.

```

## 🌐 How to Run

Save the script as deploy.sh
Make it executable:
```bash
chmod +x deploy.sh
```

Run it:
```bash
./deploy.sh
```

Once completed, visit your site in the browser:
```bash
http://<server-ip>:8080
http://<server-ip>
```


## If you want to add a manual path insted of /var/www/html
``` bash

#create a web root
sudo mkdir -p /var/www/apache2
sudo chown $USER:$USER /var/www/apache2

#open the files and make an update
sudo bash -c 'cat <<EOF >> /etc/apache2/sites-available/000-default.conf
add the path inside
< Virtual Host : 8080 >
Document Root /var/www/apache2
</ VirtualHost>
EOD'

# Ensure Apache has access
sudo bash -c 'cat <<EOF >> /etc/apache2/apache2.conf
<Directory /var/www/apache2>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
EOF'

#Same way you can change the path of NGINX
just update
 /etc/nginx/sites-available/default to point to that directory
and restart NGINX

```
| Code Section                            | Description                                                   |       |                                                             |
| --------------------------------------- | ------------------------------------------------------------- | ----- | ------------------------------------------------- |
| `sudo apt install apache2 git unzip -y` | Installs web server and tools needed for deployment.          |       |                                                             |
| `systemctl enable/start apache2`        | Ensures Apache starts automatically on boot.                  |       |                                                             |
| `mkdir -p /var/www/apache2 or html`      | Creates a dedicated folder for the website.                   |       |                                                             |
| `sed -i 's                              | Document Root
| `git clone`                             | Downloads the Bootstrap template directly from GitHub.        |       |                                                             |
| `cp -r startbootstrap-agency/dist/*`                          | Copies ready-to-serve website files to the root folder.       |       |                                                             |
| `systemctl restart apache2`             | Restarts Apache to reflect configuration and content changes. |       |                                                             |



## 💡 Why This Project Matters

This project demonstrates:

✅ Linux administration skills — package installation, service management, permissions. \
✅ Automation with Bash scripting — reducing manual setup.\
✅ Web server configuration — Apache & Nginx basics \
✅ Static website deployment — hosting Bootstrap templates \
✅ DevOps fundamentals — preparing for CI/CD, infrastructure as code 

Such projects are perfect for resumes, interviews, and portfolios because they showcase real-world system setup and automation skills.

#If faced any error while executing, You can always reach out to me at saiyedalisha110@gmail.com.

## AUTHOR
Name - Saiyed Alisha
Designation - sysadmin/AWS
