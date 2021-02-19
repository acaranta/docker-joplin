#!/bin/sh
cd /app 
USER=appuser 
HOME="/app"
exec /app/squashfs-root/AppRun --no-sandbox
