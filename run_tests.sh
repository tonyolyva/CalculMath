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
  if [ -d Calculweb ]; then
    cd Calculweb
  else
    echo "[Calculweb/run_tests.sh] ❌ Calculweb directory not found. Aborting."
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
python3 -m pip install --user -r requirements.txt || {
  echo "[Calculweb/run_tests.sh] ❌ Failed to install Python dependencies"
  exit 1
}
echo "[Calculweb/run_tests.sh] ✅ Python dependencies installed"

echo "[Calculweb/run_tests.sh] 📂 Files in dir:"
ls -la
echo "[Calculweb/run_tests.sh] 🐍 Python:"
which python3
python3 --version
echo "[Calculweb/run_tests.sh] 🧪 Pytest:"

echo "[Calculweb/run_tests.sh] ✅ pytest version: $(pytest --version)"

mkdir -p reports
echo "[Calculweb/run_tests.sh] 🌐 Cloning or updating Calculweb repo..."
Calculweb_DIR="/tmp/Calculweb"
if [ ! -d "$Calculweb_DIR" ]; then
  echo "[Calculweb/run_tests.sh] 📦 Cloning Calculweb repo fresh into $Calculweb_DIR..."
  git clone https://github.com/tonyolyva/Calculweb.git "$Calculweb_DIR"
else
  echo "[Calculweb/run_tests.sh] 🔄 Calculweb directory exists at $Calculweb_DIR — verifying .git"
  if [ -d "$Calculweb_DIR/.git" ]; then
    echo "[Calculweb/run_tests.sh] ✅ .git directory exists — proceeding with git pull"
    cd "$Calculweb_DIR"
    git pull origin main || {
      echo "[Calculweb/run_tests.sh] ⚠️ Git pull failed — deleting and re-cloning"
      cd /tmp
      rm -rf "$Calculweb_DIR"
      git clone https://github.com/tonyolyva/Calculweb.git "$Calculweb_DIR"
    }
    cd -
  else
    echo "[Calculweb/run_tests.sh] ⚠️ .git not found — deleting and re-cloning"
    rm -rf "$Calculweb_DIR"
    git clone https://github.com/tonyolyva/Calculweb.git "$Calculweb_DIR"
  fi
fi
echo "[Calculweb/run_tests.sh] 📡 Checking if Appium is running..."
if nc -z localhost 4723; then
  echo "[Calculweb/run_tests.sh] ✅ Appium already running"
  appium_was_running=true
else
  echo "[Calculweb/run_tests.sh] 🚀 Appium not running — launching..."

  appium_script_path="/tmp/start_appium.sh"

  cat > "$appium_script_path" <<EOF
#!/bin/bash
cd /Users/Yutaka/Workspace/Calculweb
nohup /usr/local/bin/appium > appium.log 2>&1 &
sleep 1
true
EOF

  chmod +x "$appium_script_path"

  echo "[Calculweb/run_tests.sh] 🖥 Launching Appium in detached Terminal window..."
  osascript <<EOF
tell application "Terminal"
    set newTab to do script "source ~/.zshrc; $appium_script_path; exit"
    delay 10
    quit
end tell
EOF


  sleep 10
  appium_was_running=false

  echo "[Calculweb/run_tests.sh] 🔍 Verifying Appium is responding on localhost:4723"
  if nc -z localhost 4723; then
    echo "[Calculweb/run_tests.sh] ✅ Appium successfully started and is responding"
  else
    echo "[Calculweb/run_tests.sh] ❌ Appium did not start correctly"
    exit 1
  fi
fi

echo "[Calculweb/run_tests.sh] 🔍 Verifying if Appium logs were created:"
ls -l appium.log || echo "[Calculweb/run_tests.sh] ⚠️ Appium log not found"
echo "[Calculweb/run_tests.sh] 🔍 Printing last 20 lines of appium.log:"
tail -n 20 appium.log || echo "[Calculweb/run_tests.sh] ⚠️ Could not read appium.log"

echo "[Calculweb/run_tests.sh] 📱 Checking and booting iOS Simulator..."
SIMULATOR_NAME="iPhone 16 Pro"
SIMULATOR_UDID=$(xcrun simctl list devices available | grep "$SIMULATOR_NAME" | grep -v "unavailable" | awk -F '[()]' '{print $2}' | head -n 1)

