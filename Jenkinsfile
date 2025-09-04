// This Jenkinsfile resides in the CalculMath repo (Dev).
// It assumes the QA Appium test project (AppiumPythonProject) is located at ../AppiumPythonProject relative to this repo.
pipeline {
  agent any

  stages {
    stage('Clone Appium QA Repo') {
      steps {
        dir('AppiumPythonProject') {
          git url: 'https://github.com/tonyolyva/AppiumPythonProject.git', branch: 'main'
        }
      }
    }

    stage('Install Dependencies') {
      steps {
        sh '/Library/Frameworks/Python.framework/Versions/3.13/bin/pip install -r AppiumPythonProject/requirements.txt'
      }
    }

    stage('Run Tests') {
      steps {
        sh './AppiumPythonProject/run_tests.sh'
      }
    }

    stage('Publish HTML Report') {
      steps {
        publishHTML([
          allowMissing: false,
          alwaysLinkToLastBuild: true,
          keepAll: true,
          reportDir: 'reports',
          reportFiles: 'report.html',
          reportName: 'Appium Test Report'
        ])
      }
    }

    stage('Archive Logs') {
      steps {
        archiveArtifacts artifacts: 'AppiumPythonProject/appium.log', allowEmptyArchive: true
      }
    }
  }

  post {
    always {
      echo '❌ Pipeline failed or completed'
    }
  }
}
