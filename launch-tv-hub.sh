#!/bin/bash

echo "🚀 Launching WISE² TV Hub with blakkhail.com"
echo ""

# Start dev server if not running
if ! nc -z localhost 3000 2>/dev/null; then
  echo "Starting HTTP server..."
  http-server -p 3000 -o tvhub-blakkhail.html &
  sleep 2
else
  echo "Opening in browser..."
  xdg-open http://localhost:3000/tvhub-blakkhail.html 2>/dev/null || \
  open http://localhost:3000/tvhub-blakkhail.html 2>/dev/null || \
  firefox http://localhost:3000/tvhub-blakkhail.html &
fi

echo "✅ TV Hub launching..."
echo ""
echo "📺 Display: https://blakkhail.com"
echo "🎛️  Controls: Bottom right"
echo "⌨️  Fullscreen: Press F11"
