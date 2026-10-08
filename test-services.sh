#!/bin/bash

echo "🧪 WISE² SERVICE TEST SUITE"
echo "═══════════════════════════════════════════════════════════════"
echo ""

PASS=0
FAIL=0
WARNINGS=0

# Test counter
test_count=0
test() {
  test_count=$((test_count + 1))
  echo -n "  [$test_count] $1... "
}

pass() {
  echo "✅ PASS"
  PASS=$((PASS + 1))
}

fail() {
  echo "❌ FAIL: $1"
  FAIL=$((FAIL + 1))
}

warn() {
  echo "⚠️  WARN: $1"
  WARNINGS=$((WARNINGS + 1))
}

# ═══════════════════════════════════════════════════════════════
echo "1️⃣  ECOSYSTEM TESTS"
echo "───────────────────────────────────────────────────────────"

test "HTTP Server Running"
if pgrep -f "http.server" > /dev/null; then
  pass
else
  fail "HTTP server not running"
fi

test "Ecosystem Accessible"
if curl -s http://localhost:3000 | grep -q "WISE²\|BLAKK"; then
  pass
else
  fail "Cannot access http://localhost:3000"
fi

test "Package.json Valid"
if [ -f ~/web-design/package.json ] && grep -q "wise2-ecosystem" ~/web-design/package.json; then
  pass
else
  fail "package.json invalid or missing"
fi

test "Git Repository"
if [ -d ~/web-design/.git ]; then
  pass
else
  fail "Git repository not found"
fi

# ═══════════════════════════════════════════════════════════════
echo ""
echo "2️⃣  CORE MONOREPO TESTS"
echo "───────────────────────────────────────────────────────────"

test "Core Directory Exists"
if [ -d ~/web-design/wise2-core ]; then
  pass
else
  fail "wise2-core directory missing"
fi

test "Lerna Configuration"
if [ -f ~/web-design/wise2-core/lerna.json ]; then
  pass
else
  fail "lerna.json missing"
fi

test "9 Packages Present"
PKG_COUNT=$(find ~/web-design/wise2-core -name "package.json" -type f | wc -l)
if [ "$PKG_COUNT" -ge 9 ]; then
  pass
else
  fail "Expected 9+ packages, found $PKG_COUNT"
fi

test "Core Git Repository"
if [ -d ~/web-design/wise2-core/.git ]; then
  pass
else
  fail "Core git repository not found"
fi

# ═══════════════════════════════════════════════════════════════
echo ""
echo "3️⃣  TV HUB TESTS"
echo "───────────────────────────────────────────────────────────"

test "TV Hub HTML File"
if [ -f ~/web-design/tvhub-blakkhail.html ]; then
  pass
else
  fail "tvhub-blakkhail.html missing"
fi

test "TV Hub Configuration"
if grep -q "blakkhail.com" ~/web-design/tvhub-blakkhail.html; then
  pass
else
  fail "TV Hub not configured correctly"
fi

test "NGINX Config Present"
if [ -f ~/web-design/nginx-tvhub.conf ]; then
  pass
else
  fail "nginx-tvhub.conf missing"
fi

# ═══════════════════════════════════════════════════════════════
echo ""
echo "4️⃣  AUTOMATION SCRIPTS TESTS"
echo "───────────────────────────────────────────────────────────"

test "Build Pipeline Script"
if [ -x ~/web-design/build-pipeline.sh ]; then
  pass
else
  fail "build-pipeline.sh not executable"
fi

test "Live Deploy Script"
if [ -x ~/web-design/live-deploy.sh ]; then
  pass
else
  fail "live-deploy.sh not executable"
fi

test "Live Status Script"
if [ -x ~/web-design/live-status.sh ]; then
  pass
else
  fail "live-status.sh not executable"
fi

test "Dashboard HTML"
if [ -f ~/web-design/live-dashboard.html ]; then
  pass
else
  fail "live-dashboard.html missing"
fi

# ═══════════════════════════════════════════════════════════════
echo ""
echo "5️⃣  GITHUB INTEGRATION TESTS"
echo "───────────────────────────────────────────────────────────"

