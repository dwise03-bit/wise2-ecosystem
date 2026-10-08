#!/bin/bash
set -e

echo "🚀 Deploying TV Hub to wise2.net"
echo ""

DOMAIN="tvhub.wise2.net"
SERVER="root@wise2.net"

# Build
echo "📦 Building TV Hub..."
docker build -t tvhub:latest .

# Prepare deployment
echo "📦 Preparing deployment..."
tar -czf tvhub-deploy.tar.gz \
  tvhub-blakkhail.html \
  nginx-tvhub.conf \
  docker-compose.tvhub.yml \
  Dockerfile

# Upload
echo "📤 Uploading to server..."
scp tvhub-deploy.tar.gz $SERVER:/opt/wise2/

# Deploy
echo "🔧 Deploying on server..."
ssh $SERVER << 'DEPLOY'
  cd /opt/wise2
  tar -xzf tvhub-deploy.tar.gz
  docker-compose -f docker-compose.tvhub.yml up -d
  docker-compose -f docker-compose.tvhub.yml exec app npm start
DEPLOY

echo ""
echo "✅ Deployment complete!"
echo ""
echo "🌐 Access at:"
echo "   https://tvhub.wise2.net"
echo ""
echo "📊 Health check:"
echo "   https://tvhub.wise2.net/health"
echo ""

# Cleanup
rm tvhub-deploy.tar.gz
