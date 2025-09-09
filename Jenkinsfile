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
        sh './AppiumPythonProject/run_tests.sh'
      }
    }
  }

  post {
    always {
      echo '📦 CalculMath trigger complete'
      archiveArtifacts artifacts: 'AppiumPythonProject/reports/**/*.*', allowEmptyArchive: true
      sh 'echo "Dummy debug file" > AppiumPythonProject/reports/debug_from_jenkinsfile.txt'
    }
  }
}

