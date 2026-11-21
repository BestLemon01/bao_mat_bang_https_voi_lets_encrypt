#!/bin/bash
# ==============================================================================
# Cài đặt Certbot và cấp chứng chỉ SSL/TLS Let's Encrypt cho Nginx trên Ubuntu
# ==============================================================================
set -e

echo "=== 1. Cập nhật apt và cài đặt Certbot + plugin Nginx ==="
sudo apt update
sudo apt install -y certbot python3-certbot-nginx

echo "=== 2. Cấp chứng chỉ SSL tự động và cấu hình Nginx ==="
sudo certbot --nginx -d api.my-ecommerce.com --non-interactive --agree-tos -m admin@my-ecommerce.com --redirect

echo "=== 3. Kiểm tra thử quá trình tự động gia hạn (Dry-run) ==="
sudo certbot renew --dry-run

echo "=== 4. Kiểm tra trạng thái Systemd Timer tự động gia hạn ==="
sudo systemctl status certbot.timer --no-pager
