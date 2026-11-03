#!/usr/bin/env bash
# automation-script.sh — Daily DB backup + health check
# Runs via cron at 02:00. Logs to /var/log/wp-backup.log

set -euo pipefail

BACKUP_DIR="/home/architect/backups"
LOG_FILE="/var/log/wp-backup.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
CONTAINER="wp-mysql"
DB_NAME="wordpress"
RETENTION_DAYS=7

mkdir -p "$BACKUP_DIR"

log() { echo "[$(date '+%F %T')] $*" | tee -a "$LOG_FILE"; }

log "=== Backup job started ==="

# ---- 1. Health check ----
if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER}$"; then
    log "ERROR: Container $CONTAINER not running. Aborting."
    exit 1
fi
log "Health check: $CONTAINER is running."

# ---- 2. Database dump (read password from .env) ----
source /home/architect/enterprise-cloud/.env
BACKUP_FILE="${BACKUP_DIR}/wordpress_${TIMESTAMP}.sql.gz"

if docker exec "$CONTAINER" \
     mysqldump -u root -p"${MYSQL_ROOT_PASSWORD}" "$DB_NAME" 2>/dev/null \
     | gzip > "$BACKUP_FILE"; then
    log "Backup created: $BACKUP_FILE ($(du -h "$BACKUP_FILE" | cut -f1))"
else
    log "ERROR: mysqldump failed."
    exit 1
fi

# ---- 3. Rotate old backups ----
DELETED=$(find "$BACKUP_DIR" -name 'wordpress_*.sql.gz' -mtime +${RETENTION_DAYS} -print -delete | wc -l)
log "Rotation: removed $DELETED backup(s) older than ${RETENTION_DAYS} days."

log "=== Backup job finished OK ==="