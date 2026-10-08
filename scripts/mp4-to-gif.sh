#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./mp4-to-gif.sh <input.mp4> [output.gif]"
  exit 1
fi

INPUT=$1
OUTPUT=${2:-"${INPUT%.*}.gif"}

echo "Converting $INPUT to GIF..."

ffmpeg -i "$INPUT" -vf "scale=1280:-1:flags=lanczos,fps=10" "$OUTPUT" -y 2>/dev/null && \
echo "✓ GIF created: $OUTPUT" || \
echo "⚠ Conversion failed - ensure ffmpeg is installed"
