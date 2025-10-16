## 🧠 Project: Automated MySQL Backup with Cron & Email Alerts
## Purpose

This project automates daily MySQL database backups and notifies you via email if a backup fails.
It helps ensure your data is safe, consistent, and recoverable without manual effort.

You can also add a cleanup automation to remove old files (over 30 days) to save disk space.

## ⚙️ What This Script Does

Takes MySQL database backup automatically.\
Creates a new folder (if not already present) to store backups.\
Logs backup activity.\
Sends email alerts if a backup fails / pass.\
Can be scheduled via cron job to run daily or weekly.

## 🧩 Script Path
/usr/local/bin/testdb_mail_backup.sh

## 🧾 Script Explanation
🔹 Variables
```bash
DB_NAME=testdb             # Database name to back up
DB_USER=alisha             # MySQL username
DB_PASS=********           # MySQL password
BACKUP_DIR=/backups/testdb # Backup location
DATE=$(date +%Y-%m-%d_%H-%M-%S)  # Timestamp for unique filenames
BACKUP_FILE=$BACKUP_DIR/${DB_NAME}_${DATE}.sql  #file format
LOG_FILE=/var/log/db_backup.log  # Log file for backup operations
EMAIL=alishas**********@gmail.com # Email for failure alerts
```
👉 These variables define all dynamic parts of the script — DB details, paths, and logging.

## 🔹 Creating Backup Directory
```bash
mkdir -p $BACKUP_DIR
```
👉 -p ensures that if the directory doesn’t exist, it will be created automatically.\
Prevents “No such file or directory” errors.

## 🔹 Dump the Database
```bash
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE
```
👉 mysqldump exports your entire database into a .sql file.\
If this fails, the script triggers an email alert.

## 🔹 Log the Status
```bash
if mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE" 2>>"$LOG_FILE"; then
    gzip "$BACKUP_FILE"
    find "$BACKUP_DIR" -type f -name "*.gz" -mtime +7 -delete
    echo "$(date): ✅ Backup successful for $DB_NAME" | tee -a "$LOG_FILE" | mail -s "✅ MySQL Backup Successful: $DB_NAME" "$EMAIL"
else
    echo "$(date): ❌ Backup FAILED for $DB_NAME" | tee -a "$LOG_FILE" | mail -s "❌ MySQL Backup FAILED: $DB_NAME" "$EMAIL"
fi
```

## 🔹 Add to Cron for Automation
Edit cron:
``bash
sudo crontab -e
```
Add:
```bash
0 2 * * * /usr/local/bin/testdb_mail_backup.sh
```
👉 Runs backup daily at 2 AM.
Section	Meaning
| Section                               | Meaning                                                                                                     |
| ------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `0`                                   | **Minute** → The job will start at minute 0                                                                 |
| `2`                                   | **Hour** → The job will start at hour 2 (2:00 AM)                                                           |
| `*`                                   | **Day of month** → Every day of the month                                                                   |
| `*`                                   | **Month** → Every month                                                                                     |
| `*`                                   | **Day of week** → Every day (Mon–Sun)                                                                       |
| `/usr/local/bin/company_db_backup.sh` | The **script** to be executed — this is your database backup script                                         |
| `>/dev/null 2>&1`                     | **Redirects all output (stdout and stderr) to /dev/null**, meaning no output or errors are logged or mailed |


## Give Execute Permission
```bash
sudo chmod +x /usr/local/bin/company_db_backup.sh
```
## Test the Script Manually
```bash
sudo /usr/local/bin/company_db_backup.sh
ls /backups/company
```

## Run the script:
```bash
sudo bash -x /usr/local/bin/testdb_mail_backup.sh
```

✅ You should see something like:
```bash
testdb_2025-10-16_09-30-00.sql.gz
```

## If you want to setup Email Alerts:
## 📧 Check if Email Alert Works

1️⃣ Install mail utilities:
```bash
sudo apt install mailutils -y
```
2️⃣ Test manually:
```bash
echo "Test mail from backup script" | mail -s "Test Mail" yourmail@gmail.com
```
Check inbox/spam.
If using Gmail, make sure “Less Secure Apps” (or App Passwords) are configured for external mail use.

## 🔍 Verify Backup

Check backup folder:
```bash
ls -lh /backups/testdb
```

View latest log:
```bash
cat /var/log/db_backup.log
```

## 🧠 Why We Did This

| Step                   | Purpose                                        |
| ---------------------- | ---------------------------------------------- |
| Automate MySQL backups | Avoid manual daily DB dumps                    |
| Timestamped filenames  | Keep history & prevent overwriting             |
| Logs                   | Track success/failure                          |
| Email alerts           | Get notified instantly if something goes wrong |
| Cron                   | Schedule backups automatically                 |
| Cleanup                | Save disk space & maintain hygiene             |


✅ Example Output (Success)
Thu Oct 16 02:00:01 UTC 2025: Backup successful for testdb

❌ Example Output (Failure)
Thu Oct 16 02:00:01 UTC 2025: Backup failed for testdb
Mail sent to: alisha*****@gmail.com

---

## If MySQL is not installed follow the steps to install.

1️⃣Install MySQL Server
```bash
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql
sudo systemctl status mysql   ( should be running)
sudo mysql_secure_installation
```

2️⃣ Then log in:
```bash
sudo mysql -u root -p
```

3️⃣ Create a Database and Table
```bash
CREATE DATABASE company;
USE company;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
```
4️⃣Insert Sample Data
 ```bash
INSERT INTO employees (name, department, salary)
VALUES 
('Alisha', 'IT', 55000),
('Ravi', 'HR', 48000),
('Priya', 'Finance', 60000),
('Aman', 'DevOps', 70000);
```

View the Data
```bash
SELECT * FROM employees;  ( database should be visible)
```

Note - if it throws error like MySQL backup failed Check with below.
## Confirm That the Database Exists
Run:
```bash
sudo mysql -u alisha -pRoot123 -e "SHOW DATABASES;"
```


## To Setup Email (Gmail)
1️⃣Install
```bash
sudo apt install postfix libsasl2modules
```
2️⃣ Edit :
```bash
sudo nano /etc/postfix/main.cf
```
Add :
```bash
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_sasl_security_options = noanonymous
smtp_use_tls = yes
```

3️⃣Then create credentials file:
```bash
sudo nano /etc/postfix/sasl_passwd
```
Add:
```bash
[smtp.gmail.com]:587 yourgmail@gmail.com:your_app_password
```

Then:
```bash
sudo postmap /etc/postfix/sasl_passwd
sudo chmod 600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
sudo systemctl restart postfix
```

# Checking mail log 
```bash
sudo /var/log/mail.log
```

---

## AUTHOR
NAME - Saiyed Alisha\
Designation - System Admin|AWS














