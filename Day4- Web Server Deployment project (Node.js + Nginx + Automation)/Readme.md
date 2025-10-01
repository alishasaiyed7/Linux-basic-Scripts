## 📖 README – Deploying a Node.js App with Nginx Reverse Proxy

This guide explains how to deploy a Node.js application on Linux, use Nginx as a reverse proxy, and why we sometimes see Apache in the mix.

## 📌 Why Apache vs Nginx?
## 🔹 Apache

Full-featured traditional web server.
Good for serving static files (HTML, PHP, etc.).
Uses process/thread-based architecture → heavier on memory under high load.
You had Apache pre-installed, that’s why it was taking port 80 and blocking Nginx.

## 🔹 Nginx

High-performance reverse proxy & load balancer.
Designed for speed, scalability, and handling many concurrent connections.
Works perfectly with Node.js apps because Node runs on a different port (e.g., 3000), and Nginx forwards HTTP requests from port 80 → 3000.
Handles SSL/TLS termination, caching, compression, security, etc.

## 👉 We use Nginx as reverse proxy so users can access app via
http://server-ip  instead of http://server-ip:3000

## 1. 🔧 Install Dependencies
```bash
Update & install Node.js, npm, Git
sudo apt update && sudo apt upgrade -y
sudo apt install -y nodejs npm git
```

apt update && apt upgrade → updates package list & system packages.
nodejs → runtime for JavaScript apps
npm → package manager for Node.js.
git → to pull your source code from GitHub.

## 2. 📦 Clone Your Application ( optional in our case )
```bash
git clone https://github.com/<your-repo>.git
cd <repo-name>
```

## 3. 📥 Install Node.js Packages
```bash
npm install
```
Installs all dependencies defined in package.json.

## 4. ▶️ Run the App (Test Mode)
```bash
node app.js
```
or if it uses npm start:
```bash
npm start
```
Now test in browser:
```bash
http://<server-ip>:3000
```

💡 Node.js apps usually run on ports like 3000, 4000, 8080 — but not directly on port 80 (default web port).

## 5. 🚀 Use PM2 (Process Manager)

Install PM2 so app stays alive in background:
```bash
sudo npm install -g pm2
pm2 start app.js --name myapp
pm2 startup systemd
pm2 save
```
pm2 start → runs app as a service.
pm2 save → ensures it auto-starts after reboot.

## 6. 🌐 Install & Configure Nginx (Reverse Proxy)
```bash
sudo apt install -y nginx
```

Create Nginx Config
```bash
sudo nano /etc/nginx/sites-available/myapp
```
Paste:
```bash
server {
    listen 80;
    server_name_>;
    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

Enable Config
```bash
sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## 7. ✅ Test

Open in browser:

http://<server-ip>

Your Node.js app should now load directly on port 80 without writing :3000.

## 7. Errors you may Encounter during the project.

a) Not able to see the server Ip by Ip addr show.
In that case change your network from NAT to bridged.

b) You Might not able to restart the NGINX service.
For that first stop the apache by systemctl stop apache2 
and then systemctl restart nginx and see the status.

also there are some extra command which you can use to check if things are working poperly without error 

sudo nginx -t -> will show if there is any error in your nginx config if not this will success.
sudo ln -s /etc/nginx/sites-available/nodeapp /etc/nginx/sites-enabled/ (link)

match your nginx config code - /etc/nginx/sites-available/nodeapp ( make sure both are same and there is no mismatch)

if still you see error with nginx try to remove 
```bash
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
```

This should give you the nodejs app on your server ip eg - 192.168.10.110

## 🚀 Benefits of Using Nginx with Node.js

User-friendly URLs → no need to expose port 3000.
Security → hides backend server, filters requests.
Performance → handles static assets (images, CSS, JS) faster than Node.js itself.
Scalability → can load balance across multiple Node.js instances.
SSL/TLS → easy HTTPS setup with Let’s Encrypt.

## ✅ Now you have a production-ready setup:
Node.js app managed by PM2
Requests handled by Nginx reverse proxy
Apache removed (to avoid conflict)


## AUTHOR
Name - Saiyed Alisha
Designation - SystemAdmin /AWS
















