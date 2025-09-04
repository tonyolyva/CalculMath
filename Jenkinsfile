// This Jenkinsfile resides in the CalculMath repo (Dev).
// It assumes the QA Appium test project (AppiumPythonProject) is located at ../AppiumPythonProject relative to this repo.
pipeline {
  agent any

  stages {
    stage('Clone Appium QA Repo') {
      steps {
        git url: 'https://github.com/tonyolyva/AppiumPythonProject.git', branch: 'main'
      }
    }

    stage('Install Dependencies') {
      steps {
        dir('AppiumPythonProject') {
          sh '/Library/Frameworks/Python.framework/Versions/3.13/bin/pip install -r requirements.txt'
        }
      }
    }

    stage('Run Tests') {
      steps {
        dir('AppiumPythonProject') {
          sh './run_tests.sh'
        }
      }
    }

    stage('Publish HTML Report') {
      steps {
        dir('AppiumPythonProject') {
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
    }

    stage('Archive Logs') {
      steps {
        dir('AppiumPythonProject') {
          archiveArtifacts artifacts: 'appium.log', allowEmptyArchive: true
        }
      }
    }
  }

  post {
    always {
      echo '❌ Pipeline failed or completed'
    }
  }
}
