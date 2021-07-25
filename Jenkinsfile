pipeline {
    agent any
    environment{
    
        DOCKER_TAG= getDockerTag()
        
    }
    stages {
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/mayssa-bm/TodoApp']]])
            }
        }
       
        stage('Build Docker image'){
            steps{
                sh "docker build . -t maissa47/todo-app:${DOCKER_TAG}"
            }
        }
        stage('Push Image') {
            steps{    
                withCredentials([string(rcredentialsId: 'dockerhub_id', variable: 'dockerHubPwd')]){
                    sh "docker login -u maissa47 -p ${dockerHubPwd}"
                    sh "docker push maissa47/todo-app:${DOCKER_TAG}"
                }
            }
        }
        stage('Deploy to k8s') {
            steps{
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
            }

    }
}

def getDockerTag(){
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}