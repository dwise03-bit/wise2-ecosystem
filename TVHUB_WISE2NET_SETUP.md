# TV Hub on wise2.net - Complete Setup Guide

## Overview

Host the WISE² TV Hub displaying blakkhail.com on your wise2.net domain as `tvhub.wise2.net`.

## Architecture

```
User Browser
    ↓
https://tvhub.wise2.net (HTTPS, SSL secured)
    ↓
NGINX Load Balancer (Port 443)
    ↓
HTTP Backend (localhost:3000)
    ↓
Display: https://blakkhail.com
```

## Prerequisites

- ✅ wise2.net domain registered
- ✅ SSL certificate for *.wise2.net
- ✅ NGINX installed
- ✅ Docker installed
- ✅ tvhub-blakkhail.html file ready

## Step 1: DNS Configuration

Add to your registrar:

```
Type    Name     Content
A       tvhub    YOUR_SERVER_IP
```

Or use CNAME:
```
Type    Name     Content
CNAME   tvhub    wise2.net
```

Verify:
```bash
nslookup tvhub.wise2.net
```

## Step 2: SSL Certificate

Already covered by wildcard *.wise2.net

Paths:
```
/etc/letsencrypt/live/wise2.net/fullchain.pem
/etc/letsencrypt/live/wise2.net/privkey.pem
```

## Step 3: NGINX Setup

```bash
# Copy configuration
sudo cp nginx-tvhub.conf /etc/nginx/sites-available/tvhub

# Enable site
sudo ln -s /etc/nginx/sites-available/tvhub /etc/nginx/sites-enabled/

# Test configuration
sudo nginx -t

# Reload NGINX
sudo systemctl reload nginx
```

## Step 4: Deploy

### Option A: Manual Deployment

```bash
# Ensure HTTP server is running
python3 -m http.server 3000 --bind 127.0.0.1 &

# Start NGINX
sudo systemctl start nginx

# Access at https://tvhub.wise2.net
```

### Option B: Docker Deployment

```bash
docker-compose -f docker-compose.tvhub.yml up -d
sudo systemctl reload nginx
```

### Option C: Automated Script

```bash
./deploy-tvhub.sh
```

## Step 5: Verification

```bash
# Test SSL
curl -I https://tvhub.wise2.net

# Check health
curl https://tvhub.wise2.net/health

# Monitor
./monitor-tvhub.sh
```

## URLs After Deployment

| URL | Purpose |
|-----|---------|
| `https://tvhub.wise2.net` | Main TV Hub display |
| `https://tvhub.wise2.net/health` | Health check endpoint |
| `https://blakkhail.com` | Live content (proxied) |

## Maintenance

### Check SSL Certificate Expiry

```bash
echo | openssl s_client -servername tvhub.wise2.net -connect tvhub.wise2.net:443 2>/dev/null | \
  openssl x509 -noout -dates
```

### View NGINX Logs

```bash
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Monitor Performance

```bash
# Real-time monitoring
./monitor-tvhub.sh

# Watch NGINX status
watch -n 1 'curl -s https://tvhub.wise2.net/health'
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| DNS not resolving | Wait 24-48 hours, or check registrar settings |
| SSL certificate error | Verify certificate path in nginx.conf |
| 502 Bad Gateway | Check if HTTP server is running on 3000 |
| Connection refused | Verify NGINX is running and listening |

## Performance Targets

- ✅ Page load: <2s
- ✅ SSL grade: A+
- ✅ Uptime: 99.9%
- ✅ Response time: <200ms

## Backup & Recovery

```bash
# Backup configuration
sudo cp /etc/nginx/sites-available/tvhub ~/tvhub-nginx.conf.bak

# Restore
sudo cp ~/tvhub-nginx.conf.bak /etc/nginx/sites-available/tvhub
sudo systemctl reload nginx
```

## Security Checklist

- ✅ HTTPS only (HTTP redirects)
- ✅ Security headers configured
- ✅ HSTS enabled
- ✅ Frame options set (SAMEORIGIN)
- ✅ XSS protection enabled
- ✅ Content-Type options set

---

**Your TV Hub is ready to broadcast on wise2.net! 🚀**
