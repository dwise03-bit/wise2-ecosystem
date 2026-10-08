# WISE² → wise2.net Deployment Guide

## Overview

Complete integration of the WISE² Ecosystem with your wise2.net domain. All 25+ applications accessible via branded subdomains.

---

## Domain Architecture

```
wise2.net/                    Main portal
├── app.wise2.net             Full application
├── api.wise2.net             REST API (8000)
├── ai.wise2.net              AI Chat & tools
├── trade.wise2.net           Trading dashboard
├── games.wise2.net           VR & games
├── vr.wise2.net              WebXR experience
├── 3d.wise2.net              3D modeling
├── docs.wise2.net            API documentation
└── status.wise2.net          System status page
```

---

## Prerequisites

- ✅ wise2.net domain registered
- ✅ VPS/Cloud server (2GB+ RAM, 20GB+ disk)
- ✅ Docker & Docker Compose installed
- ✅ NGINX installed
- ✅ PostgreSQL 13+ (or use Docker)
- ✅ Redis (or use Docker)

---

## Step 1: DNS Configuration

Update your domain registrar with these records:

### A Records (point to server IP)
```dns
wise2.net              A    123.45.67.89
*.wise2.net            A    123.45.67.89
```

### Individual Subdomains (optional, for clarity)
```dns
app.wise2.net          A    123.45.67.89
api.wise2.net          A    123.45.67.89
ai.wise2.net           A    123.45.67.89
trade.wise2.net        A    123.45.67.89
games.wise2.net        A    123.45.67.89
vr.wise2.net           A    123.45.67.89
3d.wise2.net           A    123.45.67.89
docs.wise2.net         A    123.45.67.89
status.wise2.net       A    123.45.67.89
```

**Verify DNS:**
```bash
nslookup wise2.net
nslookup api.wise2.net
```

---

## Step 2: SSL Certificate Setup

```bash
# Install Certbot
sudo apt-get install certbot python3-certbot-nginx

# Get wildcard certificate
sudo certbot certonly --manual \
  -d wise2.net \
  -d "*.wise2.net"

# Or use DNS provider (recommended)
sudo certbot certonly --dns-cloudflare \
  -d wise2.net \
  -d "*.wise2.net"
```

**Certificate paths:**
```
/etc/letsencrypt/live/wise2.net/fullchain.pem
/etc/letsencrypt/live/wise2.net/privkey.pem
```

---

## Step 3: Configure Environment

```bash
# Clone repository
git clone https://github.com/yourusername/wise2-ecosystem.git
cd wise2-ecosystem

# Setup environment
cp .env.production .env
nano .env  # Edit with your values
```

**Critical settings:**
```env
DOMAIN=wise2.net
API_URL=https://api.wise2.net
DB_PASSWORD=strong_password_here
JWT_SECRET=long_random_string_here
NODE_ENV=production
```

---

## Step 4: Deploy Stack

```bash
# Build Docker images
docker build -t wise2-app:latest .
docker build -f Dockerfile.api -t wise2-api:latest .

# Start production stack
docker-compose -f docker-compose.prod.yml up -d

# Verify services
docker-compose ps
docker logs wise2-app
docker logs wise2-api
```

**Check health:**
```bash
curl https://api.wise2.net/health
curl https://wise2.net/health
```

---

## Step 5: Configure NGINX

```bash
# Copy NGINX config
sudo cp nginx-wise2.conf /etc/nginx/sites-available/wise2

# Enable site
sudo ln -s /etc/nginx/sites-available/wise2 /etc/nginx/sites-enabled/

# Test config
sudo nginx -t

# Reload
sudo systemctl reload nginx
```

---

## Step 6: Database Setup

```bash
# Initialize database
docker exec wise2-db psql -U wise2 -d wise2_prod -f ./database/schema.sql

# Run migrations
docker exec wise2-app npm run migrate

# Verify
docker exec wise2-db psql -U wise2 -d wise2_prod -c "\dt"
```

---

## Step 7: System Health Check

