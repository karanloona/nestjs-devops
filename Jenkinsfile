pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-north-1'
        ECR_REPO_URL       = '367983454293.dkr.ecr.eu-north-1.amazonaws.com'
        K8S_NAMESPACE      = 'deel'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                url: 'https://github.com/karanloona/nestjs-devops.git'
            }
        }
        
        stage('Logging into AWS ECR') {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'AWS', region: 'eu-north-1')]) {
                        sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_URL}"
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'docker build -t nestjs .'
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                    sh 'docker push ${ECR_REPO_URL}/nestjs:latest'
                }
            }
        }

        

        stage('Deploy') {
            steps {
                script {
                    sh "kubectl apply -f /home/ubuntu/kubernetes/deploy.yaml"
                    sh "kubectl apply -f /home/ubuntu/kubernetes/service.yaml"
                }
            }
        }
    }
}