if [ -z "$SIMULATOR_UDID" ]; then
  echo "[Calculweb/run_tests.sh] ❌ No available simulator found with name $SIMULATOR_NAME"
  exit 1
fi

# Boot the simulator if it's not already booted
BOOT_STATUS=$(xcrun simctl list | grep "$SIMULATOR_UDID" | grep -o "Booted" || true)
if [ "$BOOT_STATUS" != "Booted" ]; then
  echo "[Calculweb/run_tests.sh] 🚀 Booting simulator $SIMULATOR_NAME ($SIMULATOR_UDID)..."
  xcrun simctl boot "$SIMULATOR_UDID"
  sleep 5
else
  echo "[Calculweb/run_tests.sh] ✅ Simulator already booted"
fi

echo "[Calculweb/run_tests.sh] ⏳ Waiting for simulator to be ready..."
xcrun simctl bootstatus "$SIMULATOR_UDID" -b

# 💡 (Directory check already performed above)

echo "[Calculweb/run_tests.sh] 🧪 Running tests..."
echo "[Calculweb/run_tests.sh] 🔨 Building latest Calculweb .app..."
echo "[Calculweb/run_tests.sh] 📦 Cleaning previous DerivedData..."
rm -rf /Users/Yutaka/Library/Developer/Xcode/DerivedData

echo "[Calculweb/run_tests.sh] 📂 Verifying Calculweb.xcodeproj exists:"
Calculweb_XCODEPROJ_PATH="$Calculweb_DIR/Calculweb.xcodeproj"
if [ ! -d "$Calculweb_XCODEPROJ_PATH" ]; then
  echo "[Calculweb/run_tests.sh] ❌ Calculweb.xcodeproj not found at expected path: $Calculweb_XCODEPROJ_PATH"
  exit 1
else
  echo "[Calculweb/run_tests.sh] ✅ Found Calculweb.xcodeproj at: $Calculweb_XCODEPROJ_PATH"
fi

echo "[Calculweb/run_tests.sh] 📦 Building Calculweb .app using xcodebuild (project version)..."
xcodebuild -project "$Calculweb_XCODEPROJ_PATH" \
           -scheme Calculweb \
           -sdk iphonesimulator \
           -configuration Debug \
           -derivedDataPath "/Users/Yutaka/Library/Developer/Xcode/DerivedData/Calculweb-ManualDerivedData" \
           -destination 'platform=iOS Simulator,name=iPhone 16 Pro,OS=18.5' \
           build || {
  echo "[Calculweb/run_tests.sh] ❌ Xcode build failed (project version)."
  exit 1
}

DERIVED_DATA_SUBDIR="Calculweb-ManualDerivedData"
BUILT_APP_PATH="/Users/Yutaka/Library/Developer/Xcode/DerivedData/${DERIVED_DATA_SUBDIR}/Build/Products/Debug-iphonesimulator/Calculweb.app"

if [ ! -d "$BUILT_APP_PATH" ]; then
  echo "[Calculweb/run_tests.sh] ❌ Calculweb.app not found at expected path: $BUILT_APP_PATH"
  ls -R /Users/Yutaka/Library/Developer/Xcode/DerivedData || true
  exit 1
fi
echo "[Calculweb/run_tests.sh] ✅ Calculweb.app found at $BUILT_APP_PATH"

echo "[Calculweb/run_tests.sh] 📁 Ensuring apps/ folder exists..."
mkdir -p apps

echo "[Calculweb/run_tests.sh] 📦 Searching for Calculweb.app..."
APP_PATH="$BUILT_APP_PATH"

if [ ! -d "$APP_PATH" ]; then
  echo "[Calculweb/run_tests.sh] ❌ Calculweb.app not found at expected path: $APP_PATH"
  ls -R /Users/Yutaka/Library/Developer/Xcode/DerivedData || true
  exit 1
fi

echo "[Calculweb/run_tests.sh] 📦 Found Calculweb.app at $APP_PATH — copying to apps/"
cp -R "$APP_PATH" apps/
if [ ! -d "apps/Calculweb.app" ]; then
  echo "[Calculweb/run_tests.sh] ❌ Copy to apps/Calculweb.app failed!"
  exit 1
