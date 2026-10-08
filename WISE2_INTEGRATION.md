# WISE² Ecosystem → wise2.net Integration Guide

## Domain Architecture

```
wise2.net                           Main portal & docs
├── app.wise2.net                   Main application
├── ai.wise2.net                    AI tools & chat
├── trade.wise2.net                 Trading dashboard
├── games.wise2.net                 VR/Games platform
├── 3d.wise2.net                    3D modeling & printing
├── mobile.wise2.net                Mobile apps
├── api.wise2.net                   REST API gateway
├── docs.wise2.net                  API documentation
└── admin.wise2.net                 Admin panel
```

## DNS Configuration

```dns
# Root domain
wise2.net.          A       YOUR_IP_ADDRESS
www.wise2.net.      CNAME   wise2.net

# Subdomains
app.wise2.net.      A       YOUR_IP_ADDRESS
ai.wise2.net.       A       YOUR_IP_ADDRESS
trade.wise2.net.    A       YOUR_IP_ADDRESS
games.wise2.net.    A       YOUR_IP_ADDRESS
3d.wise2.net.       A       YOUR_IP_ADDRESS
mobile.wise2.net.   A       YOUR_IP_ADDRESS
api.wise2.net.      A       YOUR_IP_ADDRESS
docs.wise2.net.     A       YOUR_IP_ADDRESS
admin.wise2.net.    A       YOUR_IP_ADDRESS

# Email
mail.wise2.net.     MX      10 mail.wise2.net
mail.wise2.net.     A       YOUR_IP_ADDRESS

# SSL verification
wise2.net.          TXT     "v=spf1 include:sendgrid.net ~all"
_dmarc.wise2.net.   TXT     "v=DMARC1; p=quarantine"
```

## SSL/TLS Certificates

Get wildcard certificate for *.wise2.net:
```bash
certbot certonly --dns-cloudflare \
  -d wise2.net \
  -d "*.wise2.net" \
  -d app.wise2.net
```

## Load Balancer Configuration

All subdomains → NGINX load balancer → Services
