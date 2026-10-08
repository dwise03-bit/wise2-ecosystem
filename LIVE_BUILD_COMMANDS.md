# WISE² Live Build Spot - Quick Commands

## Status & Monitoring

```bash
# Full status report
./live-status.sh

# View dashboard
open live-dashboard.html

# Check specific service
ps aux | grep http.server
ps aux | grep node
```

## Build & Deploy

```bash
# Full build pipeline
./build-pipeline.sh

# Deploy all services
./live-deploy.sh

# Build core monorepo
cd wise2-core && npm run build

# Development mode
npm run dev
```

## Access

```bash
# Local
http://localhost:3000

# wise2.net
https://wise2.net
https://tvhub.wise2.net

# TV Hub
https://tvhub.wise2.net
```

## Repository Management

```bash
# Git status
git status

# View commits
git log --oneline -10

# Check remotes
git remote -v
```

## Maintenance

```bash
# Backup current state
tar -czf backups/backup-$(date +%s).tar.gz .

# View logs
tail -f logs/build-*.log
tail -f logs/deploy-*.log

# Clean build cache
rm -rf .build-cache/*
```

## Service Control

```bash
# Start HTTP server
python3 -m http.server 3000 --bind 127.0.0.1 &

# Start core dev
cd wise2-core && npm run dev

# Full stack
./live-deploy.sh
```

## Monitoring

```bash
# Watch status
watch -n 5 './live-status.sh'

# Monitor logs
tail -f logs/*.log

# Performance check
curl -I http://localhost:3000
curl -I https://tvhub.wise2.net
```
