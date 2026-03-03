#!/bin/bash
# Deploy panel + nginx config to 52.54.172.121
# Need SSH key access first: ssh-copy-id ubuntu@52.54.172.121  (or root@ / ec2-user@)
# Usage: ./server/deploy-to-server.sh   or   REMOTE=root@52.54.172.121 ./server/deploy-to-server.sh
set -e
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REMOTE="${REMOTE:-ubuntu@52.54.172.121}"
SSH_OPTS="-o ConnectTimeout=10 -o StrictHostKeyChecking=accept-new"

echo "→ Deploying to $REMOTE (from $REPO_ROOT)"
echo "  (If 'Permission denied', run: ssh-copy-id $REMOTE)"

# Copy nginx config and dashboard
scp $SSH_OPTS "$REPO_ROOT/server/nginx.conf" "$REMOTE:/tmp/olempic-nginx.conf"
scp $SSH_OPTS "$REPO_ROOT/dashboard.html" "$REMOTE:/tmp/dashboard.html"

# On server: install nginx if missing, create dir, copy files, enable site, reload
ssh $SSH_OPTS "$REMOTE" bash -s << 'REMOTE_SCRIPT'
set -e
sudo apt-get update -qq 2>/dev/null || true
command -v nginx >/dev/null 2>&1 || sudo apt-get install -y nginx
sudo mkdir -p /var/www/olempic-panel
sudo cp /tmp/dashboard.html /var/www/olempic-panel/
sudo cp /tmp/olempic-nginx.conf /etc/nginx/sites-available/olempic
sudo ln -sf /etc/nginx/sites-available/olempic /etc/nginx/sites-enabled/
# Disable default site if it exists and conflicts
sudo rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true
sudo nginx -t && sudo systemctl reload nginx
echo "✓ NGINX reloaded. Panel: http://52.54.172.121/  API: http://52.54.172.121/api/"
REMOTE_SCRIPT

echo "✓ Deploy done."
