pipeline {
    agent any

    environment {
        PATH = "$PATH:/usr/local/dotnet"
        DOTNET_ROOT = "/usr/local/dotnet"
        DOCKER_IMAGE = 'nikshay7891/mvc-app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage("Git Checkout") {
            steps {
                echo "Cloning repository..."
                git branch: 'main', url: 'https://github.com/Nikshay123/MVC_Practice.git'
            }
        }

        stage("Restore Dependencies") {
            steps {
                echo "Restoring dependencies..."
                sh 'dotnet restore'
            }
        }

        stage("Build") {
            steps {
                echo "Building the project..."
                sh 'dotnet build --configuration Release'
            }
        }

        stage("Publish") {
            steps {
                echo "Publishing the project..."
                sh 'dotnet publish -c Release -o publish_output'
            }
        }

        stage("Build Docker Image") {
            steps {
                echo "Building Docker Image..."
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage("Push Docker Image to Docker Hub") {
            steps {
                echo "Pushing Docker Image..."
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                }
            }
        }

        stage("Run Docker Container") {
            steps {
                echo "Running Docker Container..."
                sh 'docker run -d -p 8081:80 $DOCKER_IMAGE:$DOCKER_TAG'
            }
        }
    }
}
