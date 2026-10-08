# wise2.net DNS Configuration

## Add these DNS records to your registrar:

### Root Domain
```
Type    Name           Content              Priority
A       @              YOUR_SERVER_IP       -
CNAME   www            wise2.net            -
```

### Subdomains (point to same IP)
```
Type    Name           Content              Priority
A       app            YOUR_SERVER_IP       -
A       api            YOUR_SERVER_IP       -
A       ai             YOUR_SERVER_IP       -
A       trade          YOUR_SERVER_IP       -
A       games          YOUR_SERVER_IP       -
A       vr             YOUR_SERVER_IP       -
A       3d             YOUR_SERVER_IP       -
A       docs           YOUR_SERVER_IP       -
A       admin          YOUR_SERVER_IP       -
```

### Email (if needed)
```
Type    Name           Content              Priority
MX      @              mail.wise2.net       10
A       mail           YOUR_SERVER_IP       -
```

### SSL Verification
```
Type    Name           Content
TXT     @              v=spf1 include:_spf.google.com ~all
TXT     _dmarc         v=DMARC1; p=quarantine
```

## Get SSL Certificate
```bash
sudo certbot certonly --dns-cloudflare \
  -d wise2.net \
  -d "*.wise2.net" \
  --email admin@wise2.net
```

## Verify
```bash
nslookup wise2.net
nslookup api.wise2.net
curl -I https://wise2.net
```
