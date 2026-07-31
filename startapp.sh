#!/bin/sh
cd /app 
umask "$UMASK"
exec su-exec "$PUID:$PGID" /app/squashfs-root/AppRun --no-sandbox
