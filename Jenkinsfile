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
          mkdir -p AppiumPythonProject/reports/screenshots
          echo '[CalculMath/Jenkinsfile] 🐛 DEBUG: Created screenshot marker' > AppiumPythonProject/reports/screenshots/screenshot_test_marker.txt
        '''
        echo "✅ Created AppiumPythonProject/reports/screenshots/screenshot_test_marker.txt"
      }
      sh 'python3 AppiumPythonProject/ai/collect_history.py "$WORKSPACE/AppiumPythonProject/reports/report.json"'
      echo '[CalculMath/Jenkinsfile] ✅ CalculMath trigger complete'
      echo '[CalculMath/Jenkinsfile] 📂 Archiving artifacts from reports...'
      archiveArtifacts artifacts: 'AppiumPythonProject/reports/**/*', allowEmptyArchive: true
      echo '[CalculMath/Jenkinsfile] 📁 Post-processing complete'
    }
  }
}
