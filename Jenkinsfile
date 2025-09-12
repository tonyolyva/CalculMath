// CalculMath/Jenkinsfile — just triggers Appium tests
pipeline {
  agent any

  stages {
    stage('Trigger Appium QA Tests') {
      steps {
        echo '[CalculMath/Jenkinsfile] 🚀 Triggering AppiumPythonProject pipeline...'
        git url: 'https://github.com/tonyolyva/AppiumPythonProject.git', branch: 'main'
        dir('AppiumPythonProject') {
          sh 'mkdir -p reports'
          echo '[CalculMath/Jenkinsfile] 📦 Installing Python dependencies...'
          sh 'ls -la'
          sh 'pwd'
          sh 'python3 -m pip install --user -r requirements.txt || { echo "[CalculMath/Jenkinsfile] ❌ Failed to install Python dependencies"; exit 1; }'
          echo '[CalculMath/Jenkinsfile] ▶️ Executing run_tests.sh...'
          sh './run_tests.sh'
        }
      }
    }
  }

  post {
    always {
      script {
        def markerFile = 'AppiumPythonProject/reports/screenshots/screenshot_test_marker.txt'
        sh "echo '🧪 Screenshot marker file created from post block' > ${markerFile}"
        echo "✅ Created ${markerFile}"
      }
      sh 'python3 AppiumPythonProject/ai/collect_history.py "$WORKSPACE/AppiumPythonProject/reports/report.json"'
      echo '[CalculMath/Jenkinsfile] ✅ CalculMath trigger complete'
      echo '[CalculMath/Jenkinsfile] 📂 Archiving artifacts from reports...'
      archiveArtifacts artifacts: 'AppiumPythonProject/reports/**/*', allowEmptyArchive: true
      echo '[CalculMath/Jenkinsfile] 📁 Post-processing complete'
    }
  }
}
