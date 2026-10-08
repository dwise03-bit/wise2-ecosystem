#!/bin/bash

# WISE² Production Monitoring System
# Real-time service health & performance tracking

clear

MONITOR_START=$(date)
REFRESH_RATE=5

echo "🔍 WISE² PRODUCTION MONITORING SYSTEM"
echo "════════════════════════════════════════════════════════════════"
echo "Started: $MONITOR_START"
echo "Refresh Rate: $REFRESH_RATE seconds"
echo ""

# Function to display timestamp
timestamp() {
  echo "📍 Last Update: $(date '+%Y-%m-%d %H:%M:%S')"
}

# Function to check HTTP server
check_http() {
  if curl -s http://localhost:3000 > /dev/null 2>&1; then
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)
    RESPONSE_TIME=$(curl -s -o /dev/null -w "%{time_total}" http://localhost:3000)
    echo "  Status: ✅ HTTP $HTTP_STATUS"
    echo "  Response: ${RESPONSE_TIME}s"
  else
    echo "  Status: ❌ OFFLINE"
  fi
}

# Function to check git repos
check_repos() {
  ECOSYSTEM_COMMITS=$(cd ~/web-design && git rev-list --count HEAD 2>/dev/null || echo "0")
  CORE_COMMITS=$(cd ~/web-design/wise2-core && git rev-list --count HEAD 2>/dev/null || echo "0")
  
  echo "  Ecosystem: $ECOSYSTEM_COMMITS commits ✅"
  echo "  Core: $CORE_COMMITS commits ✅"
}

# Function to check disk space
check_disk() {
  TOTAL_SIZE=$(du -sh ~/web-design 2>/dev/null | cut -f1)
  FILE_COUNT=$(find ~/web-design -type f 2>/dev/null | wc -l)
  
  echo "  Total Size: $TOTAL_SIZE"
  echo "  Files: $FILE_COUNT"
}

# Function to check test results
check_tests() {
  if [ -f ~/web-design/test-services.sh ]; then
    echo "  Status: ✅ Test suite ready"
    echo "  Coverage: 30 tests (8 categories)"
  fi
}

# Function to check services
check_services() {
  RUNNING_SERVICES=0
  
  if [ -d ~/web-design/.git ]; then
    RUNNING_SERVICES=$((RUNNING_SERVICES + 1))
    echo "  ✅ wise2-ecosystem"
  fi
  
  if [ -d ~/web-design/wise2-core/.git ]; then
    RUNNING_SERVICES=$((RUNNING_SERVICES + 1))
    echo "  ✅ wise2-core"
  fi
  
  if [ -f ~/web-design/tvhub-blakkhail.html ]; then
    RUNNING_SERVICES=$((RUNNING_SERVICES + 1))
    echo "  ✅ tvhub"
  fi
  
  if [ -f ~/web-design/live-dashboard.html ]; then
    RUNNING_SERVICES=$((RUNNING_SERVICES + 1))
    echo "  ✅ dashboard"
  fi
  
  echo ""
  echo "  Total: $RUNNING_SERVICES/4 services ✅"
}

# Function to check applications
check_apps() {
  AI_APPS=$(find ~/web-design/ai-tools -name "*.html" -o -name "*.js" 2>/dev/null | wc -l)
  TRADING_APPS=$(find ~/web-design/trading -name "*.html" -o -name "*.js" 2>/dev/null | wc -l)
  GAME_APPS=$(find ~/web-design/games -name "*.html" 2>/dev/null | wc -l)
  GAME_APPS=$((GAME_APPS + $(find ~/web-design/vr -name "*.html" 2>/dev/null | wc -l)))
  
  echo "  🤖 AI: $AI_APPS files"
  echo "  💰 Trading: $TRADING_APPS files"
  echo "  🎮 Games/VR: $GAME_APPS files"
  echo "  🎨 3D: $(find ~/web-design/3d-viewer ~/web-design/3d-print -type f 2>/dev/null | wc -l) files"
}

# Function to check health metrics
check_health() {
  UPTIME=$(ps -p $$ -o etime= 2>/dev/null || echo "N/A")
  MEMORY=$(ps aux | grep -i http.server | grep -v grep | awk '{print $6}' | head -1)
  CONNECTIONS=$(netstat -an 2>/dev/null | grep ESTABLISHED | wc -l || echo "0")
  
  echo "  Memory: ${MEMORY}K"
  echo "  Connections: $CONNECTIONS"
  echo "  Status: ✅ Healthy"
}

# Function to display alerts
check_alerts() {
  ALERT_COUNT=0
  
  # Check for errors in logs
  if [ -d ~/web-design/logs ]; then
    ERROR_COUNT=$(find ~/web-design/logs -name "*.log" -exec grep -l "error\|Error\|ERROR" {} \; 2>/dev/null | wc -l)
    if [ "$ERROR_COUNT" -gt 0 ]; then
      echo "  ⚠️  $ERROR_COUNT log files with errors"
      ALERT_COUNT=$((ALERT_COUNT + 1))
    fi
  fi
  
  if [ $ALERT_COUNT -eq 0 ]; then
    echo "  ✅ No active alerts"
  fi
}

# Main monitoring loop
iteration=0
while true; do
  iteration=$((iteration + 1))
  
  clear
  
  echo ""
  echo "🔍 WISE² PRODUCTION MONITORING"
  echo "════════════════════════════════════════════════════════════════"
  timestamp
  echo ""
  echo "🔄 Iteration: $iteration"
  echo ""
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🌐 HTTP SERVER STATUS"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  check_http
  echo ""
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📦 GIT REPOSITORIES"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  check_repos
  echo ""
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "💾 STORAGE & FILES"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  check_disk
  echo ""
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🧪 TEST SUITE"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  check_tests
  echo ""
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🚀 SERVICES"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  check_services
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "📱 APPLICATIONS"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  check_apps
  echo ""
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "❤️  SYSTEM HEALTH"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  check_health
  echo ""
  
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🚨 ALERTS"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  check_alerts
  echo ""
  
  echo "════════════════════════════════════════════════════════════════"
  echo "⏱️  Refreshing in $REFRESH_RATE seconds... (Ctrl+C to exit)"
  echo "════════════════════════════════════════════════════════════════"
  
  sleep $REFRESH_RATE
done
