#!/bin/bash
# Mongodb Backup script
DB_USER="admin"
DB_PASSWORD="xyz"
DB_HOST="localhost"
DB_PORT="27017"
DB="mydb"
BACKUP_DIR=~/backups/helena-demo


mongodump -h $DB_HOST --port $DB_PORT -u $DB_USER -p $DB_PASSWORD --db $DB --out $BACKUP_DIR/`date +"%Y%m%d%H%M"`
