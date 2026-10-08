#!/bin/bash

echo "📊 TV Hub Monitoring"
echo "════════════════════════════════════════"
echo ""

echo "🌐 DNS Resolution:"
nslookup tvhub.wise2.net
echo ""

echo "🔐 SSL Certificate:"
echo | openssl s_client -servername tvhub.wise2.net -connect tvhub.wise2.net:443 2>/dev/null | \
  openssl x509 -noout -dates -subject
echo ""

echo "⚡ HTTP/HTTPS Status:"
curl -I https://tvhub.wise2.net
echo ""

echo "❤️  Health Check:"
curl https://tvhub.wise2.net/health
echo ""

echo "📈 Performance:"
curl -w "\nTime to connect: %{time_connect}s\nTime to first byte: %{time_starttransfer}s\nTotal time: %{time_total}s\n" \
  -o /dev/null -s https://tvhub.wise2.net
echo ""

echo "✅ Monitoring complete"
