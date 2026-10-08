#!/bin/bash
set -e

echo "🚀 Deploying WISE² to wise2.net"
echo ""

# Build
echo "📦 Building application..."
npm run build

# Create deployment package
echo "📦 Packaging..."
tar -czf wise2-deploy.tar.gz \
  dist/ \
  config/ \
  node_modules/ \
  docker-compose.prod.yml \
  nginx-wise2.conf

# Deploy
echo "📤 Uploading to server..."
scp wise2-deploy.tar.gz root@wise2.net:/opt/wise2/

echo "✅ Deployment package ready"
echo ""
echo "To complete deployment on server:"
echo "  ssh root@wise2.net"
echo "  cd /opt/wise2"
echo "  tar -xzf wise2-deploy.tar.gz"
echo "  docker-compose -f docker-compose.prod.yml up -d"
