// CalculMath/Jenkinsfile — just triggers Appium tests
pipeline {
  agent any

  stages {
    stage('Trigger Appium QA Tests') {
      steps {
        echo '[CalculMath/Jenkinsfile] 🔁 Cleaning workspace...'
        deleteDir() // This ensures a fresh checkout
        echo '[CalculMath/Jenkinsfile] 🚀 Triggering AppiumPythonProject pipeline...'
        git url: 'https://github.com/tonyolyva/AppiumPythonProject.git', branch: 'main'
        sh 'mkdir -p reports'
        echo '[CalculMath/Jenkinsfile] 📦 Installing Python dependencies...'
        sh 'ls -la'
        sh 'pwd'
        sh 'python3 -m pip install --user -r requirements.txt || { echo "[CalculMath/Jenkinsfile] ❌ Failed to install Python dependencies"; exit 1; }'
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
      sh 'python3 ai/collect_history.py "$WORKSPACE/reports/report.json"'
      sh 'sort -u ai/history.csv -o ai/history.csv'
      echo '[CalculMath/Jenkinsfile] ✅ CalculMath trigger complete'
      echo '[CalculMath/Jenkinsfile] 📂 Archiving artifacts from reports...'
      archiveArtifacts artifacts: 'reports/**/*', allowEmptyArchive: true
      archiveArtifacts artifacts: 'ai/history.csv', allowEmptyArchive: true
      echo '[CalculMath/Jenkinsfile] 📁 Post-processing complete'
    }
  }
}
