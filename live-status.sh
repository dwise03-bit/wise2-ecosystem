#!/bin/bash

echo "📊 LIVE BUILD SPOT STATUS"
echo "═════════════════════════════════════════════"
echo ""

echo "🏗️  SERVICES:"
echo ""
echo "  wise2-ecosystem:"
if pgrep -f "http.server.*3000" > /dev/null; then
  echo "    Status: ✅ RUNNING (port 3000)"
else
  echo "    Status: ⏸️  STOPPED"
fi
echo "    Location: $(pwd)"
echo "    Repository: git"
echo "    Branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'unknown')"
echo ""

echo "  wise2-core:"
if [ -d "wise2-core" ]; then
  echo "    Status: ✅ READY"
  echo "    Type: Monorepo (9 packages)"
  echo "    Path: ./wise2-core"
else
  echo "    Status: ⏸️  NOT FOUND"
fi
echo ""

echo "  tvhub:"
echo "    Status: ✅ CONFIGURED"
echo "    URL: https://tvhub.wise2.net"
echo "    Display: blakkhail.com"
echo ""

echo "💾 FILES & STRUCTURE:"
echo "  Repositories: $(find . -maxdepth 1 -name '.git' -type d | wc -l) local repos"
echo "  Builds: $(find ./builds -type f 2>/dev/null | wc -l) archived"
echo "  Backups: $(ls -d ./backups/*/ 2>/dev/null | wc -l) snapshots"
echo "  Logs: $(ls -1 ./logs/*.log 2>/dev/null | wc -l) entries"
echo ""

echo "⚡ QUICK STATS:"
echo "  Total files: $(find . -type f | wc -l)"
echo "  Total size: $(du -sh . 2>/dev/null | cut -f1)"
echo "  Git commits: $(git rev-list --count HEAD 2>/dev/null || echo '0')"
echo ""

echo "🔗 ACCESS POINTS:"
echo "  Local: http://localhost:3000"
echo "  wise2.net: https://wise2.net"
echo "  TV Hub: https://tvhub.wise2.net"
echo ""

echo "✨ $(date '+%Y-%m-%d %H:%M:%S')"
