// CalculMath/Jenkinsfile — just triggers Appium tests
pipeline {
  agent any

  stages {
    stage('Trigger Appium QA Tests') {
      steps {
        git url: 'https://github.com/tonyolyva/AppiumPythonProject.git', branch: 'main'
        dir('AppiumPythonProject') {
          sh 'mkdir -p reports'
          sh 'python3 -m pip install --user -r requirements.txt'
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
      echo '📦 CalculMath trigger complete'
      archiveArtifacts artifacts: 'AppiumPythonProject/reports/**/*', allowEmptyArchive: true
    }
  }
}