### Service Availability
```bash
# Test each subdomain
curl -I https://wise2.net              # Main app
curl -I https://api.wise2.net/health   # API gateway
curl -I https://ai.wise2.net           # AI tools
curl -I https://trade.wise2.net        # Trading
curl -I https://games.wise2.net        # Games
curl -I https://vr.wise2.net           # VR
curl -I https://3d.wise2.net           # 3D
```

### Performance Check
```bash
# Load test
ab -n 1000 -c 10 https://wise2.net/

# SSL check
curl -I --tlsv1.2 https://wise2.net

# Certificate validation
openssl s_client -connect wise2.net:443 -showcerts
```

---

## Monitoring & Maintenance

### Health Monitoring
```bash
# Check service status
curl https://wise2.net/status.html

# API metrics
curl https://api.wise2.net/metrics

# Database connection
docker exec wise2-db pg_isready -U wise2
```

### Log Monitoring
```bash
# View application logs
docker logs -f wise2-app

# View API logs
docker logs -f wise2-api

# NGINX logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### SSL Certificate Renewal
```bash
# Check expiration
sudo certbot certificates

# Renew (auto with docker-compose)
docker-compose exec certbot renew

# Or manual
sudo certbot renew
```

---

## Backup & Recovery

### Backup Database
```bash
docker exec wise2-db pg_dump -U wise2 wise2_prod > backup.sql
```

### Backup Everything
```bash
tar -czf wise2-backup-$(date +%Y%m%d).tar.gz \
  config/ \
  /etc/letsencrypt/ \
  /var/lib/docker/volumes/
```

### Restore Database
```bash
docker exec -i wise2-db psql -U wise2 wise2_prod < backup.sql
```

---

## Auto-scaling & Load Balancing

### Docker Swarm
```bash
docker swarm init
docker deploy -c docker-compose.prod.yml wise2
```

### Kubernetes
```bash
kubectl apply -f k8s/
kubectl get pods
kubectl logs -f deployment/wise2-app
```

### Traffic Distribution
- NGINX handles requests on port 80/443
- Routes to Docker services based on hostname
- Connection pooling for efficiency

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| 502 Bad Gateway | Check Docker service: `docker ps` |
| Certificate expired | Run `certbot renew` |
| Database connection error | Verify `DB_HOST` in `.env` |
| High memory usage | `docker stats` to identify service |
| Slow API response | Check database indexes, enable Redis cache |
| DNS not resolving | Wait 24-48 hours for propagation |

---

## Performance Optimization

### Caching
```bash
# Redis cache enabled
REDIS_URL=redis://redis:6379

# Browser caching headers
Cache-Control: max-age=3600
```

### Compression
```nginx
gzip on;
gzip_types text/plain text/css application/json;
```

### CDN (CloudFlare recommended)
- Point nameservers to CloudFlare
- Enable caching, minification
- Setup security rules

---

## Security Checklist

- ✅ SSL/TLS enabled (HTTPS only)
- ✅ Security headers configured
- ✅ Rate limiting enabled
- ✅ CORS properly configured
- ✅ Environment variables protected
- ✅ Database backups scheduled
- ✅ Logs monitored for attacks
- ✅ Regular updates scheduled

---

## Automated Deployment

### GitHub Actions CI/CD
```bash
# Push triggers:
git push origin main  # → Runs tests → Builds → Deploys
```

### Automatic Updates
```bash
# Scheduled weekly
docker pull wise2-app:latest
docker-compose up -d --no-deps --build
```

---

## Support Resources

- **Logs:** `docker logs <container>`
- **Database:** `docker exec wise2-db psql`
- **Metrics:** `https://api.wise2.net/metrics`
- **Status:** `https://status.wise2.net`
- **Docs:** `https://docs.wise2.net`

---

## Success Indicators

✅ All subdomains responding (200 OK)  
✅ SSL certificates valid (30+ days)  
✅ Database connected  
✅ API latency < 200ms  
✅ No errors in logs  
✅ Health checks passing  

---

**Deployment complete! 🚀 Your WISE² Ecosystem is now live at wise2.net**