fi
echo "[Calculweb/run_tests.sh] ✅ apps/Calculweb.app confirmed"

echo "[Calculweb/run_tests.sh] ✅ Calculweb.app successfully copied to apps/"

echo "[Calculweb/run_tests.sh] 📂 Contents of Calculweb.app:"
ls -l apps/Calculweb.app

echo "[Calculweb/run_tests.sh] 📄 Contents of Info.plist:"
cat apps/Calculweb.app/Info.plist || echo "[Calculweb/run_tests.sh] ⚠️ Could not read Info.plist"

echo "[Calculweb/run_tests.sh] 📲 Installing app to Simulator..."
xcrun simctl install "$SIMULATOR_UDID" apps/Calculweb.app || {
  echo "[Calculweb/run_tests.sh] ❌ Failed to install Calculweb.app to simulator: $SIMULATOR_UDID"
  xcrun simctl listapps "$SIMULATOR_UDID" || echo "[Calculweb/run_tests.sh] ⚠️ Could not list apps on simulator"
  exit 1
}

echo "[Calculweb/run_tests.sh] 🔍 Attempting to extract bundle identifier from .app Info.plist..."
BUNDLE_ID=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" "$(pwd)/apps/Calculweb.app/Info.plist" 2>/dev/null)

if [ -z "$BUNDLE_ID" ]; then
  echo "[Calculweb/run_tests.sh] ⚠️ Could not determine bundle identifier automatically. App may not launch."
else
  echo "[Calculweb/run_tests.sh] 🚀 Launching app with bundle ID: $BUNDLE_ID"
  xcrun simctl launch "$SIMULATOR_UDID" "$BUNDLE_ID" || {
    echo "[Calculweb/run_tests.sh] ⚠️ App launch failed — this may be fine if tests launch it themselves"
  }

  echo "[Calculweb/run_tests.sh] 📦 Setting PYTEST_BUNDLE_ID=$BUNDLE_ID"
  export PYTEST_BUNDLE_ID="$BUNDLE_ID"
fi

echo "[Calculweb/run_tests.sh] 🔍 Checking that test_*.py files exist in tests/"
find . -name "test_*.py" || echo "[Calculweb/run_tests.sh] ⚠️ test_*.py not found anywhere under current dir"

echo "[Calculweb/run_tests.sh] 📁 Listing contents of tests/ directory:"
ls -la "${SCRIPT_DIR}/tests" || echo "[Calculweb/run_tests.sh] ⚠️ tests/ directory missing"
if ! find "${SCRIPT_DIR}/tests" -name "test_*.py" | grep -q .; then
  echo "[Calculweb/run_tests.sh] ❌ No test files matching test_*.py found!"
  echo "[Calculweb/run_tests.sh] ❌ Current working dir: $(pwd)"
  echo "[Calculweb/run_tests.sh] ❌ Listing files under tests/ (if any):"
  ls -la "${SCRIPT_DIR}/tests" || echo "[Calculweb/run_tests.sh] ⚠️ tests/ directory missing"
  echo "[Calculweb/run_tests.sh] ❌ Aborting test run due to missing test files."
  exit 1
fi

echo "[Calculweb/run_tests.sh] 🔍 Verifying iOS Simulator is running:"
xcrun simctl list | grep "Booted" || echo "[Calculweb/run_tests.sh] ⚠️ No booted simulator found"
echo "[Calculweb/run_tests.sh] 🧪 Running pytest on test files in tests/..."
echo "[Calculweb/run_tests.sh] 📁 Current dir contents:"
ls -la

echo "[Calculweb/run_tests.sh] 🧪 Changing into Calculweb dir for test execution..."
echo "[Calculweb/run_tests.sh] ✅ Already in Calculweb directory: $(pwd)"
pwd

echo "[Calculweb/run_tests.sh] 🧪 Executing all pytest tests (including tests/test_*.py)..."
echo "[Calculweb/run_tests.sh] ✅ Confirmed: About to run pytest with test file listing..."
python3 -m pytest --collect-only -v tests
echo "[Calculweb/run_tests.sh] ✅ Confirmed: Finished collecting tests. Now running actual tests..."
echo "[Calculweb/run_tests.sh] ✅ Located test_*.py files — expected test function names:"
find "${SCRIPT_DIR}/tests" -name "test_*.py" -exec grep -HE 'def test_' {} \;
echo "[Calculweb/run_tests.sh] 📂 Confirming test files before execution:"
find "${SCRIPT_DIR}/tests" -name "test_*.py" -exec ls -l {} \;
echo "[Calculweb/run_tests.sh] ✅ Running pytest..."

