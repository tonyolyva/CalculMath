// CalculMath/Jenkinsfile — just triggers Appium tests
pipeline {
  agent any

  stages {
    stage('Trigger Appium QA Tests') {
      steps {
        dir('AppiumPythonProject') {
          git url: 'https://github.com/tonyolyva/AppiumPythonProject.git', branch: 'main'
        }
        sh 'mkdir -p AppiumPythonProject/reports'
        sh 'mkdir -p AppiumPythonProject/reports/screenshots'
        sh './AppiumPythonProject/run_tests.sh'
      }
    }
  }

  post {
    always {
      dir('AppiumPythonProject/reports/screenshots') {
        sh '''
          echo "Dummy screenshot placeholder" > screenshot_dummy.txt
          echo "✅ Dummy screenshot created inside post block"
        '''
      }
      echo '📦 CalculMath trigger complete'
      archiveArtifacts artifacts: 'AppiumPythonProject/reports/**/*', allowEmptyArchive: true
    }
  }
}
