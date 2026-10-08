#!/bin/bash

# WISE² Live Build Environment Setup
export WISE2_HOME=$(pwd)
export WISE2_BUILD_DIR="$WISE2_HOME/builds"
export WISE2_BACKUP_DIR="$WISE2_HOME/backups"
export WISE2_LOG_DIR="$WISE2_HOME/logs"
export NODE_ENV=production
export WISE2_ENV=live

echo "✅ WISE² Live environment loaded"
echo "   HOME: $WISE2_HOME"
echo "   BUILD_DIR: $WISE2_BUILD_DIR"
echo "   ENV: $WISE2_ENV"
