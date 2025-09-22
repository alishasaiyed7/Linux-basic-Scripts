#!/bin/bash
# Backup Automation Script with Cleanup

# Variables
SOURCE_DIR="/home/ubuntu/data"       # Directory to back up (change ubuntu to your user or run as sudo)
BACKUP_DIR="/home/ubuntu/backups"    # Local backup storage  (change ubuntu to your user or run as sudo)
REMOTE="user@remote:/backups"        # Optional remote backup location
RETENTION_DAYS=7                     # Keep backups for 7 days

DATE=$(date +%F_%H-%M-%S)
BACKUP_FILE="backup_$DATE.tar.gz"

echo "=== Backup Script Started ==="

# 1. Ensure backup directory exists
sudo mkdir -p $BACKUP_DIR

# 2. Create compressed backup
echo "🔹 Creating archive..."
tar -czf $BACKUP_DIR/$BACKUP_FILE $SOURCE_DIR
echo "✅ Backup created: $BACKUP_DIR/$BACKUP_FILE"

# 3. (Optional) Sync with remote server
# Uncomment if you have SSH access to a remote backup server
# echo "🔹 Syncing to remote..."
# rsync -avz $BACKUP_DIR/$BACKUP_FILE $REMOTE

# 4. Cleanup old backups
echo "🔹 Cleaning up backups older than $RETENTION_DAYS days..."
find $BACKUP_DIR -type f -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

echo "✅ Cleanup complete."
echo "=== Backup Completed Successfully ==="
