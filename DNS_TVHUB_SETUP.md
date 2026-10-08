# TV Hub DNS Configuration for wise2.net

## DNS Records

Add these records to your wise2.net DNS:

```dns
Type    Name           Content              Priority
A       tvhub          YOUR_SERVER_IP       -
CNAME   www.tvhub      tvhub.wise2.net      -
```

Or as CNAME to main domain:
```dns
Type    Name           Content              Priority
CNAME   tvhub          wise2.net            -
```

## SSL Certificate

The wildcard certificate already covers:
```
*.wise2.net
```

So tvhub.wise2.net is already included!

Paths:
```
/etc/letsencrypt/live/wise2.net/fullchain.pem
/etc/letsencrypt/live/wise2.net/privkey.pem
```

## Verification

```bash
nslookup tvhub.wise2.net
dig tvhub.wise2.net

# Test SSL
curl -I https://tvhub.wise2.net
openssl s_client -connect tvhub.wise2.net:443
```

## NGINX Setup

```bash
# Copy config
sudo cp nginx-tvhub.conf /etc/nginx/sites-available/tvhub

# Enable site
sudo ln -s /etc/nginx/sites-available/tvhub /etc/nginx/sites-enabled/

# Test
sudo nginx -t

# Reload
sudo systemctl reload nginx
```

## URLs

- **TV Hub Display:** https://tvhub.wise2.net
- **Health Check:** https://tvhub.wise2.net/health
- **Live Content:** https://blakkhail.com (proxied through TV hub)
