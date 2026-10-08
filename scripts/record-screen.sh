#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./record-screen.sh <output-file.mp4> [duration-seconds]"
  exit 1
fi

OUTPUT=$1
DURATION=${2:-30}

echo "Recording screen for $DURATION seconds..."
echo "Recording: $OUTPUT"

# Use ffmpeg to record screen
ffmpeg -f x11grab -s 2256x1504 -i :0 -t $DURATION -pix_fmt yuv420p "$OUTPUT" -y 2>/dev/null && \
echo "✓ Screen recording saved: $OUTPUT" || \
echo "⚠ Recording failed - ensure ffmpeg is installed"
