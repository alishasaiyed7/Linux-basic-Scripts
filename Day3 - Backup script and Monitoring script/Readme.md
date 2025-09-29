# 🖥️ Linux Backup & Disk Monitor Scripts

This repository contains **automation scripts** for:
1. Creating automated backups using `tar`, `gzip`, and `rsync`
2. Monitoring disk usage and sending alerts when thresholds are exceeded

---

## 📦 1. Backup Script (`backup.sh`)

### Features
- Backs up a given directory (`/home/ubuntu/data` by default)  change ubuntu to your user (eg ..john)
- Saves compressed `.tar.gz` archives to a backup folder
- Optionally syncs backups to a remote server using `rsync`
- Automatically deletes old backups (default: older than 7 days)

### How It Works
1. Creates a timestamped backup file → `backup_YYYY-MM-DD_HH-MM-SS.tar.gz`
2. Stores it inside `/home/ubuntu/backups`
3. Removes backups older than **7 days**
4. Can be scheduled with `cron` to run automatically

Script---

```bash
#!/bin/bash
# Backup Automation Script with Cleanup

## Note if it says no such directory or something.

sudo mkdir -p /home/ubuntu/data
## create a file inside it.
echo "hello backup " > /home/ubuntu/data/testfile.txt

# Variables
SOURCE_DIR="/home/ubuntu/data"       # Directory to back up ( change ubuntu to your username of faced error or run file as sudo ./backup.sh)
BACKUP_DIR="/home/ubuntu/backups"    # Local backup storage
REMOTE="user@remote:/backups"        # Optional remote backup location
RETENTION_DAYS=7                     # Keep backups for 7 days

DATE=$(date +%F_%H-%M-%S)
BACKUP_FILE="backup_$DATE.tar.gz"

echo "=== Backup Script Started ==="

# 1. Ensure backup directory exists
mkdir -p $BACKUP_DIR

# 2. Create compressed backup
echo "🔹 Creating archive..."
tar -czf $BACKUP_DIR/$BACKUP_FILE $SOURCE_DIR
echo "✅ Backup created: $BACKUP_DIR/$BACKUP_FILE"

# 3. (Optional) Sync with remote server
# Uncomment if you have SSH access to a remote backup server
# echo "🔹 Syncing to remote..."
# rsync -avz $BACKUP_DIR/$BACKUP_FILE $REMOTE

#4. In case original file deleted and you want to restore from backup.
# go to /home/ubuntu/backups/backup_2025-10-......
tar -xzf /home/alisha/backups/backup-2025-09-22-14-10-00.tar.gz -C / home/ubuntu/data/testfile.txt
#go to orginal path and check if restore or not.

# 5 . Cleanup old backups
echo "🔹 Cleaning up backups older than $RETENTION_DAYS days..."
find $BACKUP_DIR -type f -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

echo "✅ Cleanup complete."
echo "=== Backup Completed Successfully ==="
```

## make script executable 
```bash
sudo chmod +x backup.sh
```

## run the script
```bash
./backup.sh
sudo ./backup.sh
```

Note - Everytime you need to backup a file, just change the source dir and file and sun the script. 
This will save your time and is easy to backup and restore by just a single script

---

## AUTHOR
Name - Saiyed Alisha
Designation - System Admin | AWS
