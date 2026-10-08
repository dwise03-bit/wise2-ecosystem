#!/bin/bash

echo "📊 WISE² System Monitoring"
echo ""

# Check services
echo "🔍 Checking services..."
curl -s https://api.wise2.net/health | jq .
curl -s https://wise2.net/health | jq .

# Check SSL
echo ""
echo "🔐 SSL Certificate Status"
echo | openssl s_client -servername wise2.net -connect wise2.net:443 2>/dev/null | openssl x509 -noout -dates

# Check DNS
echo ""
echo "🌐 DNS Resolution"
nslookup wise2.net
nslookup api.wise2.net
nslookup ai.wise2.net

# Performance
echo ""
echo "⚡ Performance Metrics"
curl -s https://api.wise2.net/metrics | jq .
