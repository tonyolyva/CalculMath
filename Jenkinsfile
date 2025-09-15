// CalculMath/Jenkinsfile — just triggers Appium tests.
pipeline {
  agent any

  options {
    skipDefaultCheckout()
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  triggers {
    // This polling schedule will be ignored here and inherited from the Jenkins job
    pollSCM('H/4 * * * *')
  }

  stages {
    stage('Trigger Appium QA Tests') {
      steps {
        checkout scm
        echo '[CalculMath/Jenkinsfile] 🔁 Cleaning workspace...'
        deleteDir() // This ensures a fresh checkout
        echo '[CalculMath/Jenkinsfile] 🚀 Triggering AppiumPythonProject pipeline...'
        sh 'mkdir -p reports'
        echo '[CalculMath/Jenkinsfile] 📦 Installing Python dependencies...'
        sh 'ls -la'
        sh 'pwd'
        sh 'python3 -m pip install --user -r AppiumPythonProject/requirements.txt || { echo "[CalculMath/Jenkinsfile] ❌ Failed to install Python dependencies"; exit 1; }'
        sh 'echo "[CalculMath/Jenkinsfile] 📂 Current path before executing run_tests.sh:"'
        sh 'pwd'
        sh 'echo "[CalculMath/Jenkinsfile] ▶️ Attempting to execute run_tests.sh..."'
        echo '[CalculMath/Jenkinsfile] ▶️ Executing run_tests.sh...'
        sh './run_tests.sh'
      }
    }
  }

  post {
    always {
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
      '''
      echo '[CalculMath/Jenkinsfile] ✅ CalculMath trigger complete'
      echo '[CalculMath/Jenkinsfile] 📂 Archiving artifacts from reports...'
      archiveArtifacts artifacts: 'reports/**/*', allowEmptyArchive: true
      archiveArtifacts artifacts: 'ai/history.csv', allowEmptyArchive: true
      echo '[CalculMath/Jenkinsfile] 📁 Post-processing complete'
    }
  }
}
