#!/bin/bash

set -x  # enable shell command echoing
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "[Calculweb/run_tests.sh] 📌 SCRIPT_DIR resolved to: $SCRIPT_DIR"

echo "[Calculweb/run_tests.sh] 🐛 DEBUG (EXECUTION): This is the latest run_tests.sh"

echo "[Calculweb/run_tests.sh] 📁 Current dir: $(pwd)"
ls -la


export PATH="$HOME/Library/Python/3.9/bin:$PATH"

echo "[Calculweb/run_tests.sh] ⚙️ Working dir: $(pwd)"
if [ ! -f run_tests.sh ]; then
  echo "[Calculweb/run_tests.sh] 🔁 Changing directory into Calculweb..."
  if [ -d AppiumPythonProject ]; then
    cd Calculweb
  else
    echo "[Calculweb/run_tests.sh] ❌ AppiumPythonProject directory not found. Aborting."
    exit 1
  fi
fi

echo "[Calculweb/run_tests.sh] 📦 Installing Python dependencies..."
echo "[Calculweb/run_tests.sh] 📍 Attempting pip install from path: $(pwd)"
if [ ! -f requirements.txt ]; then
  echo "[Calculweb/run_tests.sh] ❌ requirements.txt not found at $(pwd)"
  ls -la
  exit 1
fi