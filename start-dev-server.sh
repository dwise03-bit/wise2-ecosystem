#!/bin/bash

PORT=${1:-3000}
cd ~/web-design/projects

echo "Starting WISE² Web Design Dev Server..."
echo "Web Design Studio: http://127.0.0.1:$PORT"
echo "Press Ctrl+C to stop"

python3 -m http.server $PORT --bind 127.0.0.1
