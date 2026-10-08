#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./new-project.sh <project-name>"
  exit 1
fi

PROJECT_NAME=$1
PROJECT_DIR=~/web-design/projects/$PROJECT_NAME

mkdir -p $PROJECT_DIR

cat > $PROJECT_DIR/index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
  <title>PROJECT_TITLE</title>
  <style>
    :root {
      --accent: #00ff88;
      --bg-primary: #0a0e1a;
      --bg-secondary: #0f1419;
      --fg-primary: #e0e6f0;
      --fg-secondary: #9ca3af;
      --border: #1e2432;
    }

    * { box-sizing: border-box; }
    html, body { height: 100%; margin: 0; }
    body {
      background: var(--bg-primary);
      color: var(--fg-primary);
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
      font-size: 18px;
      padding: 40px;
      zoom: 2;
    }

    h1 { font-size: 56px; font-weight: 700; margin: 0 0 16px 0; }
    p { font-size: 18px; line-height: 1.6; margin: 0 0 24px 0; }
  </style>
</head>
<body>
  <h1>⬡ WISE² Project</h1>
  <p>New web design project ready for development.</p>
</body>
</html>
HTML

echo "✓ Project '$PROJECT_NAME' created at $PROJECT_DIR"
echo "  Edit: $PROJECT_DIR/index.html"
echo "  View: http://127.0.0.1:3000/$PROJECT_NAME/"