echo "[Calculweb/run_tests.sh] 🐍 Python location: $(which python3)"
echo "[Calculweb/run_tests.sh] 🧪 Pytest location: $(which pytest)"
echo "[Calculweb/run_tests.sh] 🧪 Installed pytest plugins:"
echo "[Calculweb/run_tests.sh] 🧪 Confirming pytest finds test_*.py files:"
python3 -m pytest --collect-only -v tests

echo "[Calculweb/run_tests.sh] 🧪 Re-confirming Calculweb.app exists before test run..."
find /Users/Yutaka/Library/Developer/Xcode/DerivedData/Calculweb* -name "Calculweb.app" -print

echo "[Calculweb/run_tests.sh] ✅ Final launch test: test_*.py files with verbose output"
python3 -m pytest -v tests \
  --tb=short \
  --capture=tee-sys \
  --json-report \
  --json-report-file=reports/report.json \
  --html=reports/report.html \
  --self-contained-html \
  -s | tee reports/pytest_output.log || {
  echo "[Calculweb/run_tests.sh] ❌ Pytest execution failed or returned non-zero exit code"
}
test_result=${PIPESTATUS[0]}
sync
echo "[Calculweb/run_tests.sh] 🔍 Checking for generated screenshots (PNG) in reports/screenshots:"
if [ -d reports/screenshots ]; then
  echo "[Calculweb/run_tests.sh] 📸 Found screenshots directory:"
  ls -l reports/screenshots
else
  echo "[Calculweb/run_tests.sh] ❌ screenshots directory not found"
fi

echo "[Calculweb/run_tests.sh] 📌 DEBUG: Finished pytest execution. Log should be in reports/pytest_output.log"
echo "[Calculweb/run_tests.sh] ✅ Completed pytest run"
echo "[Calculweb/run_tests.sh] ✅ Pytest completed with exit code $test_result"

echo "[Calculweb/run_tests.sh] 📊 Collecting test results into history.csv..."
echo "[Calculweb/run_tests.sh] 📌 Setting WORKSPACE for AI data collection..."
echo "[Calculweb/run_tests.sh] 🧪 DEBUG: Attempting to get git commit SHA for Calculweb"
cd "$Calculweb_DIR"
if [ -d .git ]; then
  echo "[Calculweb/run_tests.sh] ✅ .git directory found — proceeding with git log"
  git log -1 --pretty=format:'[Calculweb/run_tests.sh] 🔢 Git commit SHA: %H'
else
  echo "[Calculweb/run_tests.sh] ❌ .git directory not found — skipping git SHA output"
fi
cd -
export WORKSPACE="$(pwd)"
python3 ai/collect_history.py || echo "[Calculweb/run_tests.sh] ⚠️ Failed to collect history"

echo "[Calculweb/run_tests.sh] 🔍 Checking contents of reports/ directory:"
ls -la reports || echo "[Calculweb/run_tests.sh] ⚠️ Failed to list reports directory"

echo "[Calculweb/run_tests.sh] 📄 pytest_output.log (copied below):"
echo "========================="
cat reports/pytest_output.log || echo "[Calculweb/run_tests.sh] ⚠️ No pytest output file found."
echo "========================="

echo "[Calculweb/run_tests.sh] 🔍 Verifying test functions found in test_*.py files:"
find "${SCRIPT_DIR}/tests" -name "test_*.py" -exec grep -HE 'def test_' {} \; || echo "[Calculweb/run_tests.sh] ⚠️ No test functions found!"
echo "[Calculweb/run_tests.sh] 📁 Listing all .py files under tests/ recursively:"; find "${SCRIPT_DIR}/tests" -type f -name "*.py"

if [ "$appium_was_running" = false ]; then
  echo "[Calculweb/run_tests.sh] 🛑 Stopping Appium"
  kill $(lsof -ti:4723) || true
fi


exit $test_result