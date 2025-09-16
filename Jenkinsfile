pipeline {
  agent any

  options {
    skipDefaultCheckout()
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  stages {
    stage('Trigger Appium QA Tests') {
      steps {
        echo "[CalculMath/Jenkinsfile] 📆 Trigger reason: ${currentBuild.getBuildCauses()}"
        checkout scm

        dir('AppiumPythonProject') {
          git url: 'https://github.com/tonyolyva/AppiumPythonProject.git', branch: 'main'
        }

        dir('AppiumPythonProject') {
          echo '[CalculMath/Jenkinsfile] ✅ Repo cloned. Proceeding with test setup...'
          echo '[CalculMath/Jenkinsfile] 🚀 Triggering AppiumPythonProject pipeline...'
          sh 'mkdir -p reports'
          echo '[CalculMath/Jenkinsfile] 📦 Installing Python dependencies...'
          sh 'ls -la'
          sh 'pwd'
          sh 'echo "[CalculMath/Jenkinsfile] 📂 Verifying requirements.txt location..."'
          sh 'ls -la .'
          sh '''
            echo "[CalculMath/Jenkinsfile] 📂 Checking for requirements.txt in current directory"
            if [ -f requirements.txt ]; then
              echo "[CalculMath/Jenkinsfile] ✅ Found requirements.txt"
              python3 -m pip install --user -r requirements.txt || {
                echo "[CalculMath/Jenkinsfile] ❌ Failed to install Python dependencies"
                exit 1
              }
            else
              echo "[CalculMath/Jenkinsfile] ❌ requirements.txt not found in $(pwd)"
              ls -la
              exit 1
            fi
          '''
          sh 'echo "[CalculMath/Jenkinsfile] 📂 Current path before executing run_tests.sh:"'
          sh 'pwd'
          sh 'echo "[CalculMath/Jenkinsfile] ▶️ Attempting to execute run_tests.sh..."'
          echo '[CalculMath/Jenkinsfile] ▶️ Executing run_tests.sh...'
          sh './run_tests.sh'
        }
      }
    }
  }

  post {
    always {
      dir('AppiumPythonProject') {
        script {
          sh '''
            mkdir -p reports/screenshots
            echo '[CalculMath/Jenkinsfile] 🐛 DEBUG: Created screenshot marker' > reports/screenshots/screenshot_test_marker.txt
          '''
          echo "[CalculMath/Jenkinsfile] ✅ Created AppiumPythonProject/reports/screenshots/screenshot_test_marker.txt"
        }
        sh 'sort -t \',\' -k3,3 --stable ai/history.csv | uniq > ai/history_sorted.csv && mv ai/history_sorted.csv ai/history.csv'
        echo '[CalculMath/Jenkinsfile] 🔁 Deduplicated and sorted ai/history.csv by timestamp'

        echo '[CalculMath/Jenkinsfile] ⬆️ Committing updated history.csv back to GitHub'
        sh '''
          git config user.name "tonyolyva-bot"
          git config user.email "olyvatony@gmail.com"

          git add ai/history.csv
          git commit -m "🤖 Update history.csv after Jenkins run" || echo "[SKIP] No changes to commit"
          git push origin main || echo "[ERROR] Git push failed — check credentials or branch state"

          echo '[CalculMath/Jenkinsfile] ⬇️ Syncing updated history.csv to local clone...'
          LOCAL_REPO_PATH="$HOME/Projects/AppiumPythonProject"
          if [ -d "$LOCAL_REPO_PATH/ai" ]; then
            cp ai/history.csv "$LOCAL_REPO_PATH/ai/history.csv"
            echo "[CalculMath/Jenkinsfile] ✅ Copied history.csv to $LOCAL_REPO_PATH/ai/"
          else
            echo "[CalculMath/Jenkinsfile] ⚠️ Local clone not found at $LOCAL_REPO_PATH — skipping sync"
          fi
        '''
        echo '[CalculMath/Jenkinsfile] ✅ CalculMath trigger complete'
        echo '[CalculMath/Jenkinsfile] 📂 Archiving artifacts from reports...'
        archiveArtifacts artifacts: 'reports/**/*', allowEmptyArchive: true
        archiveArtifacts artifacts: 'ai/history.csv', allowEmptyArchive: true
        echo '[CalculMath/Jenkinsfile] 📁 Post-processing complete'
      }
    }
  }
}

