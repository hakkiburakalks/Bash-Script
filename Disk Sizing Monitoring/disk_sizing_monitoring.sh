#!/bin/bash
# Author: Burak Alkis
# Date: 12.03.2025
# Zabbix'in bulunduğu file'in saatte 1 disk size konusunu incelemek için yazılmıştır.
LOGFILE="/var/log/pgsql_directory_size.log"
WATCH_PATH="/var/lib/pgsql"

while true; do
    echo "$(date): $(du -sh $WATCH_PATH)" >> $LOGFILE
    sleep 3600
done
