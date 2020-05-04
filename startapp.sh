#!/bin/sh
cd /app 
USER=appuser 
HOME="/app"
exec /app/squashfs-root/joplin --no-sandbox
