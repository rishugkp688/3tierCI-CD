pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/rishugkp688/3tierCI-CD.git'
        APP_DIR = '.'  // Path in the workspace where your docker-compose.yml resides
    }

    stages {
        stage('Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: env.REPO_URL]]
                ])
            }
        }

        stage('Build & Deploy') {
            steps {
                dir(env.APP_DIR) {
                    sh 'docker compose down'
                    sh 'docker compose build'
                    sh 'docker compose up -d'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment succeeded!'
        }
        failure {
            echo 'Deployment failed—check logs.'
        }
    }
}