test "Ecosystem Remote Configured"
cd ~/web-design
if git remote -v | grep -q "github.com/dwise03-bit/wise2-ecosystem"; then
  pass
else
  fail "Ecosystem GitHub remote not configured"
fi

test "Core Remote Configured"
cd ~/web-design/wise2-core
if git remote -v | grep -q "github.com/dwise03-bit/wise2-core"; then
  pass
else
  fail "Core GitHub remote not configured"
fi

test "Ecosystem Commits"
cd ~/web-design
COMMITS=$(git rev-list --count HEAD)
if [ "$COMMITS" -ge 1 ]; then
  pass
else
  fail "No commits in ecosystem repository"
fi

test "Core Commits"
cd ~/web-design/wise2-core
COMMITS=$(git rev-list --count HEAD)
if [ "$COMMITS" -ge 1 ]; then
  pass
else
  fail "No commits in core repository"
fi

# ═══════════════════════════════════════════════════════════════
echo ""
echo "6️⃣  BUILD & DEPLOYMENT TESTS"
echo "───────────────────────────────────────────────────────────"

test "Build Cache Directory"
if [ -d ~/web-design/.build-cache ]; then
  pass
else
  fail "Build cache directory missing"
fi

test "Logs Directory"
if [ -d ~/web-design/logs ]; then
  pass
else
  fail "Logs directory missing"
fi

test "Backups Directory"
if [ -d ~/web-design/backups ]; then
  pass
else
  fail "Backups directory missing"
fi

test "Builds Directory"
if [ -d ~/web-design/builds ]; then
  pass
else
  fail "Builds directory missing"
fi

# ═══════════════════════════════════════════════════════════════
echo ""
echo "7️⃣  FILE STRUCTURE TESTS"
echo "───────────────────────────────────────────────────────────"

test "Index HTML"
if [ -f ~/web-design/index.html ]; then
  pass
else
  fail "index.html missing"
fi

test "Build Config"
if [ -f ~/web-design/.build-config.json ]; then
  pass
else
  fail ".build-config.json missing"
fi

test "Total Files Count"
FILE_COUNT=$(find ~/web-design -type f | wc -l)
if [ "$FILE_COUNT" -gt 100 ]; then
  pass
else
  warn "Only $FILE_COUNT files found (expected >100)"
fi

# ═══════════════════════════════════════════════════════════════
echo ""
echo "8️⃣  INTEGRATION TESTS"
echo "───────────────────────────────────────────────────────────"

test "Ecosystem Responsive"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000)
if [ "$HTTP_CODE" = "200" ]; then
  pass
else
  fail "HTTP status $HTTP_CODE (expected 200)"
fi

test "Docker Compose Present"
if [ -f ~/web-design/docker-compose.tvhub.yml ] || [ -f ~/web-design/docker-compose.prod.yml ]; then
  pass
else
  warn "Docker compose files not found"
fi

test "Database Schema"
if [ -f ~/web-design/docs/database/schema.sql ]; then
  pass
else
  warn "Database schema not found"
fi

test "API Documentation"
if [ -f ~/web-design/docs/API.md ]; then
  pass
else
  warn "API documentation not found"
fi

# ═══════════════════════════════════════════════════════════════
echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "📊 TEST RESULTS SUMMARY"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "✅ PASSED:  $PASS"
echo "❌ FAILED:  $FAIL"
echo "⚠️  WARNED:  $WARNINGS"
echo "📋 TOTAL:   $((PASS + FAIL + WARNINGS)) tests"
echo ""

PASS_RATE=$((PASS * 100 / (PASS + FAIL + WARNINGS)))
echo "📈 Pass Rate: $PASS_RATE%"
echo ""

if [ $FAIL -eq 0 ]; then
  echo "🎉 ALL CRITICAL TESTS PASSED!"
  echo ""
  echo "✨ WISE² Ecosystem is READY FOR PRODUCTION"
  exit 0
else
  echo "⚠️  Some tests failed. Please review above."
  exit 1
fi
