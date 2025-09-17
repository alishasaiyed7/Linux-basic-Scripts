## 📘 Process & Service Management Project
## 🔹 Overview

In this project, we learn how to deploy, manage, and monitor web server processes (Apache/Nginx) on a Linux system.
We also automate the installation and basic management using a Bash script.

## 🔹 What is Apache & Nginx?

Apache (Apache HTTP Server)
One of the oldest and most widely used web servers.
Great for serving static websites (HTML, CSS, images) and dynamic websites (PHP, Python apps, etc.).
Very flexible with modules (extra features you can enable).

Nginx (Engine-X)
A newer, high-performance web server.
Known for speed and handling many users at the same time (better concurrency).
Often used as a reverse proxy (sits in front of app servers like Node.js, Python, etc.) and for load balancing.

## 👉 Why do we use them?
Because when you type a website URL in your browser, something needs to listen on port 80/443 and deliver the website’s content. 
That “something” is usually Apache or Nginx.

## 🔹 In this Project You Will Learn

How to install Apache/Nginx on Linux.
How to use systemctl to manage services (start, stop, enable, disable).
How to monitor processes with top, htop, and ps.
How to kill and restart services manually.
How to automate everything using a Bash script.

## 🔹 Manual Steps 

```bash
# Apache
sudo apt install apache2 -y  
# Nginx
sudo apt install nginx -y

```
## 2. Manage Service with systemctl
```bash
sudo systemctl start apache2   # Start service
sudo systemctl stop apache2    # Stop service
sudo systemctl enable apache2  # Start at boot
sudo systemctl disable apache2 # Disable at boot
sudo systemctl status apache2  # Check status
```

## Note - (Replace apache2 with nginx if you choose Nginx)
## 3. Monitor Processes
```bash
ps aux | grep apache2    # List processes
top                      # Real-time monitoring
htop                     # Better version of top (install: sudo apt install htop -y)
```

## 4. Kill a Process
```bash
sudo kill <PID>
sudo kill -9 <PID>   # Force kill
```

## 🔹 Automation Script
```bash
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

if [ "$choice" -eq 1 ]; then
    sudo apt update -y
    sudo apt install apache2 -y
    sudo systemctl enable apache2
    sudo systemctl start apache2
    echo "✅Apache2 Installed Successfully"
elif [ "$choice" -eq 2 ]; then
    sudo apt update -y
    sudo apt install nginx -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "✅Apache2 Installed Successfully"
else
    echo "❌ Invalid choice. Exiting..."
    exit 1
fi
```

## 🔹 Purpose of This Project

✔ Learn real-world service management (important for SysAdmins & DevOps Engineers).
✔ Understand how web servers (Apache/Nginx) run as background processes (daemons).
✔ Practice monitoring & troubleshooting services.
✔ Build an automation script so tasks become repeatable.

## 🔹 Final Outcome

You can deploy Apache or Nginx in one click with your script.
You can manage and monitor services like a professional.
You’ll understand the difference between web servers and process managers.


## Adding Examples to understand it better

🌐 Apache Web Server (Example)

Think of Apache as a traditional restaurant:
A waiter (Apache) takes your order (HTTP request).
The waiter goes to the kitchen (server filesystem), fetches the dish (HTML/PHP file), and brings it back to you (browser).
Apache handles each customer with a separate waiter (process). If there are 100 customers, 100 waiters are working.

📌 Example:

You type http://mywebsite.com in your browser.
Apache checks your website folder (/var/www/html) for index.html.
It sends that file back to your browser to display.
If it’s PHP, Apache passes it to PHP interpreter, gets the result, and sends it back.
✅ Apache is good for dynamic websites like WordPress, PHP apps, or anything that needs a lot of backend processing.


## 🌐 Nginx Web Server (Example)

Think of Nginx as a fast-food restaurant:
Instead of one waiter per customer, there’s a queue system. One cashier (Nginx) can serve thousands of customers quickly.
Nginx is very efficient for serving static files (HTML, images, CSS, JS).
For dynamic content (like PHP), Nginx forwards the request to another backend service (like PHP-FPM).

📌 Example:

You type http://mywebsite.com in your browser.
Nginx quickly serves index.html or style.css from memory.
If the page needs PHP, Nginx sends the request to PHP-FPM or another backend server, then gives you the result.
✅ Nginx is great for speed, load balancing, handling many users, and modern apps.

🆚 Easy Comparison
Feature                   	Apache (Restaurant Waiter)	                       Nginx (Fast Food Counter)
Handling requests	          One process per request                            Handles thousands at once
Static content
(HTML, CSS, images)	         Slower	                                           Super fast
Dynamic content              Very good (built-in)	                             Needs PHP-FPM/Backend
(PHP, WordPress)	                     
Best used for	                Traditional websites, PHP apps	                  High-performance sites, APIs, reverse proxy

## 👉 Simple way to remember:

Apache = old reliable waiter, good at cooking complex meals (dynamic content).
Nginx = super-fast counter, great at quickly giving pre-cooked meals (static files) and balancing big crowds.

## Author:
Name - Saiyed Alisha
Designation - SystemAdmin | AWS

