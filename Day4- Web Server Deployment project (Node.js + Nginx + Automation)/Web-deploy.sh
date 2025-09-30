#!bin/bash

sudo apt update -y && sudo apt upgrade -y


APP_DIR="/home/alisha/app.js"
sudo mkdir -p $APP_DIR
sudo chown $USER:$USER $APP_DIR

# Create Node.js app
echo ">>> Setting up Node.js app..."
cat <<EOF > $APP_DIR/app.js
const http = require('http');
const hostname = '0.0.0.0';
const port = 3000;
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('🚀 Hello from Node.js App served via Nginx reverse proxy!\n');
});
server.listen(port, hostname, () => {
  console.log(\`Server running at http://\${hostname}:\${port}/\`);
});
EOF

# Install PM2 process manager
sudo npm install -g pm2
cd $APP_DIR
pm2 start app.js
pm2 startup systemd
pm2 save

# Install Nginx
echo ">>> Installing Nginx..."
sudo apt install -y nginx


# Configure Nginx reverse proxy
echo ">>> Configuring Nginx..."
NGINX_CONF="/etc/nginx/sites-available/nodeapp"
sudo bash -c "cat > $NGINX_CONF" <<EOF
server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
     }
}
EOF

# Enable Nginx site
sudo ln -s /etc/nginx/sites-available/nodeapp /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl restart nginx

echo "==== Deployment Completed! Visit http://<server-ip> to see your app ===="