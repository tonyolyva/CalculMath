// CalculMath/Jenkinsfile — just triggers Appium tests
pipeline {
  agent any

  stages {
    stage('Trigger Appium QA Tests') {
      steps {
        dir('AppiumPythonProject') {
          git url: 'https://github.com/tonyolyva/AppiumPythonProject.git', branch: 'main'
        }
        sh './AppiumPythonProject/run_tests.sh'
      }
    }
  }

  post {
    always {
      echo '📦 CalculMath trigger complete'
    }
  }
}

