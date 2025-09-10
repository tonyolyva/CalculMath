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
      sh 'mkdir -p AppiumPythonProject/reports/screenshots && echo "Dummy debug file" > AppiumPythonProject/reports/debug_from_jenkinsfile.txt'
      sh 'echo "Dummy debug file" > AppiumPythonProject/reports/debug_from_jenkinsfile.txt'
      echo '📦 CalculMath trigger complete'
      archiveArtifacts artifacts: 'AppiumPythonProject/reports/**/*.*', allowEmptyArchive: true
    }
  }
}
