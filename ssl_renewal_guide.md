# BẢO MẬT HTTPS VỚI LET'S ENCRYPT VÀ TỰ ĐỘNG GIA HẠN (AUTO-RENEW)

## 1. Lệnh cài đặt và cấp phát SSL
```bash
sudo apt update && sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d api.my-ecommerce.com
```

## 2. Cơ chế tự động gia hạn chứng chỉ sau mỗi 90 ngày
Chứng chỉ của Let's Encrypt có thời hạn tối đa 90 ngày. Trên Ubuntu hiện đại, gói `certbot` tự động tạo **Systemd Timer** (`certbot.timer`) chạy 2 lần/ngày để kiểm tra chứng chỉ sắp hết hạn (< 30 ngày) và tự gia hạn.

Ngoài ra, có thể thiết lập **Cronjob** thủ công qua `sudo crontab -e`:
```cron
# Chạy lúc 03:00 sáng mỗi ngày, gia hạn ngầm và reload Nginx nếu có cert mới
0 3 * * * /usr/bin/certbot renew --quiet --post-hook "systemctl reload nginx"
```
Kiểm tra trước bằng lệnh: `sudo certbot renew --dry-run`.
