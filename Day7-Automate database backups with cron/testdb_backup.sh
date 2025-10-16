#!/bin/bash

## Database details

DB_NAME="testdb"
DB_USER="root"
DB_PASS="Your password"
BACKUP_DIR="/backups/testdb"
DATE=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$DATE.sql"  #format for saving a file.
LOG_FILE="/var/log/db_backup.log"
EMAIL="your_email@example.com"   # replace this // (optional) used only when you want to receive alerts on mail.


# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Take backup
if mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE" 2>>"$LOG_FILE"; then
    gzip "$BACKUP_FILE"
    find "$BACKUP_DIR" -type f -name "*.gz" -mtime +7 -delete
    echo "$(date):  Backup successful for $DB_NAME" | tee -a "$LOG_FILE" | mail -s "MySQL Backup Successful: $DB_NAME" "$EMAIL"
else
    echo "$(date):  Backup FAILED for $DB_NAME" | tee -a "$LOG_FILE" | mail -s  "MySQL Backup FAILED: $DB_NAME" "$EMAIL"
fi