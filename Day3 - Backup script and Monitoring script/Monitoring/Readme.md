## 📄 README.md – Disk & Memory Monitoring Script
📌 Overview

diskmonitor.sh is a simple Linux monitoring script that:
Checks disk usage and memory usage on your server.
Sends an alert email if usage crosses a defined threshold (default: 80%).
Can be scheduled with cron to run automatically.
This is useful for system admins and DevOps engineers to prevent system crashes due to full disks or low memory.

---

## ⚙️ Prerequisites

Linux VM (Ubuntu/Debian/CentOS/RedHat).
mailutils or sendmail installed (for email alerts):

```bash
sudo apt install mailutils -y   # Ubuntu/Debian
sudo yum install mailx -y       # CentOS/RedHat

```

## Disk & Mem Monitoring Script
```bash
#!/bin/bash
# Disk & Memory Monitoring Script with Email Alerts

THRESHOLD=80
EMAIL="your_email@example.com"

# Disk Usage Check
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' tr -d '%' )

df -h / → shows disk usage for /
tail -1 → skips the header, takes only the last line.
awk '{print $5}' → extracts the 5th column (like 63%).
tr -d '%' → removes % sign → gives 63

# Memory Usage Check
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | awk '{print int($1)}')

free → shows memory usage.
grep Mem → selects the line with memory statistics.
awk '{print ($3/$2)*100}' → calculates used/total memory (%).
cut -d. -f1 → removes decimals, keeping integer percentage.


# Check Disk
if [ $DISK_USAGE -ge $THRESHOLD ]; then
## check if disk usage -ge (get equals  = ) threshold value
If disk usage ≥ 80%, send an email alert.
Same logic applies for memory usage.

    MESSAGE="⚠️ Warning: Disk usage on $(hostname) is at ${DISK_USAGE}% (above ${THRESHOLD}%)"
    echo "$MESSAGE"
    echo "$MESSAGE" | mail -s "Disk Alert: $(hostname)" $EMAIL
else
    echo "✅ Disk usage is normal: ${DISK_USAGE}%"
fi

# Check Memory

if [ $MEM_USAGE -ge $THRESHOLD ]; then
## check if mem usage -ge (get equals  = ) threshold value
    MESSAGE="⚠️ Warning: Memory usage on $(hostname) is at ${MEM_USAGE}% (above ${THRESHOLD}%)"
    echo "$MESSAGE"
    echo "$MESSAGE" | mail -s "Memory Alert: $(hostname)" $EMAIL
else
    echo "✅ Memory usage is normal: ${MEM_USAGE}%"
fi
```

Execution permission for the script:
```bash
chmod +x diskmonitor.sh
```

## 🚀 Usage
Run the script manually:
```bash
./diskmonitor.sh
```

## ✅ Sample Output

If usage is normal:
✅ Disk usage is normal: 45%
✅ Memory usage is normal: 60%

If threshold exceeded:
⚠️ Disk usage is high: 91%
⚠️ Memory usage is high: 85%

## Schedule it in cron (example: every 10 minutes):
```bash
crontab -e
*/10 * * * * /path/to/diskmonitor.sh
```

---

## 📩 Email Setup Options
Option 1: Local Inbox (Quick Test)

The script sends alerts to the local system mailbox.
Check mails with:

mail

Mails are stored in:
/var/mail/<username>

⚠️ Emails won’t leave the VM (only local).


## Option 2: Gmail SMTP Relay (Recommended)

Install mail tools:
```bash
sudo apt update
sudo apt install -y postfix mailutils libsasl2-modules
```

Configure Postfix:
```bash
sudo nano /etc/postfix/main.cf
```


Add:
```bash
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_use_tls = yes
```

Add Gmail credentials:
```bash
sudo nano /etc/postfix/sasl_passwd
```
[smtp.gmail.com]:587 yourgmail@gmail.com:your_app_password

⚠️ You must use a Gmail App Password, not your normal password.
Create one at: Google App Passwords

## Secure credentials:
```bash
sudo postmap /etc/postfix/sasl_passwd
sudo chmod 600 /etc/postfix/sasl_passwd*
sudo systemctl restart postfix
```

## Test:
```bash
echo "Test Alert" | mail -s "Disk/Memory Monitor" yourgmail@gmail.com
```
---
once this is dne. Run the script with a lower threshold for checking purpose and you should see email as below :

<img width="500" height="316" alt="image" src="https://github.com/user-attachments/assets/a66fa682-5389-41c8-b9e4-a94e1d8ca2d6" />
<img width="500" height="316" alt="image" src="https://github.com/user-attachments/assets/9748d922-2849-482b-b2eb-81f7fa5dc15e" />





